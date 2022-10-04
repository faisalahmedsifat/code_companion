import 'dart:convert';

import 'package:code_companion/services/remote_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/users/result.dart';
import '../models/users/users.dart';
import '../theme.dart';
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
  var isEmpty = false;

  TextEditingController textEditingController = TextEditingController();

  List<String> addedUserNames = [];

  @override
  void initState() {
    super.initState();
    retrieveData();
  }

  retrieveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? stringData = prefs.getString('user_data');
    if (stringData != null) {
      List dataList = jsonDecode(stringData);

      for (var data in dataList) {
        ans.add(User.fromJson(data));
      }
      for (var user in ans) {
        addedUserNames.add(user.handle as String);
      }
      setState(() {
        isLoaded = true;
        isEmpty = false;
        lastUpdated = prefs.getString('last_user_update')!;
      });
    }
    getUsers();
  }

  storeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List dataList = ans.map((e) => e.toJson()).toList();
    prefs.setString('user_data', jsonEncode(dataList));
    prefs.setString('last_user_update', lastUpdated);
  }

  getUsers() async {
    try {
      users = await RemoteService().getUsers(addedUserNames);
    } catch (e) {
      Fluttertoast.showToast(
          msg: "No user found",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColors.toastColor,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    result = users?.users;
    if (users != null) {
      ans = [];
      for (var res in result!) {
        ans.add(res);
      }
      ans.sort((a, b) => (b.rating as int).compareTo(a.rating as int));
      // storeData();
      try {
        setState(() {
          isLoaded = true;
          isEmpty = false;
          storeData();
          lastUpdated = "last updated: " + Utils.getTimeNow();
        });
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
      }
    }
    if (addedUserNames.isEmpty) {
      setState(() {
        isEmpty = true;
        isLoaded = true;
      });
    }
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Add User'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              controller: textEditingController,
              decoration: const InputDecoration(hintText: "Username here"),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  setState(() {
                    userNameToSearch = valueText;
                    valueText = null;
                    textEditingController.clear();
                    addUsersToTrack(userNameToSearch as String);
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }

  String? valueText;
  String? userNameToSearch;

  addUsersToTrack(String name) async {
    checkIfUserExists(name);
  }

  checkIfUserExists(String name) async {
    try {
      users = await RemoteService().getUsers([name]);
    } catch (e) {
      Fluttertoast.showToast(
          msg: "No user found",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColors.toastColor,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    addedUserNames.add(name);
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isLoaded,
      child: Scaffold(
        body: isEmpty
            ? const Text('No Users Added')
            : Column(
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // addUsersToTrack();
            _displayTextInputDialog(context);
          },
          child: const Icon(Icons.add),
        ),
      ),
      replacement: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
