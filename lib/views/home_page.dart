import 'package:add_2_calendar/add_2_calendar.dart';
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
  List<Result> ans = [];

  @override
  void initState() {
    super.initState();
    // compareTime(1650378900);
    getContests();
  }

  getContests() async {
    contests = await RemoteService().getContests();
    result = contests?.result;
    if (contests != null) {
      var today = DateTime.now();

      for (var res in result!) {
        if (today.isBefore(
            DateTime.fromMillisecondsSinceEpoch(res.startTimeSeconds * 1000))) {
          ans.add(res);
        }
      }
      ans.sort((a, b) => a.startTimeSeconds.compareTo(b.startTimeSeconds));
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

  isAfterTime(int time) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    DateTime today = DateTime.now();
    // print(date.toString() + " " + today.toString());
    return (date.isAfter(today));
  }

  addToCalendar(Result res) {
    return Event(
      title: res.name,
      description: res.type.toString(),
      location: 'Event location',
      startDate:
          DateTime.fromMillisecondsSinceEpoch(res.startTimeSeconds * 1000),
      endDate: DateTime.fromMillisecondsSinceEpoch(
          res.startTimeSeconds * 1000 + res.durationSeconds * 1000),
    );
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
                flex: 9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // color: Colors.red,
                    Text(
                      ans[index].name,
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
                        getTime(ans[index].startTimeSeconds),
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      Add2Calendar.addEvent2Cal(addToCalendar(ans[index]));
                    },
                    child: const Icon(
                      Icons.calendar_today_outlined,
                    ),
                  ),
                ),
              ),
            ]);
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
