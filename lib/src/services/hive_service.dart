import 'package:hive_flutter/hive_flutter.dart';
import 'package:political_poster_app/src/core/persistence/constants.dart';
import 'package:political_poster_app/src/features/auth/data/user_model.dart';

class HiveServices {
  // add all hive
  static Future<void> init() async {
    // register hive
    await Hive.initFlutter();
    //register adapters
    Hive.registerAdapter(UserModelAdapter());

    // //open boxes
    await Hive.openBox<UserModel>(USER_BOX);
  }
}
