import 'package:weather_app/models/adress.dart';
import 'package:weather_app/repositories/adress_repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdressState {
  final List<Adress> savedAddresses;
  final Adress? currentAddress;

  AdressState({required this.savedAddresses, required this.currentAddress});

  AdressState.initial()
      : savedAddresses = [],
        currentAddress = null;
}

class ListAdressCubit extends Cubit<AdressState> {
  final AddressRepository _addressRepository = AddressRepository();

  ListAdressCubit() : super(AdressState.initial());

  void saveAddress(Adress address) async {
    final List<Adress> savedAddresses = [...state.savedAddresses, address];
    emit(AdressState(savedAddresses: savedAddresses, currentAddress: address));
    await _addressRepository.saveAddress(address);
  }

  void getSavedAddresses() async {
    final List<Adress> addresses = await _addressRepository.getSavedAddresses();
    emit(AdressState(
        savedAddresses: addresses, currentAddress: state.currentAddress));
  }

  void removeAddress(Adress address) async {
    final List<Adress> savedAddresses = [...state.savedAddresses];
    savedAddresses.remove(address);
    emit(AdressState(
        savedAddresses: savedAddresses, currentAddress: state.currentAddress));
    await _addressRepository.removeAddress(address);
  }

  void setCurrentAddress(Adress? address) {
    emit(AdressState(
        savedAddresses: state.savedAddresses, currentAddress: address));
  }

  void clearAddresses() {
    emit(AdressState(savedAddresses: [], currentAddress: null));
  }
}
