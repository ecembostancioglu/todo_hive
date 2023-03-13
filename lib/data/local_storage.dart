import 'package:hive/hive.dart';

import '../model/todo.dart';

abstract class LocalStorage{
  Future<void> addTodo({required Todo todo});
  List<Todo> getAllTodos();
  Future<bool> deleteTodo({required Todo todo});
}


class HiveLocalStorage extends LocalStorage{

  late Box<Todo> _todoBox;

  HiveLocalStorage(){
    _todoBox=Hive.box<Todo>('todos');
  }

  @override
  Future<void> addTodo({required Todo todo}) async{
   await _todoBox.add(todo);
  }

  @override
  Future<bool> deleteTodo({required Todo todo}) async {
    await todo.delete();
    getAllTodos();
    return true;
  }

  @override
  List<Todo> getAllTodos() {
    List<Todo> allTodos=<Todo>[];
    allTodos=_todoBox.values.toList();

    if(allTodos.isNotEmpty){
      allTodos.sort((Todo a, Todo b)=>a.createdAt.compareTo(b.createdAt));
    }
    return allTodos;

  }

}