import 'package:code_companion/models/contests.dart';
import 'package:code_companion/services/remote_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  getTime(int time) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    String d = DateFormat.MMMd().format(date);
    String ti = DateFormat.jm().format(date);
    String string = d + " " + ti;
    return string;
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
            return Row(children: [
              const Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    child: Text(
                      'Codeforces',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 9 ,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // color: Colors.red,
                    Text(
                      result![index].name,
                      // maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        getTime(result![index].startTimeSeconds),
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
              const Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.center,
                  child: Icon(Icons.calendar_today_outlined),
                ),
              ),
            ]);
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
