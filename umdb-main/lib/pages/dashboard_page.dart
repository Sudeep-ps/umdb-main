import 'package:flutter/material.dart';
import 'package:umdb/pages/favourite_page.dart';
import 'package:umdb/pages/home_page.dart';
import 'package:umdb/pages/profile_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  var _currentIndex = 0;

  final _navBarItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    const BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favourite"),
    const BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile")
  ];

  final _pages = [
    const HomePage(),
    const FavouritePage(),
    const ProfilePage(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 14,
        currentIndex: _currentIndex,
        items: _navBarItems,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          _currentIndex=index;
          setState(() {});
        }
      ),
    );
  }
}
