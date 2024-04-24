import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:weather_app/models/address.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/repositories/weather_repository.dart';

class HomeState {
  final Weather? currentWeather;
  final Address? currentAddress;

  HomeState({required this.currentWeather, required this.currentAddress});
}

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState(currentWeather: null, currentAddress: null));

  void setCurrentWeather(LatLng latLng) async {
    final weather = await WeatherRepository().fetchCurrentWeather(latLng);
    emit(HomeState(
        currentWeather: weather, currentAddress: state.currentAddress));
  }

  void setCurrentAddress(Address address) {
    emit(HomeState(
        currentWeather: state.currentWeather, currentAddress: address));
  }
}
