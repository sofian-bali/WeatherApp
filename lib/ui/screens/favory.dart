import 'package:flutter/material.dart';
import 'package:weather_app/ui/widget/bottom_bar.dart';
import 'package:weather_app/ui/widget/card_favory.dart';

class FavoryScreen extends StatelessWidget {
  const FavoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          FavoryCard(
            location: 'Angers',
            onRemove: () {

            },
          ),
          FavoryCard(
            location: 'Angers',
            onRemove: () {

            },
            
          ),
       

        ],
      ),
      bottomNavigationBar: const CustomBottomAppBar(),

    );
  }
}