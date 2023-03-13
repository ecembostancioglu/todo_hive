
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_hive/app.dart';
import 'package:todo_hive/bloc/todo_bloc.dart';
import 'package:todo_hive/constants/color_constants.dart';
import 'package:todo_hive/data/local_storage.dart';

import 'model/todo.dart';

final locator=GetIt.instance;

void setup(){
  locator.registerSingleton<LocalStorage>(HiveLocalStorage());
}

Future<void> setupHive()async{
  await Hive.initFlutter();
  Hive.registerAdapter(TodoAdapter());
  var todoBox=await Hive.openBox<Todo>('todos');
    for(var todo in todoBox.values) {
    if(todo.createdAt.day != DateTime.now().day){
      todoBox.delete(todo.id);
    }
  };
}

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: ColorConstants.transparent));
  await setupHive();

  setup();
  runApp(BlocProvider(
      create: (context)=> TodoBloc(locator.get()),
      child: MyApp()));
}
