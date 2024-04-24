import 'package:flutter/material.dart';
import 'package:weather_app/ui/widget/bottom_bar.dart';
import 'package:flutter/cupertino.dart';

class WeekScreen extends StatefulWidget {
  const WeekScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
      body:ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 7,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                title: Text('Day $index'),
                subtitle: 
                const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(CupertinoIcons.wind),
                                    Text(' 10 km/h'),
                                  ],
                                ),  
                                Row(
                                  children: [
                                    Icon(CupertinoIcons.drop),
                                    Text(' 80%'),
                                  ],  
                                ),

                                Row(
                                  children: [
                                    Icon(Icons.waves),
                                    Text(' 80%'),
                                  ],
                                ),    
                                 Row(
                                  children: [
                                    Icon(CupertinoIcons.thermometer),
                                    Text(' 20°C'),
                                  ],
                                ),    
                              ],
                            ),
                
                leading: const Icon(CupertinoIcons.sun_max_fill),
                trailing: _isExpanded[index]
                    ? const Icon(CupertinoIcons.chevron_down)
                    : const Icon(CupertinoIcons.chevron_right),
                onTap: () {
                  setState(() {
                    _isExpanded[index] = !_isExpanded[index];
                  });
                },
              ),
              if (_isExpanded[index]) ...[
                 Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 24,
                        itemBuilder: (contexthour, indexhour){
                          return ListTile(
                            title: Text('Heure : $indexhour:00'),
                            subtitle: 
                             const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(CupertinoIcons.wind),
                                    Text(' 10 km/h'),
                                  ],
                                ),  
                                Row(
                                  children: [
                                    Icon(CupertinoIcons.drop),
                                    Text(' 80%'),
                                  ],  
                                ),

                                Row(
                                  children: [
                                    Icon(Icons.waves),
                                    Text(' 80%'),
                                  ],
                                ),      
                              ],
                            ),
                            leading: const Icon(CupertinoIcons.sun_max_fill),
                            trailing: const Text("20°C", style: TextStyle(color: Colors.black, fontSize: 20)),
                          );
                        },  
                      ),
                    ],
                  ),
                ),
              ],
              const Divider(),
            ],
          );
        },
      ),
      bottomNavigationBar: const CustomBottomAppBar(),
    );
  }
}
