import 'package:flutter/material.dart';
import 'package:weather_app/ui/widget/bottom_bar.dart';
import 'package:flutter/cupertino.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Angers", style: TextStyle(fontSize: 30)),
            Icon(CupertinoIcons.sun_max_fill, size:100),
            Text("28°C", style: TextStyle(fontSize: 30)),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomAppBar(),
    );
  }
}