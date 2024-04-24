import 'dart:convert';

import 'package:http/http.dart';
import 'package:weather_app/models/address.dart';

class AddressRepository {
  Future<List<Address>> fetchAddresses(String query) async {
    final Response response = await get(Uri.parse(
        'https://api-adresse.data.gouv.fr/search?q=$query&type=municipality'));
    if (response.statusCode == 200) {
      final List<Address> addresses = [];
      final Map<String, dynamic> json = jsonDecode(response.body);
      if (json.containsKey("features")) {
        final List<dynamic> features = json['features'];
        for (Map<String, dynamic> feature in features) {
          final Address address = Address.fromGeoJson(feature);
          addresses.add(address);
        }
      }
      return addresses;
    } else {
      return [];
    }
  }
}
