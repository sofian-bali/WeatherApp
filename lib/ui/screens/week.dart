import 'package:flutter/material.dart';
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
      body: ListView.builder(
        itemCount: 7,
        itemBuilder: (context, index) {
          return ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            title: Text(
              'Day $index',
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
            children: const [
              ListTile(
                title: Text('10 km/h Wind'),
                leading: Icon(CupertinoIcons.wind),
              ),
              ListTile(
                title: Text('80% Humidity'),
                leading: Icon(CupertinoIcons.drop),
              ),
              ListTile(
                title: Text('80% Wave Height'),
                leading: Icon(Icons.waves),
              ),
              ListTile(
                title: Text('20°C Temperature'),
                leading: Icon(CupertinoIcons.thermometer),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: const CustomBottomAppBar(),
    );
  }
}
