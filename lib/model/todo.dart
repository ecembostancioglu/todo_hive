import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'todo.g.dart';

@HiveType(typeId: 1)
class Todo extends HiveObject{

   @HiveField(0)
   String id;

   @HiveField(1)
   String name;

   @HiveField(2)
   DateTime createdAt;

   @HiveField(3)
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

   void completedTodo() {
     isDone = !isDone;
   }

}