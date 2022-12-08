import 'package:flutter/cupertino.dart';

import '../models/contests.dart';
import 'package:http/http.dart' as http;

import '../models/user_ratings/user_ratings.dart';
import '../models/users/users.dart';
import '../utils/utils.dart';

class RemoteService with ChangeNotifier {
  ContestsApiResult? contests;
  Users? users;
  UserRatings? userRatings;

  List<Contest>? contestList;

  bool isLoaded = false;
  String lastUpdated = "";

  late http.Client client;

  RemoteService() {
    client = http.Client();
  }
 
  Future<Users?> getUsers(List<String> userNames) async {
    String url = "https://codeforces.com/api/user.info?handles=";
    for (var userNameIndex = 1;
        userNameIndex <= userNames.length;
        userNameIndex++) {
      url = url + userNames[userNameIndex - 1];
      if (userNameIndex != userNames.length) url += ";";
    }
    var uri = Uri.parse(url);
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      users = Users.fromJson(json);
      notifyListeners();
      return users;
    } else {
      // throw Exception('no user found');
      return null;
    }
  }

  Future<UserRatings?> getUserRating(String userName) async {
    String url = "https://codeforces.com/api/user.rating?handles=$userName";
    var uri = Uri.parse(url);
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      userRatings = UserRatings.fromJson(json);
      notifyListeners();
      return userRatings;
    } else {
      // throw Exception('no user found');
      return null;
    }
  }
}
