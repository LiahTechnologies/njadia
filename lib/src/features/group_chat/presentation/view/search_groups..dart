import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:njadia/src/constants/style/color.dart';
import 'package:njadia/src/features/authentication/data/databaseService.dart';
import 'package:njadia/src/utils/CustomButton.dart';
import 'package:njadia/src/warnings/custombackarrow.dart';

class SearchGroups extends StatefulWidget {
  const SearchGroups({super.key});

  @override
  State<SearchGroups> createState() => _SearchGroupsState();
}

class _SearchGroupsState extends State<SearchGroups> {
  final databaseServices = DatabaseServices();

  final TextEditingController groupName = TextEditingController();

  QuerySnapshot? groupList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackArrow(),
       
        centerTitle: true,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text("Search Njangi Groups",
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(fontSize: 16)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 1.w),
                width: 305.w,
                height: 20.h,
                // color: AppColor.grayColor,
                child: TextField(
                  decoration: InputDecoration(
                      //  suffixIcon:
                      ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: Theme.of(context).iconTheme.color,
                ),
                onPressed: () {
                  setState(() {
                    databaseServices.searchbyName(groupName.text);
                  });
                },
              )
            ],
          ),
          // FutureBuilder<QuerySnapshot>(
          //     future: groupList!,
          //     builder: (context, snapshot) {
          //       return ListView.builder(
          //           itemBuilder: (context, Index) => Container());
          //     })
        ],
      ),
    );
  }
}
