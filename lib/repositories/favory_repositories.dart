import 'dart:convert';
import 'package:weather_app/models/address.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoryRepositories {
  Future<void> saveAddress(Address address) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> addresses = prefs.getStringList('addresses') ?? [];
    addresses.add(jsonEncode(address.toJson()));
    prefs.setStringList('addresses', addresses);
  }

  Future<List<Address>> getSavedAddresses() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> addresses = prefs.getStringList('addresses') ?? [];
    return addresses.map((String address) {
      final Map<String, dynamic> json = jsonDecode(address);
      return Address.fromJson(json);
    }).toList();
  }

  Future<List<Address>> removeAddress(Address address) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> addresses = prefs.getStringList('addresses') ?? [];
    addresses.remove(jsonEncode(address.toJson()));
    prefs.setStringList('addresses', addresses);
    return getSavedAddresses();
  }
}
