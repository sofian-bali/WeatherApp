import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather_app/router.dart';

class CustomBottomAppBar extends StatefulWidget {
  const CustomBottomAppBar({Key? key});

  @override
  _CustomBottomAppBarState createState() => _CustomBottomAppBarState();
}

class _CustomBottomAppBarState extends State<CustomBottomAppBar> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, AppRouter.homePage);
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/favory');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    String currentRoute = ModalRoute.of(context)!.settings.name ?? '';
    switch (currentRoute) {
      case AppRouter.homePage:
        _selectedIndex = 0;
        break;
      case '/favory':
        _selectedIndex = 1;
        break;
    }

    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.heart),
          label: 'Favorite',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor:
          Colors.blueAccent, // Change the selected item color here
      unselectedItemColor: Colors.grey, // Change the unselected item color here
      onTap: _onItemTapped,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
    );
  }
}
