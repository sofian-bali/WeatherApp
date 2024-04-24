import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class FavoryCard extends StatelessWidget {
  const FavoryCard({
    Key? key,
    required this.location,
    this.onRemove,
  }) : super(key: key);

  final String location;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          height: 100,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  const Icon(CupertinoIcons.location, size: 25),
                  const Padding(padding: EdgeInsets.all(2)),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/detail', arguments: location);
                    },
                    child: Text(
                      location,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              if (onRemove != null)
                IconButton(
                  icon: const Icon(CupertinoIcons.bin_xmark),
                  onPressed: onRemove,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
