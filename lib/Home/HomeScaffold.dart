import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'package:PetCare_App/Booking/MyBookingsPage.dart';
import 'package:PetCare_App/Profile/ProfilePage.dart';

class HomeScaffold extends StatefulWidget {
  const HomeScaffold({Key? key}) : super(key: key);

  @override
  State<HomeScaffold> createState() => _HomeScaffoldState();
}

class _HomeScaffoldState extends State<HomeScaffold> {
  int _idx = 0;
  final _pages = [
    const HomePage(),
    const MyBookingsPage(),
    const ProfilePage(),
  ];

  void _onBookedNavigateToBookings() {
    setState(() {
      _idx = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_idx],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _idx,
        onTap: (i) => setState(() => _idx = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined,color:  Color.fromARGB(255, 126, 15, 141),), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.date_range_outlined,color:  Color.fromARGB(255, 126, 15, 141),), label: 'My Bookings'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle,color:  Color.fromARGB(255, 126, 15, 141),), label: 'Profile'),
        ],
      ),
      floatingActionButton: SizedBox.shrink(),
    );
  }
}