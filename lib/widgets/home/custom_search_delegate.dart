import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo_hive/constants/text_constants.dart';
import 'package:todo_hive/widgets/home/todo_card.dart';

import '../../model/todo.dart';

class CustomSearchDelegate extends SearchDelegate{

  List<Todo> allTodos;

  CustomSearchDelegate({required this.allTodos});

  @override
  List<Widget> buildActions(BuildContext context) {

    bool searchIcon=false;

    return [
      IconButton(
          onPressed: (){
           if(searchIcon==true){
             query.isEmpty ? null : query=='';
           }
           else{
             close(context,null);
           }
        },
          icon:Icon(
              Icons.clear,
              color: Theme.of(context).primaryColor)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return Container();
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Todo> filteredList=allTodos.where((todo)
    => todo.name.toLowerCase().contains(query.toLowerCase())).toList();
    return filteredList.isNotEmpty
        ? ListView.builder(
         physics: const BouncingScrollPhysics(),
         itemCount: filteredList.length,
         itemBuilder: (context, index) {
          return TodoCard(state: filteredList[index]);
        })
        : Center(
         child: Text(
            TextConstants.no_search_found,
            style: Theme.of(context).textTheme.titleMedium));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Todo> filteredList=allTodos.where((todo)
    => todo.name.toLowerCase().contains(query.toLowerCase())).toList();
    return filteredList.isNotEmpty
        ? ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: filteredList.length,
        itemBuilder: (context, index) {
          return TodoCard(state: filteredList[index]);

        })
        : Center(
         child: Text(
            TextConstants.no_search_found,
            style: Theme.of(context).textTheme.titleMedium).tr());
  }

}