import 'package:elevate_tracking_app/core/constants/const_keys.dart';
import 'package:elevate_tracking_app/data/data_source/auth_local_data_source.dart';
import 'package:elevate_tracking_app/domain/entites/requests/login_request_entity.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final FlutterSecureStorage _secureStorage;

  AuthLocalDataSourceImpl(this._secureStorage);

  @override
  Future<void> saveUserRememberMe({
    required LoginRequestEntity loginRequestEntity,
  }) async {
    final isRememberMe = await _secureStorage.read(
      key: ConstKeys.keyRememberMe,
    );
    if (isRememberMe == ConstKeys.trueKey) {
      await _secureStorage.write(
        key: ConstKeys.kUserLogin,
        value: loginRequestEntity.email,
      );
      await _secureStorage.write(
        key: ConstKeys.kUserPassword,
        value: loginRequestEntity.password,
      );
    }else{
      await _secureStorage.delete(key: ConstKeys.kUserLogin);
      await _secureStorage.delete(key: ConstKeys.kUserPassword);
    }
  }

  @override
  Future<void> saveUserToken({required String token}) async {
    await _secureStorage.write(key: ConstKeys.keyUserToken, value: token);
  }
}
