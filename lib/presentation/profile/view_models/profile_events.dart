import 'dart:io';

sealed class ProfileEvents {}

class OnGetLoggedDriverDataUseCaseEvent extends ProfileEvents {}

class OnGetVehicleEvent extends ProfileEvents {
  String id;
  OnGetVehicleEvent({required this.id});
}

class OnEditProfileEvent extends ProfileEvents {}

class OnUploadProfileImageEvent extends ProfileEvents {
  final File file;
  OnUploadProfileImageEvent({required this.file});
}
