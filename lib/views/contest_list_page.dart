import 'dart:convert';

import 'package:code_companion/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/contests.dart';
import '../services/remote_services.dart';
import '../utils/utils.dart';
import '../widgets/card_view.dart';

class ContestListPage extends StatefulWidget {
  const ContestListPage({Key? key}) : super(key: key);

  @override
  State<ContestListPage> createState() => _ContestListPageState();
}

class _ContestListPageState extends State<ContestListPage> {
  Contests? contests;
  var isLoaded = false;
  List<Result>? result;
  List<Result> ans = [];
  // final box = GetStorage();
  String lastUpdated = "";

  @override
  void initState() {
    super.initState();
    retrieveData();
    // getContests();
  }

  retrieveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? stringData = prefs.getString('data');
    if (stringData != null) {
      List dataList = jsonDecode(stringData as String);

      for (var data in dataList) {
        ans.add(Result.fromJson(data));
      }
      setState(() {
        isLoaded = true;
        lastUpdated = prefs.getString('lastupdate')!;
      });
    }
  }

  storeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List dataList = ans.map((e) => e.toJson()).toList();
    prefs.setString('data', jsonEncode(dataList));
    prefs.setString('lastupdate', lastUpdated);
  }

  getContests() async {
    var today = DateTime.now();
    contests = await RemoteService().getContests();
    result = contests?.result;
    if (contests != null) {
      ans = [];
      for (var res in result!) {
        if (today.isBefore(
            DateTime.fromMillisecondsSinceEpoch(res.startTimeSeconds * 1000))) {
          ans.add(res);
        }
      }
      ans.sort((a, b) => a.startTimeSeconds.compareTo(b.startTimeSeconds));
      storeData();
      try {
        setState(() {
          isLoaded = true;
          lastUpdated = "last updated: " + Utils.getTimeNow();
        });
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
      }
    }
    getContests();
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
                return CardView(result: ans[index]);
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
  }
}
