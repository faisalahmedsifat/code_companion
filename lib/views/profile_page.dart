import 'package:code_companion/widgets/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/profiles.dart';
import '../services/remote_services.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Profile? profile;
  var isLoaded = false;
  // ResultProfile result = ResultProfile(
  //     lastName: "lastName",
  //     country: "country",
  //     lastOnlineTimeSeconds: 0,
  //     city: "city",
  //     rating: 99,
  //     friendOfCount: 69,
  //     titlePhoto: "titlePhoto",
  //     handle: "handle",
  //     avatar: "avatar",
  //     firstName: "firstName",
  //     contribution: 0,
  //     organization: "organization",
  //     rank: "rank",
  //     maxRating: 999,
  //     registrationTimeSeconds: 00000,
  //     email: "email",
  //     maxRank: "maxRank");
  ResultProfile result = ResultProfile();

  // String lastUpdated = "";
  bool isOnline = true;

  @override
  void initState() {
    super.initState();
    retrieveData();
    getProfile();
  }

  retrieveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? stringData = prefs.getString('profiledata');
    profile = profileFromJson(stringData as String);
    result = profile?.result![0] as ResultProfile;
    // print(result.lastName);
    setState(() {
      isLoaded = true;
    });
  }

  storeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('profiledata', profileToJson(profile as Profile));
    // print(prefs.getString('data'));
  }

  getProfile() async {
    try {
      profile = await RemoteService().getProfile();
    } catch (Ex) {
      print('connection error');
    }
    storeData();
    if (profile != null) {
      setState(() {
        result = profile?.result![0] as ResultProfile;
        isLoaded = true;
      });
    }
    print(result.titlePhoto);
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isLoaded,
      child: ProfileView(result: result),
      replacement: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
