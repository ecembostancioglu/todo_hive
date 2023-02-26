import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:todo_hive/constants/text_constants.dart';
import '../bloc/todo_bloc.dart';
import '../constants/color_constants.dart';
import '../model/todo.dart';
import '../widgets/home/todo_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late List<Todo> _allTodos;
  TextEditingController textEditingController=TextEditingController();
  var newTodo;

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


  AlertDialog buildAlertDialog(BuildContext context) {
    return AlertDialog(
      shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Spacer(),
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
          ],
        ),
      ),
      actions: [
        TextButton(
          child: const Text(TextConstants.ekle),
          onPressed: () {
            newTodo=Todo.create(
                name:textEditingController.text,
                createdAt:DateTime.now());
            BlocProvider.of<TodoBloc>(context).add(AddTodo(todo: newTodo));
            Navigator.pop(context);
            textEditingController.clear();
          },
        )
      ],
    );
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
                  return TodoCard(state:state.allTodos[index]);
                });
          }
          return const Center(
              child: CircularProgressIndicator());
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

}


//   DatePicker.showTimePicker(
//                           context,showSecondsColumn: false,
//                           onConfirm: (time){
//                             newTodo=Todo.create(
//                                 name:textEditingController.text,
//                                 createdAt:DateTime.now());
//                             BlocProvider.of<TodoBloc>(context).add(AddTodo(todo: newTodo));
//                           },
//                           theme:const DatePickerTheme(
//                               doneStyle: TextStyle(
//                                   color: ColorConstants.titleColor,
//                                   fontWeight: FontWeight.w500
//                               ),
//                               headerColor: ColorConstants.scaffoldColor
//                           ) );
