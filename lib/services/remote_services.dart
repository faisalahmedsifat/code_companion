import '../models/contests.dart';
import 'package:http/http.dart' as http;

import '../models/profiles.dart';

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

  Future<Profile> getProfile() async {
    var client = http.Client();
    var uri =
        Uri.parse("https://codeforces.com/api/user.info?handles=arian_hasan");
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return profileFromJson(json);
    }
    return Profile(status: "400", result: []);
  }
}
