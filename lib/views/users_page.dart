import 'dart:convert';

import 'package:code_companion/services/remote_services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/users/result.dart';
import '../models/users/users.dart';
import '../utils/utils.dart';
import '../widgets/user_card_view.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  Users? users;
  List<User>? result;
  List<User> ans = [];
  var isLoaded = false;
  String lastUpdated = "";

  List<String> addedUserNames = [
    "faisalahmed531",
    "arian_hasan",
    "necro_mancer"
  ];

  @override
  void initState() {
    super.initState();
    retrieveData();
    getUsers();
  }

  retrieveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? stringData = prefs.getString('user_data');
    if (stringData != null) {
      List dataList = jsonDecode(stringData);

      for (var data in dataList) {
        ans.add(User.fromJson(data));
      }
      setState(() {
        isLoaded = true;
        lastUpdated = prefs.getString('last_user_update')!;
      });
    }
  }

  storeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List dataList = ans.map((e) => e.toJson()).toList();
    prefs.setString('user_data', jsonEncode(dataList));
    prefs.setString('last_user_update', lastUpdated);
  }

  getUsers() async {
    users = await RemoteService().getUsers(addedUserNames);
    result = users?.users;
    if (users != null) {
      ans = [];
      for (var res in result!) {
        ans.add(res);
      }
      ans.sort((a, b) => b.rating.compareTo(a.rating));
      // storeData();
      setState(() {
        isLoaded = true;
        storeData();
        lastUpdated = "last updated: " + Utils.getTimeNow();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isLoaded,
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Center(child: Text(lastUpdated)),
          ),
          Expanded(
            flex: 15,
            child: ListView.builder(
              itemBuilder: ((context, index) {
                return UserCardView(user: ans[index]);
              }),
              itemCount: ans.length,
            ),
          ),
        ],
      ),
      replacement: const Center(
        child: CircularProgressIndicator(),
      ),
    );
    ;
  }
}
