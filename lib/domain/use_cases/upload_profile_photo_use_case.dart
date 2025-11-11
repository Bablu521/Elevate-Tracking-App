import 'dart:io';
import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/domain/entites/upload_profile_image_response_entity.dart';
import 'package:elevate_tracking_app/domain/repo/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class UploadProfilePhotoUseCase {
  final AuthRepo _authRepo;

  UploadProfilePhotoUseCase(this._authRepo);

  Future<ApiResult<UploadProfileImageResponseEntity>> call(File file) {
    return _authRepo.uploadProfilePhoto(file);
  }
}