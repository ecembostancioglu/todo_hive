part of 'todo_bloc.dart';

class TodoState extends Equatable{
  final List<Todo> allTodos;
  const TodoState({this.allTodos=const<Todo>[]});

  @override
  // TODO: implement props
  List<Object?> get props => [allTodos];
}
