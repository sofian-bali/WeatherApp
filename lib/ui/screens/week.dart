import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/week_cubit.dart';
import 'package:weather_app/ui/widget/bottom_bar.dart';
import 'package:flutter/cupertino.dart';

class WeekScreen extends StatefulWidget {
  const WeekScreen({Key? key});

  @override
  _WeekScreenState createState() => _WeekScreenState();
}

class _WeekScreenState extends State<WeekScreen> {
  final List<bool> _isExpanded = List.generate(7, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: BlocBuilder<WeekCubit, WeekState>(
        builder: (weekContext, weekState) {
          final days = weekState.week.keys.toList();
          return ListView.builder(
            itemCount: weekState.week.length,
            itemBuilder: (context, index) {
              final weather = weekState.week[days[index]]!;
              return ExpansionTile(
                tilePadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                title: Text(
                  days[index],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                leading: const CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Icon(CupertinoIcons.sun_max_fill, color: Colors.white),
                ),
                onExpansionChanged: (expanded) {
                  setState(() {
                    _isExpanded[index] = expanded;
                  });
                },
                initiallyExpanded: _isExpanded[index],
                children: [
                  ListTile(
                    title: Text('${weather.windSpeed}  km/h Vent'),
                    leading: const Icon(CupertinoIcons.wind),
                  ),
                  ListTile(
                    title: Text('${weather.humidity}% Humidité'),
                    leading: const Icon(CupertinoIcons.drop),
                  ),
                  ListTile(
                    title: Text('${weather.precipitation}% Precipitation'),
                    leading: const Icon(Icons.waves),
                  ),
                  ListTile(
                    title: Text('${weather.temperature}°C Temperature'),
                    leading: const Icon(CupertinoIcons.thermometer),
                  ),
                ],
              );
            },
          );
        },
      ),
      bottomNavigationBar: const CustomBottomAppBar(),
    );
  }
}
