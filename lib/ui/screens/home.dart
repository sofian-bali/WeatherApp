import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/favory_cubit.dart';
import 'package:weather_app/blocs/home_cubit.dart';
import 'package:weather_app/models/address.dart';
import 'package:weather_app/repositories/address_repositories.dart';
import 'package:weather_app/ui/widget/bottom_bar.dart';
import 'package:easy_debounce/easy_debounce.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Address> _searchAddress = [];
  bool _isSearching = false;

  bool _isOnFavorite(Address address, List<Address> addresses) {
    return addresses.map((e) => e.city).toList().contains(address.city);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: BlocBuilder<FavoryCubit, List<Address>>(
        builder: (favoryContext, favoryState) {
          final favoryCubit = favoryContext.read<FavoryCubit>();
          return BlocBuilder<HomeCubit, HomeState>(
            builder: (homeContext, homeState) {
              final homeCubit = homeContext.read<HomeCubit>();
              final currentAddress = homeState.currentAddress;
              final currentWeather = homeState.currentWeather;
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        TextField(
                          onTap: () =>
                              setState(() => _isSearching = !_isSearching),
                          onChanged: (value) async {
                            if (value.length < 3) return;
                            EasyDebounce.debounce('fetch-debounce',
                                const Duration(milliseconds: 500), () async {
                              final address = await AddressRepository()
                                  .fetchAddresses(value);
                              setState(() {
                                _searchAddress = address
                                    .map((e) =>
                                        Address(city: e.city, latLng: e.latLng))
                                    .toList();
                                _isSearching = true;
                              });
                            });
                          },
                          decoration: const InputDecoration(
                            labelText: 'Rechercher une adresse',
                            icon: Icon(Icons.search),
                          ),
                        ),
                        if (_isSearching && _searchAddress.isNotEmpty)
                          Container(
                            height: 150,
                            margin: const EdgeInsets.only(
                                top: 10, right: 20, left: 20),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: ListView.builder(
                              itemCount: _searchAddress.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  onTap: () {
                                    homeCubit.setCurrentWeather(
                                        _searchAddress[index].latLng);
                                    homeCubit.setCurrentAddress(
                                        _searchAddress[index]);
                                    setState(() {
                                      _isSearching = false;
                                    });
                                  },
                                  title: Text(_searchAddress[index].city),
                                  trailing: IconButton(
                                    onPressed: () {
                                      if (_isOnFavorite(
                                          _searchAddress[index], favoryState)) {
                                        favoryCubit.removeAddress(
                                            _searchAddress[index]);
                                      } else {
                                        favoryCubit
                                            .saveAddress(_searchAddress[index]);
                                      }
                                    },
                                    icon: _isOnFavorite(
                                            _searchAddress[index], favoryState)
                                        ? const Icon(Icons.favorite)
                                        : const Icon(Icons.favorite_border),
                                  ),
                                );
                              },
                            ),
                          ),
                      ],
                    ),
                    Text(currentAddress?.city ?? "-",
                        style: const TextStyle(fontSize: 30)),
                    Image.network(currentWeather?.icon ?? ""),
                    Text(currentWeather?.temperature.toString() ?? "-",
                        style: const TextStyle(fontSize: 30)),
                  ],
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: const CustomBottomAppBar(),
    );
  }
}
