import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather_app/router.dart';

class CustomBottomAppBar extends StatefulWidget {
  const CustomBottomAppBar({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
      case 2:
        Navigator.pushReplacementNamed(context, '/week');
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
      case '/week':
        _selectedIndex = 2;
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
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.calendar),
          label: 'Week',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Colors.grey,
      onTap: _onItemTapped,
    );
  }
}
