import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import '../color_constants.dart';
import '../text_constants.dart';

class AlertWidget{

  Future<dynamic> buildShowDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            shape:RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            ),
            title: Text(TextConstants.gorevEkle,
            style: Theme.of(context).textTheme.titleMedium),
            content: const TextField(
              style: TextStyle(
                  color: ColorConstants.primaryColor
              ),
              decoration: InputDecoration(
                  hintText: TextConstants.gorevGiriniz,
                  hintStyle: TextStyle(
                      color: ColorConstants.hintTextColor
                  )
              ),
            ),
            actions: [
              TextButton(
                child: const Text(TextConstants.ekle),
                onPressed: () {
                  Navigator.pop(context);
                  DatePicker.showTimePicker(
                      context,showSecondsColumn: false,
                      onConfirm: (time){},
                      theme:const DatePickerTheme(
                        doneStyle: TextStyle(
                          color: ColorConstants.titleColor,
                          fontWeight: FontWeight.w500
                        ),
                        headerColor: ColorConstants.scaffoldColor
                      ) );
                },
              )
            ],
          );
        });
  }
}