
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../data/local_storage.dart';
import '../model/todo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {

  final LocalStorage localStorage;

  TodoBloc(this.localStorage) : super(const TodoState()) {
    on<AddTodo>(_addTodo);
    on<DeleteTodo>(_deleteTodo);
    on<GetAllTodos>(_getAllTodos);
    on<CompleteTodo>(_completeTodo);
  }

  void _addTodo(AddTodo event,Emitter<TodoState> emit){
    final state=this.state;
    localStorage.addTodo(todo: event.todo);
    emit(TodoState(allTodos: List.from(state.allTodos)..add(event.todo)));
  }

  void _deleteTodo(DeleteTodo event,Emitter<TodoState> emit){
    final state=this.state;
    localStorage.deleteTodo(todo: event.todo);
    emit(TodoState(allTodos: List.from(state.allTodos)..remove(event.todo)));
  }

  void _getAllTodos(GetAllTodos event,Emitter<TodoState> emit){
    final todos=localStorage.getAllTodos();
    emit(TodoState(allTodos: List.from(todos)));
  }

  void _completeTodo(CompleteTodo event, Emitter<TodoState> emit) {
    final state = this.state;
    final updatedTodo = event.todo.copyWith(isDone: !event.todo.isDone);
    localStorage.completedTodo(todo: updatedTodo);
    final updatedAllTodos = List.from(state.allTodos);
    final todoIndex = updatedAllTodos.indexWhere((todo) => todo.id == updatedTodo.id);
    updatedAllTodos[todoIndex] = updatedTodo;
    emit(TodoState(allTodos: List<Todo>.from(updatedAllTodos)));
  }



}
