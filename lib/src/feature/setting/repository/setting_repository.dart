import 'package:stockmanagement/src/feature/auth/repository/auth_repository.dart';

class SettingRepository {
  Future<void> logout() async {
    await AuthRepository().logout();
  }
}
