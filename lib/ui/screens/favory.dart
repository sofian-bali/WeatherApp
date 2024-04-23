import 'package:flutter/material.dart';
import 'package:weather_app/ui/widget/bottom_bar.dart';


class FavoryScreen extends StatelessWidget {
  const FavoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: const Text('Favorite Screen'),
      ),
      bottomNavigationBar: const CustomBottomAppBar(),
    );
  }
}