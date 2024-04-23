import 'dart:convert';
import 'package:weather_app/models/adress.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressRepository {
  Future<List<Adress>> fetchAddresses(String query) async {
    final Response response = await get(
        Uri.parse('https://api-adresse.data.gouv.fr/search?q=$query'));
    if (response.statusCode == 200) {
      final List<Adress> addresses = [];
      final Map<String, dynamic> json = jsonDecode(response.body);
      if (json.containsKey("features")) {
        final List<dynamic> features = json['features'];
        for (Map<String, dynamic> feature in features) {
          final Adress address = Adress.fromGeoJson(feature);
          addresses.add(address);
        }
      }
      return addresses;
    } else {
      return [];
    }
  }

  // PREFRENCES
  Future<void> saveAddress(Adress address) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> addresses = prefs.getStringList('addresses') ?? [];
    addresses.add(jsonEncode(address.toJson()));
    prefs.setStringList('addresses', addresses);
  }

  Future<List<Adress>> getSavedAddresses() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> addresses = prefs.getStringList('addresses') ?? [];
    return addresses.map((String address) {
      final Map<String, dynamic> json = jsonDecode(address);
      return Adress.fromJson(json);
    }).toList();
  }

  Future<List<Adress>> removeAddress(Adress address) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> addresses = prefs.getStringList('addresses') ?? [];
    addresses.remove(jsonEncode(address.toJson()));
    prefs.setStringList('addresses', addresses);
    return getSavedAddresses();
  }
}
