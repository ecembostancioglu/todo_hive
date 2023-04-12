import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:todo_hive/constants/text_constants.dart';
import 'package:todo_hive/data/local_storage.dart';
import 'package:todo_hive/main.dart';
import 'package:todo_hive/widgets/home/custom_search_delegate.dart';
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
  late LocalStorage localStorage;
  TextEditingController textEditingController=TextEditingController();
  dynamic newTodo;


  String formattedDay=DateFormat.d().format(DateTime.now());
  String formattedYear=DateFormat.y().format(DateTime.now());
  String formattedMonth=DateFormat.MMMM().format(DateTime.now());



  void getAllTodoFromDb()async{
    localStorage=locator<LocalStorage>();
    _allTodos=await localStorage.getAllTodos();
     BlocProvider.of<TodoBloc>(context).add(GetAllTodos(todo: _allTodos));
  }

  @override
  void initState() {
    super.initState();
    _allTodos = <Todo>[];
    getAllTodoFromDb();
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
          const Spacer(),
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
              decoration: InputDecoration(
                  hintText: TextConstants.add_task.tr(),
                  hintStyle:const TextStyle(
                      color: ColorConstants.hintTextColor
                  )
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text(TextConstants.add).tr(),
          onPressed: () async{
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
        title: Text(TextConstants.appBarTitle).tr(),
        actions: [
          IconButton(
              onPressed: () {
                _showSearchPage();
              },
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
                  return TodoCard(state: state.allTodos[index]);
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

  void _showSearchPage() async{
    await showSearch(
        context: context,
        delegate: CustomSearchDelegate(allTodos: _allTodos));
    getAllTodoFromDb();
  }

}


