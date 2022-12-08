import 'package:code_companion/services/contest_services.dart';
import 'package:code_companion/services/remote_services.dart';
import 'package:code_companion/theme.dart';
import 'package:code_companion/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => RemoteService())),
        ChangeNotifierProvider(create: ((context) => ContestServices())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        themeMode: ThemeMode.light,
        title: 'Contests',
        home: const HomePage(),
      ),
    );
  }
}
