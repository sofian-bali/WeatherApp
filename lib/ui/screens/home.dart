import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/favory_cubit.dart';
import 'package:weather_app/models/address.dart';
import 'package:weather_app/repositories/address_repositories.dart';
import 'package:weather_app/ui/widget/bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:easy_debounce/easy_debounce.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Address> _searchAddress = [];
  bool _isSearching = false;

  bool _isOnFavorite(Address address) {
    return context
        .read<FavoryCubit>()
        .state
        .map((e) => e.city)
        .contains(address.city);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocBuilder<FavoryCubit, List<Address>>(
              builder: (context, state) {
                return Column(
                  children: [
                    TextField(
                      onTap: () => setState(() => _isSearching = !_isSearching),
                      onChanged: (value) async {
                        if (value.length < 3) return;
                        EasyDebounce.debounce(
                            'fetch-debounce', const Duration(milliseconds: 500),
                            () async {
                          final address =
                              await AddressRepository().fetchAddresses(value);
                          setState(() {
                            _searchAddress = address;
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
                        margin:
                            const EdgeInsets.only(top: 10, right: 20, left: 20),
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
                                setState(() {
                                  _isSearching = false;
                                });
                              },
                              title: Text(_searchAddress[index].city),
                              trailing: IconButton(
                                onPressed: () {
                                  final FavoryCubit favoryCubit =
                                      context.read<FavoryCubit>();
                                  if (_isOnFavorite(_searchAddress[index])) {
                                    favoryCubit
                                        .removeAddress(_searchAddress[index]);
                                  } else {
                                    favoryCubit
                                        .saveAddress(_searchAddress[index]);
                                  }
                                },
                                icon: _isOnFavorite(_searchAddress[index])
                                    ? const Icon(Icons.favorite)
                                    : const Icon(Icons.favorite_border),
                              ),
                            );
                          },
                        ),
                      ),
                  ],
                );
              },
            ),
            const Text("Angers", style: TextStyle(fontSize: 30)),
            const Icon(CupertinoIcons.sun_max_fill, size: 100),
            const Text("28°C", style: TextStyle(fontSize: 30)),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomAppBar(),
    );
  }
}
