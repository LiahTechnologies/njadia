import 'package:flutter/material.dart';
import 'package:njadia/src/constants/style/color.dart';

class DirectMessage extends StatefulWidget {
  const DirectMessage({super.key});

  @override
  State<DirectMessage> createState() => _DirectMessageState();
}

class _DirectMessageState extends State<DirectMessage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
         backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          automaticallyImplyLeading: false,
          title: Text("Direct Messages",style:  Theme.of(context).textTheme.titleMedium,),
          centerTitle: true,
        ),
    );
  }

  
}