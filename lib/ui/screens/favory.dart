import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/favory_cubit.dart';
import 'package:weather_app/blocs/home_cubit.dart';
import 'package:weather_app/models/address.dart';
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
      body: BlocBuilder<FavoryCubit, List<Address>>(
        builder: (favoryContext, favoryState) {
          return BlocBuilder<HomeCubit, HomeState>(
            builder: (homeContext, homeState) {
              return ListView(
                scrollDirection: Axis.vertical,
                children: favoryState
                    .map((address) => FavoryCard(
                        location: address,
                        onTap: () {
                          homeContext
                              .read<HomeCubit>()
                              .setCurrentAddress(address);
                          Navigator.pushNamed(context, "/");
                        },
                        onRemove: () {
                          favoryContext
                              .read<FavoryCubit>()
                              .removeAddress(address);
                        }))
                    .toList(),
              );
            },
          );
        },
      ),
      bottomNavigationBar: const CustomBottomAppBar(),
    );
  }
}
