import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:todo_hive/constants/text_constants.dart';

import '../bloc/todo_bloc.dart';
import '../constants/color_constants.dart';
import '../model/todo.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late List<Todo> _allTodos;
  TextEditingController textEditingController=TextEditingController();
  var newTodo;
  DateTime? time;


  String formattedDay=DateFormat.d().format(DateTime.now());
  String formattedYear=DateFormat.y().format(DateTime.now());
  String formattedMonth=DateFormat.MMMM().format(DateTime.now());

  @override
  void initState() {
    super.initState();
    _allTodos = <Todo>[];
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(TextConstants.appBarTitle),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search)),
        ],
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if(state is TodoState){
            return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: state.allTodos.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(state.allTodos[index].name),
                    trailing: Text('${state.allTodos[index].createdAt.hour}: ${state.allTodos[index].createdAt.minute}'),
                  );
                });
          }
        return CircularProgressIndicator();
        },

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
            showDialog(
                barrierDismissible: true,
                context: context,
                builder: (context){
                  return buildAlertDialog(context);
                });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  AlertDialog buildAlertDialog(BuildContext context) {
    return AlertDialog(
                shape:RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: (){
                          DatePicker.showTimePicker(
                              context,showSecondsColumn: false,
                              onConfirm: (time){
                                newTodo=Todo.create(
                                    name:textEditingController.text,
                                    createdAt:time);
                              },
                              theme:const DatePickerTheme(
                                  doneStyle: TextStyle(
                                      color: ColorConstants.titleColor,
                                      fontWeight: FontWeight.w500
                                  ),
                                  headerColor: ColorConstants.scaffoldColor
                              ) );
                        },
                        icon: Icon(Icons.date_range_outlined,
                            size: 48.sp)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(formattedDay,style:Theme.of(context).textTheme.headlineLarge),
                        Text(formattedMonth,style:Theme.of(context).textTheme.titleLarge),
                        Text(formattedYear,style:Theme.of(context).textTheme.titleMedium),
                      ],
                    ),
                  ],
                ),
                content: SizedBox(
                  height: 100.w,
                  child: Column(
                    children: [
                      TextField(
                        controller: textEditingController,
                        style: const TextStyle(
                            color: ColorConstants.primaryColor
                        ),
                        decoration: const InputDecoration(
                            hintText: TextConstants.gorevGiriniz,
                            hintStyle: TextStyle(
                                color: ColorConstants.hintTextColor
                            )
                        ),
                      ),
                      SizedBox(
                        height: 10.w,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 40,
                            width: 80,
                            decoration: const BoxDecoration(
                              color: ColorConstants.primaryColor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft:Radius.circular(20)),
                            ),
                            child: time == null
                                ? Center(child: Text('${DateTime.now().hour}'))
                                : Center(child: Text('${time}')),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            height: 40,
                            width: 80,
                            decoration: BoxDecoration(
                              color: ColorConstants.titleColor.withOpacity(0.6),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomRight:Radius.circular(20)),
                            ),
                            child: time == null
                                ? Center(child: Text('${DateTime.now().hour}'))
                                : Center(child: Text('${time}')),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    child: const Text(TextConstants.ekle),
                    onPressed: () {
                      BlocProvider.of<TodoBloc>(context).add(AddTodo(todo: newTodo));
                      Navigator.pop(context);
                    },
                  )
                ],
              );
  }
}
