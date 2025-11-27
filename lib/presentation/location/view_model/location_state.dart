part of 'location_view_model.dart';

final class LocationState extends Equatable {
  final bool isLoading;
  final String? errorMessage;
  final OrderFirestoreEntity? order;
  final Set<Marker> markers;
  final Set<Polyline> polylines;

  const LocationState({
    this.isLoading = true,
    this.errorMessage,
    this.order,
    this.markers = const {},
    this.polylines = const {},
  });

  LocationState copyWith({
    bool? isLoading,
    String? errorMessage,
    OrderFirestoreEntity? order,
    Set<Marker>? markers,
    Set<Polyline>? polylines,
  }) {
    return LocationState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      order: order ?? this.order,
      markers: markers ?? this.markers,
      polylines: polylines ?? this.polylines,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    errorMessage,
    order,
    markers,
    polylines,
  ];
}
