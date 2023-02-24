import 'package:flutter/material.dart';
import 'package:todo_hive/constants/text_constants.dart';
import 'package:todo_hive/constants/widgets/alert_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text(TextConstants.appBarTitle),
        actions: [
          IconButton(
              onPressed: (){},
              icon: const Icon(Icons.search)),
        ],
      ),
      body: Column(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          AlertWidget().buildShowDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }


}
