import 'package:uuid/uuid.dart';

class Todo{
   String id;
   String name;
   DateTime createdAt;
   bool isDone;

  Todo({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.isDone});
  
  factory Todo.create({required String name,required DateTime createdAt}){
    return Todo(
        id: const Uuid().v1(),
        name: name,
        createdAt: createdAt,
        isDone: false);
  }

}