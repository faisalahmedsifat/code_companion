import 'package:flutter/cupertino.dart';

import '../models/contests.dart';
import '../models/user_ratings/user_ratings.dart';
import '../models/users/users.dart';
import 'package:http/http.dart' as http;

import '../utils/utils.dart';

class ContestServices with ChangeNotifier {
  ContestsApiResult? contests;
  Users? users;
  UserRatings? userRatings;

  List<Contest>? contestList;

  bool isLoaded = false;
  String lastUpdated = "";
  late http.Client client;

  ContestServices() {
    client = http.Client();
  }

  Future<ContestsApiResult?> getContests() async {
    var uri = Uri.parse("https://codeforces.com/api/contest.list?gym=false");
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      contests = contestsFromJson(json);
      // notifyListeners();
      if (contests?.status == "OK") {
        contestList = [];
        for (var contest in contests!.result) {
          if (contest.phase == "RUNNING") {
            contestList!.add(contest);
          }
          if (contest.phase == "BEFORE") {
            contestList!.add(contest);
          }
        }
        contestList!
            .sort((a, b) => a.startTimeSeconds.compareTo(b.startTimeSeconds));
        lastUpdated = "last updated: " + Utils.getTimeNow();
        isLoaded = true;
        notifyListeners();
      }
      // return contestsFromJson(json);
    }
    return null;
  }
}
