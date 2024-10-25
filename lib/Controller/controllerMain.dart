import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../services/services.dart';
class WeatherController {
  var weatherData;
  var forecastData;
  double? latitude;
  double? longitude;
  final Function(dynamic) onWeatherDataLoaded;
  final Function(dynamic) onForecastDataLoaded;
  final BuildContext context;
  WeatherController({
    required this.onWeatherDataLoaded,
    required this.onForecastDataLoaded,
    required this.context,
  });
  Future<void> getUserLocation() async {
    bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationEnabled) {
      showSnackBar('Please enable location services.');
      return;}
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      showSnackBar(
          'Location permission denied forever. Please enable it from settings.');
      return;}
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showSnackBar('Location permission is required for weather data.');
        return;}}
    try {
      Position userPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      latitude = userPosition.latitude;
      longitude = userPosition.longitude;
      print('latitude of my location is $latitude');
      await _fetchWeatherData();
      await _fetchForecastData();
      onWeatherDataLoaded(weatherData);
      onForecastDataLoaded(forecastData);
    } catch (e) {
      showSnackBar(
        'Unable to retrieve location. Ensure you have an internet connection and location is enabled.',);} finally {}}

  Future<void> _fetchWeatherData() async {
    try {
      if (latitude != null && longitude != null) {
        weatherData = await getCurrentWeather(latitude!, longitude!);
      }} catch (e) {
      showSnackBar('Failed to fetch weather data. Please try again later.');
    }}
  Future<void> _fetchForecastData() async {
    try {
      if (latitude != null && longitude != null) {
        forecastData = await getDaysForecast(latitude!, longitude!);
      }
    } catch (e) {
      showSnackBar('Failed to fetch forecast data. Please try again later.');
    }
  }
  void showSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
