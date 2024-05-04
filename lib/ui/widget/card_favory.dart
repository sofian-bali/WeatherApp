import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather_app/models/address.dart';

class FavoryCard extends StatelessWidget {
  const FavoryCard({
    super.key,
    required this.location,
    this.onRemove,
    this.onTap,
  });

  final Address location;
  final VoidCallback? onRemove;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2, // Ajout d'une légère ombre pour la profondeur
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Coins arrondis
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 80,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  const Icon(
                    CupertinoIcons.location,
                    size: 25,
                    color: Colors.blue, // Utilisation d'une couleur bleue pour l'icône
                  ),
                  const SizedBox(width: 10),
                  TextButton(
                    onPressed: () {
                      if (onTap != null) onTap!();
                    },
                    child: Text(
                      location.city,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black87, // Texte en noir pour une meilleure lisibilité
                        fontWeight: FontWeight.bold, // Texte en gras pour le titre
                      ),
                    ),
                  ),
                ],
              ),
              if (onRemove != null)
                IconButton(
                  icon: const Icon(
                    CupertinoIcons.bin_xmark,
                    color: Colors.red, // Utilisation d'une couleur rouge pour l'icône de suppression
                  ),
                  onPressed: onRemove,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
