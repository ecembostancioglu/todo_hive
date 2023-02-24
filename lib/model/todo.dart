import 'package:uuid/uuid.dart';

class Todo{
  final String id;
  final String name;
  final DateTime createdAt;
  final bool isCompleted;

  Todo({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.isCompleted});
  
  factory Todo.create({required String name,required DateTime createdAt}){
    return Todo(
        id: const Uuid().v1(),
        name: name,
        createdAt: createdAt,
        isCompleted: false);
  }
  
}