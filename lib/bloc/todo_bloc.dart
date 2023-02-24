import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../model/todo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(const TodoState()) {
    on<AddTodo>(_addTodo);
    on<DeleteTodo>(_deleteTodo);
  }

  void _addTodo(AddTodo event,Emitter<TodoState> emit){
    final state=this.state;
    emit(TodoState(allTodos: List.from(state.allTodos)..add(event.todo)));
  }

  void _deleteTodo(DeleteTodo event,Emitter<TodoState> emit){
    final state=this.state;
    emit(TodoState(allTodos: List.from(state.allTodos)..remove(event.todo)));
  }

}
