import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_hive/app.dart';
import 'package:todo_hive/constants/color_constants.dart';

Future<void> main() async{
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: ColorConstants.transparent));
  await Hive.initFlutter();
  runApp(const MyApp());
}
