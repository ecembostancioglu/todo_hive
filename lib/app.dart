import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_hive/constants/color_constants.dart';
import 'package:todo_hive/views/home.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize:const Size(360, 690),
        builder: (context,widget){
          return  MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              textTheme: TextTheme(
                titleMedium: TextStyle(
                  color: ColorConstants.titleColor,
                  fontSize: 18.sp
                )
              ),
                fontFamily: 'Didot',
                primarySwatch: ColorConstants.themeDataPrimaryColor,
                appBarTheme: AppBarTheme(
                    titleTextStyle: TextStyle(
                        color: ColorConstants.primaryColor,
                        fontSize:20.sp,
                        fontFamily: 'Didot'
                    ),
                    elevation: 0,
                    backgroundColor: ColorConstants.scaffoldColor,
                    iconTheme: const IconThemeData(
                        color: ColorConstants.primaryColor
                    )
                ),
              scaffoldBackgroundColor: ColorConstants.scaffoldColor
            ),
            home: HomePage(),
          );
        });
  }
}
