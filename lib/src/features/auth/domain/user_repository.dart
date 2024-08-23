import 'package:political_poster_app/src/common/di/di.dart';
import 'package:political_poster_app/src/features/auth/data/user_model.dart';
import 'package:political_poster_app/src/features/auth/domain/persistence/user_dao.dart';

class UserRepository {
  final _userDao = getIt<GetUserDao>();

  Future<bool> isUserExist() async {
    UserModel? user = _userDao.getUser();
    return user != null;
  }

  Future<bool> createUser({required UserModel user}) async {
    try {
      await _userDao.saveUser(user);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> deleteUser() async {
    await _userDao.clearUser();
  }
}
