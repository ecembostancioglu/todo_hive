import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              title: Text("My title"),
              content: Text("This is my message."),
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
