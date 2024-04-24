import 'package:weather_app/models/address.dart';
import 'package:weather_app/repositories/favory_repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoryCubit extends Cubit<List<Address>> {
  final FavoryRepositories _favoryRepository = FavoryRepositories();

  FavoryCubit() : super([]);

  void saveAddress(Address address) async {
    final List<Address> savedAddresses = [...state, address];
    emit(savedAddresses);
    await _favoryRepository.saveAddress(address);
  }

  void getSavedAddresses() async {
    final List<Address> addresses = await _favoryRepository.getSavedAddresses();
    emit(addresses);
  }

  void removeAddress(Address address) async {
    final List<Address> savedAddresses = [...state];
    savedAddresses.remove(address);
    emit(savedAddresses);
    await _favoryRepository.removeAddress(address);
  }
}
