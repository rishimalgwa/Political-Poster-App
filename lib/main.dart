import 'package:flutter/material.dart';
import 'package:political_poster_app/src/app.dart';
import 'package:political_poster_app/src/common/di/di.dart';
import 'package:political_poster_app/src/services/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await HiveServices.init();
  runApp(MainApp());
}
