import 'package:flutter/material.dart';

class SearchGroups extends StatefulWidget {
  const SearchGroups({super.key});

  @override
  State<SearchGroups> createState() => _SearchGroupsState();
}

class _SearchGroupsState extends State<SearchGroups> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text("Search Njangi Groups",style:Theme.of(context).textTheme.displayMedium),

     
      ),

  
    );
  }
}