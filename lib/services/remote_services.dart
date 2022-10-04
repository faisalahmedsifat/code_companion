import '../models/contests.dart';
import 'package:http/http.dart' as http;

import '../models/users/users.dart';

class RemoteService {
  Future<Contests> getContests() async {
    var client = http.Client();
    var uri = Uri.parse("https://codeforces.com/api/contest.list?gym=false");
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return contestsFromJson(json);
    }
    return Contests(status: "400", result: []);
  }

  Future<Users> getUsers(List<String> userNames) async {
    var client = http.Client();
    String url = "https://codeforces.com/api/user.info?handles=";
    for (var userNameIndex = 1;
        userNameIndex <= userNames.length;
        userNameIndex++) {
      url = url + userNames[userNameIndex - 1];
      if (userNameIndex != userNames.length) url += ";";
    }
    print(url);
    var uri = Uri.parse(url);
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return Users.fromJson(json);
    } else {
      throw Exception('no user found');
    }
  }
}
