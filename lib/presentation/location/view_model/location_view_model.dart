import 'dart:async';

import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/core/constants/app_colors.dart';
import 'package:elevate_tracking_app/core/constants/app_images.dart';
import 'package:elevate_tracking_app/domain/entites/order_firestore_entity.dart';
import 'package:elevate_tracking_app/domain/use_cases/add_order_to_firestore_use_case.dart';
import 'package:elevate_tracking_app/generated/l10n.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/utils/location_manager.dart';
import '../../../domain/entites/live_location_entity.dart';
import '../../../domain/use_cases/get_order_from_firestore_use_case.dart';
import 'location_events.dart';

part 'location_state.dart';

@injectable
class LocationViewModel extends Cubit<LocationState> {
  final GetOrderFromFirestoreUseCase _getOrderFromFirestoreUseCase;
  final AddOrderToFirestoreUseCase _addOrderToFirestoreUseCase;

  LocationViewModel(
    this._getOrderFromFirestoreUseCase,
    this._addOrderToFirestoreUseCase,
  ) : super(const LocationState());

  late final bool isUser;

  GoogleMapController? mapController;

  late LatLng currentLocation;
  late final LatLng destinationLocation;
  late final String destinationTitle;
  LatLng? liveLocation;

  late final BitmapDescriptor yourLocationIcon;
  late final BitmapDescriptor storeIcon;
  late final BitmapDescriptor userIcon;
  late final BitmapDescriptor liveLocationIcon;

  Set<Marker> markers = {};
  Set<Polyline> polylines = {};
  StreamSubscription<Position>? positionStream;

  void doIntent(LocationEvents events) {
    switch (events) {
      case GetOrderLocationEvent():
        _getOrder(events.orderId, events.isUser);
      case LunchCallLocationEvent():
        _callNumber(events.phoneNumber);
      case LunchWhatsAppLocationEvent():
        _openWhatsApp(phone: events.phoneNumber);
    }
  }

  Future<void> _getOrder(String orderId, bool isUser) async {
    this.isUser = isUser;
    final result = await _getOrderFromFirestoreUseCase(orderId: orderId);
    switch (result) {
      case ApiSuccessResult<OrderFirestoreEntity>():
        await initIcons();
        initDestinationLocation(result.data);
        await initCurrentLocation();
        initMarkers();
        emit(
          state.copyWith(
            isLoading: false,
            order: result.data,
            markers: markers,
            polylines: polylines,
          ),
        );
        await _startLiveLocationUpdates();
      case ApiErrorResult<OrderFirestoreEntity>():
        emit(
          state.copyWith(isLoading: false, errorMessage: result.errorMessage),
        );
    }
  }

  Future<void> initIcons() async {
    yourLocationIcon = await BitmapDescriptor.asset(
      ImageConfiguration.empty,
      AppImages.imageYourLocation,
    );
    storeIcon = await BitmapDescriptor.asset(
      ImageConfiguration.empty,
      AppImages.imageFloweryLocation,
    );
    userIcon = await BitmapDescriptor.asset(
      ImageConfiguration.empty,
      AppImages.imageUserLocation,
    );
    liveLocationIcon = await BitmapDescriptor.asset(
      ImageConfiguration.empty,
      AppImages.imageMotorcycleDelivery,
    );
  }

  void initDestinationLocation(OrderFirestoreEntity result) {
    if (isUser) {
      destinationLocation = LatLng(
        double.parse(result.order?.shippingAddress?.lat ?? "0"),
        double.parse(result.order?.shippingAddress?.long ?? "0"),
      );
      destinationTitle = AppLocalizations().user;
    } else {
      final latLongString = result.order?.store?.latLong ?? "0,0";
      final latLongList = latLongString.split(',');

      destinationLocation = LatLng(
        double.parse(latLongList[0]),
        double.parse(latLongList[1]),
      );
      destinationTitle = AppLocalizations().flowery;
    }
  }

  Future<void> initCurrentLocation() async {
    try {
      final position = await LocationManager.getCurrentLocation();
      currentLocation = LatLng(position.latitude, position.longitude);
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  void initMarkers() {
    markers.clear();
    markers = {
      buildMarker(
        markerId: AppLocalizations().yourLocation,
        position: currentLocation,
        title: AppLocalizations().yourLocation,
        icon: yourLocationIcon,
      ),
      buildMarker(
        markerId: destinationTitle,
        position: destinationLocation,
        title: destinationTitle,
        icon: isUser ? userIcon : storeIcon,
      ),
    };

    if (liveLocation != null) {
      markers.add(
        buildMarker(
          markerId: AppLocalizations().liveLocation,
          position: liveLocation!,
          title: AppLocalizations().liveLocation,
          icon: liveLocationIcon,
        ),
      );
    }

    polylines.clear();
    polylines = {
      Polyline(
        polylineId: const PolylineId('route'),
        color: AppColors.mainColor,
        width: 2,
        points: [currentLocation, destinationLocation],
      ),
    };
  }

  Future<void> _startLiveLocationUpdates() async {
    try {
      await LocationManager.checkLocationPermission();
      const locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      );
      positionStream =
          Geolocator.getPositionStream(
            locationSettings: locationSettings,
          ).listen((Position position) async {
            liveLocation = LatLng(position.latitude, position.longitude);
            initMarkers();
            mapController?.animateCamera(CameraUpdate.newLatLng(liveLocation!));
            emit(state.copyWith(markers: markers, polylines: polylines));
            await _updateLocation();
          });
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> _updateLocation() async {
    final updatedOrder = state.order?.copyWith(
      location: LiveLocationEntity(
        lat: liveLocation!.latitude.toString(),
        long: liveLocation!.longitude.toString(),
        address: state.order?.location?.address,
      ),
    );
    final result = await _addOrderToFirestoreUseCase(order: updatedOrder!);
    switch (result) {
      case ApiSuccessResult<bool>():
        break;
      case ApiErrorResult<bool>():
        emit(state.copyWith(errorMessage: result.errorMessage));
    }
  }

  Marker buildMarker({
    required String markerId,
    required LatLng position,
    required String title,
    required BitmapDescriptor icon,
  }) {
    return Marker(
      markerId: MarkerId(markerId),
      position: position,
      infoWindow: InfoWindow(title: title),
      icon: icon,
    );
  }

  Future<void> _openWhatsApp({
    required String phone,
    String message = '',
  }) async {
    final Uri whatsappUri = Uri.parse(
      "https://wa.me/$phone?text=${Uri.encodeComponent(message)}",
    );

    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
    } else {
      throw Exception("Could not launch WhatsApp");
    }
  }

  Future<void> _callNumber(String phoneNumber) async {
    final Uri callUri = Uri(scheme: 'tel', path: phoneNumber);

    if (await canLaunchUrl(callUri)) {
      await launchUrl(callUri, mode: LaunchMode.externalApplication);
    } else {
      throw Exception('Could not launch dialer');
    }
  }

  @override
  Future<void> close() {
    positionStream?.cancel();
    return super.close();
  }
}
