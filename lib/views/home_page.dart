import 'package:code_companion/models/contests.dart';
import 'package:code_companion/services/remote_services.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Contests? contests;
  var isLoaded = false;
  List<Result>? result;

  @override
  void initState() {
    super.initState();
    getContests();
  }

  getContests() async {
    contests = await RemoteService().getContests();
    result = contests?.result;
    if (contests != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("API call"),
      ),
      body: Visibility(
        visible: isLoaded,
        child: ListView.builder(
          itemBuilder: ((context, index) {
            return Container(
              child: Text(result![index].name),
            );
          }),
          itemCount: contests?.result.length,
        ),
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
