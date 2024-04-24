import 'package:flutter/material.dart';
import 'package:weather_app/ui/screens/home.dart';
import 'package:weather_app/ui/screens/favory.dart';
import 'package:weather_app/ui/screens/week.dart';

class AppRouter {
  static const String homePage = '/';

  static final Map<String, WidgetBuilder> routes = {
    homePage: (context) => const HomeScreen(),
    '/favory': (context) => const FavoryScreen(),
    '/week': (context) => const WeekScreen(),
  };
}

