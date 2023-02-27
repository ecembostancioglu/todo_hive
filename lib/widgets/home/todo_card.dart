import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_hive/constants/color_constants.dart';
import 'package:todo_hive/extensions/string_extension.dart';
import '../../bloc/todo_bloc.dart';

class TodoCard extends StatefulWidget {
   TodoCard({
    required this.state,
    Key? key,
  }) : super(key: key);

   final dynamic state;

   @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.25,
        children: [
          SlidableAction(
            borderRadius:BorderRadius.circular(20),
              backgroundColor:ColorConstants.deleteColor,
              icon:Icons.delete,
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              onPressed: (context){
                BlocProvider.of<TodoBloc>(context).add(DeleteTodo(todo: widget.state));
              }),
        ],
      ),
      child: SizedBox(
        height: 80.w,
        child: Card(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))
          ),
          color: Theme.of(context).primaryColor,
          elevation: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                splashFactory: NoSplash.splashFactory,
                onTap: (){
                 setState(() {
                   widget.state.isDone = !widget.state.isDone;
                 });
                },
                child: Container(
                  margin: EdgeInsets.only(left: 10.w),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.state.isDone
                        ? ColorConstants.todoCompleted
                        : ColorConstants.todoNotCompleted
                  ),
                  child: const Icon(Icons.check),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: SizedBox(
                  width: 250.w,
                  child: widget.state.isDone
                      ? Text(widget.state.name.toString().capitalize(),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.titleMedium?.color,
                        decoration: TextDecoration.lineThrough,
                        fontSize: Theme.of(context).textTheme.titleMedium?.fontSize
                      ))
                      :Text(widget.state.name.toString().capitalize(),
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium)
                )
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: Text('${widget.state.createdAt.hour}:${widget.state.createdAt.minute}',
                    style: Theme.of(context).textTheme.titleMedium),
              ),
            ],
          ),
        ),
      ),
    );
  }
}