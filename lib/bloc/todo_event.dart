part of 'todo_bloc.dart';

@immutable
abstract class TodoEvent extends Equatable{
  const TodoEvent();

  @override
  List<Object?> get props => [];
}

class AddTodo extends TodoEvent{
  final Todo todo;

  AddTodo({required this.todo});

  @override
  List<Object?> get props => [todo];
}

class DeleteTodo extends TodoEvent{
  final Todo todo;

  DeleteTodo({required this.todo});

  @override
  List<Object?> get props => [todo];
}

class GetAllTodos extends TodoEvent{
  final List<Todo> todo;

  GetAllTodos({required this.todo});

  @override
  List<Object?> get props => [todo];
}

class CompleteTodo extends TodoEvent {
  final Todo todo;

  CompleteTodo({required this.todo});

  @override
  List<Object?> get props => [todo];
}

