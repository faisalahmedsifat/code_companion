import 'dart:convert';

import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:code_companion/widgets/card_view.dart';
import '../models/contests.dart';
import '../services/remote_services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    getContests();
  }

  retrieveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? stringData = prefs.getString('data');
    List dataList = jsonDecode(stringData!);

    for (var data in dataList) {
      setState(() {
        ans.add(Result.fromJson(data));
        isLoaded = true;
      });
    }
  }

  storeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List dataList = ans.map((e) => e.toJson()).toList();
    prefs.setString('data', jsonEncode(dataList));
  }

  getContests() async {
    contests = await RemoteService().getContests();
    result = contests?.result;
    if (contests != null) {
      var today = DateTime.now();
      ans = [];
      for (var res in result!) {
        if (today.isBefore(
            DateTime.fromMillisecondsSinceEpoch(res.startTimeSeconds * 1000))) {
          ans.add(res);
        }
      }
      ans.sort((a, b) => a.startTimeSeconds.compareTo(b.startTimeSeconds));
      storeData();
      setState(() {
        isLoaded = true;
        lastUpdated = DateTime.now().toString();
        // writeStorage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contests"),
      ),
      body: Visibility(
        visible: isLoaded,
        child: ListView.builder(
          itemBuilder: ((context, index) {
            return CardView(result: ans[index]);
          }),
          itemCount: ans.length,
        ),
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
