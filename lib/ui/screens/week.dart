import 'package:flutter/material.dart';
import 'package:weather_app/ui/widget/bottom_bar.dart';


class WeekScreen extends StatelessWidget {
  const WeekScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: const Text('Week Screen'),
      ),
      bottomNavigationBar: const CustomBottomAppBar(),
    );
  }
}