import 'package:injectable/injectable.dart';
import 'package:political_poster_app/src/core/persistence/constants.dart';
import 'package:political_poster_app/src/core/persistence/database.dart';
import 'package:political_poster_app/src/features/auth/data/user_model.dart';

@lazySingleton
class GetUserDao {
  late Database<UserModel> database;

  GetUserDao() {
    database = Database<UserModel>(boxName: USER_BOX);
  }

  Future<void> saveUser(UserModel user) async {
    String key = user.phoneNumber;
    await database.box.put(key, user);
  }

  Future<void> clearUser() async {
    await database.box.clear();
  }

  UserModel? getUser() {
    return database.box.values.toList().isNotEmpty
        ? database.box.values.toList()[0]
        : null;
  }

  bool isLoggedIn() {
    var user = getUser();
    return user?.isLoggedIn ?? false;
  }

  Future<void> logout(UserModel user) async {
    UserModel updatedUser = UserModel(
        name: user.name,
        phoneNumber: user.phoneNumber,
        designation: user.designation,
        photoUrl: user.photoUrl,
        rightPhotoUrl: user.rightPhotoUrl,
        isLoggedIn: false);
    await database.box.put(updatedUser.phoneNumber, updatedUser);
  }
}
