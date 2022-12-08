import 'package:code_companion/services/contest_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/remote_services.dart';
import '../widgets/card_view.dart';

class ContestListPage extends StatefulWidget {
  const ContestListPage({Key? key}) : super(key: key);

  @override
  State<ContestListPage> createState() => _ContestListPageState();
}

class _ContestListPageState extends State<ContestListPage> {
  late ContestServices contestServices;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    contestServices = Provider.of<ContestServices>(context);
    contestServices.getContests();
  }

  // retrieveData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? stringData = prefs.getString('data');
  //   if (stringData != null) {
  //     List dataList = jsonDecode(stringData as String);

  //     for (var data in dataList) {
  //       ans.add(ContestList.fromJson(data));
  //     }
  //     setState(() {
  //       isLoaded = true;
  //       lastUpdated = prefs.getString('lastupdate')!;
  //     });
  //   }
  //   getContests();
  // }

  // storeData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   List dataList = ans.map((e) => e.toJson()).toList();
  //   prefs.setString('data', jsonEncode(dataList));
  //   prefs.setString('lastupdate', lastUpdated);
  // }

  // getContests() async {
  //   var today = DateTime.now();
  //   contests = await RemoteService().getContests();
  //   result = contests?.result;
  //   if (contests != null) {
  //     ans = [];
  //     for (var res in result!) {
  //       if (today.isBefore(
  //           DateTime.fromMillisecondsSinceEpoch(res.startTimeSeconds * 1000))) {
  //         ans.add(res);
  //       }
  //     }
  //     ans.sort((a, b) => a.startTimeSeconds.compareTo(b.startTimeSeconds));
  //     storeData();
  //     try {
  //       setState(() {
  //         isLoaded = true;
  //         lastUpdated = "last updated: " + Utils.getTimeNow();
  //       });
  //     } catch (e) {
  //       if (kDebugMode) {
  //         print(e.toString());
  //       }
  //     }
  //   }
  //   getContests();
  // }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: contestServices.isLoaded,
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Center(child: Text(contestServices.lastUpdated)),
          ),
          Expanded(
            flex: 15,
            child: ListView.builder(
              itemBuilder: ((context, index) {
                return CardView(result: contestServices.contestList![index]);
              }),
              itemCount: contestServices.contestList?.length,
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
