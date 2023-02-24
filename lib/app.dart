import 'package:flutter/material.dart';
import 'package:todo_hive/constants/color_constants.dart';
import 'package:todo_hive/views/home.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: ColorConstants().themeDataPrimaryColor,
        appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black
          )
        )
      ),
      home: HomePage(),
    );
  }
}
