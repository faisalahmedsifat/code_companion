import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  String lastUpdated = "";
  bool isOnline = true;

  @override
  void initState() {
    super.initState();
    retrieveData();
    getContests();
  }

  Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('www.codeforces.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  retrieveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? stringData = prefs.getString('data');
    List dataList = jsonDecode(stringData!);

    for (var data in dataList) {
      ans.add(Result.fromJson(data));
    }
    setState(() {
      isLoaded = true;
      lastUpdated = prefs.getString('lastupdate')!;
    });
  }

  storeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List dataList = ans.map((e) => e.toJson()).toList();
    prefs.setString('data', jsonEncode(dataList));
    prefs.setString('lastupdate', lastUpdated);
  }

  getContests() async {
    var today = DateTime.now();
    isOnline = await hasNetwork();
    try {
      contests = await RemoteService().getContests();
    } catch (Ex) {
      print('connection error');
    }
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
      setState(() {
        isLoaded = true;
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
            child: Center(
                child: isOnline
                    ? Text(lastUpdated)
                    : Text('Connection error.. ' + lastUpdated)),
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
