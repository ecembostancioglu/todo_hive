import 'package:flutter/material.dart';
import 'package:todo_hive/constants/color_constants.dart';
import 'package:todo_hive/constants/text_constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.white,
      appBar: AppBar(
        title: const Text(TextConstants.appBarTitle),
        actions: [
          IconButton(
              onPressed: (){},
              icon: const Icon(Icons.search)),
        ],
      ),
      body: Column(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          buildShowDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<dynamic> buildShowDialog(BuildContext context) {
    return showDialog(
            context: context,
            builder: (context){
            return AlertDialog(
              title: const Text(TextConstants.gorevEkle),
              content: TextField(
                decoration: InputDecoration(
                  hintText: 'Görev giriniz'
                ),
              ),
              actions: [
             TextButton(
              child: Text("OK"),
               onPressed: () {
                Navigator.pop(context);
               },
               )
              ],
          );
        });
  }
}
