import 'package:code_companion/theme.dart';
import 'package:code_companion/views/calendar_page.dart';
import 'package:code_companion/views/contest_list_page.dart';
import 'package:code_companion/views/profile_page.dart';
import 'package:code_companion/views/users_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final pageTitles = const [
    'Contests',
    'Calendar',
    'Users',
    'Profile',
  ];

  final pages = const [
    ContestListPage(),
    CalendarPage(),
    UsersPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(child: Text(pageTitles[_selectedIndex])),
        toolbarTextStyle: Theme.of(context).primaryTextTheme.bodyText2,
        titleTextStyle: Theme.of(context).primaryTextTheme.headline6,
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: Colors.red,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Contests',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Users',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.accent,
        onTap: _onItemTapped,
        unselectedItemColor: AppColors.iconDark,
      ),
    );
  }
}
