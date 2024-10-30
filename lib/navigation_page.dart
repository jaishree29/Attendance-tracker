import 'package:employee_attendance_tracker/models/role.dart';
import 'package:employee_attendance_tracker/models/user_model.dart';
import 'package:employee_attendance_tracker/utils/constants/colors.dart';
import 'package:employee_attendance_tracker/pages/users/home_page.dart';
import 'package:flutter/material.dart';

class NavigationPage extends StatefulWidget {
  final UserModel user;

  const NavigationPage({super.key, required this.user});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int myCurrentIndex = 0;

  late List<Widget> pages;
  late List<BottomNavigationBarItem> navBarItems;

  @override
  void initState() {
    super.initState();
    _initializeNavigation();
  }

  void _initializeNavigation() {
    switch (widget.user.role) {
      case UserRole.admin:
        pages = [
          HomePage(user: widget.user),
        ];
        navBarItems = const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dining_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ];
        break;

      case UserRole.guardEmployee:
        pages = [
          HomePage(user: widget.user),
        ];
        navBarItems = const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dining_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ];
        break;

      case UserRole.supervisorEmployee:
        pages = [
          HomePage(user: widget.user),
        ];
        navBarItems = const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dining_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Reports',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ];
        break;

      default:
        pages = [
          HomePage(user: widget.user),
        ];
        navBarItems = const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dining_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ];
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 3),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 10,
            ),
          ],
        ),
        child: ClipRRect(
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            currentIndex: myCurrentIndex,
            onTap: (index) {
              setState(() {
                myCurrentIndex = index;
              });
            },
            selectedItemColor: FColors.primary,
            unselectedItemColor: FColors.secondary,
            type: BottomNavigationBarType.fixed,
            items: navBarItems,
          ),
        ),
      ),
      body: pages[myCurrentIndex],
    );
  }
}
