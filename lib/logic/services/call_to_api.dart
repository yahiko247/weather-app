// import 'dart:convert';
// import 'dart:developer';

// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import "package:http/http.dart" as http;
// import 'package:try2demoweather/constants/api_key.dart';
// import 'package:try2demoweather/logic/models/weather_models.dart';

// class CallToApi {
//   Future<WeatherModel> callWeatherAPi(bool current, String cityName) async {
//     try {
//       Position? currentPosition;
//       if (current) {
//         currentPosition = await getCurrentPosition();
//         if (currentPosition == null) {
//           throw Exception('Failed to get current position');
//         }

//         List<Placemark> placemarks = await placemarkFromCoordinates(
//           currentPosition.latitude,
//           currentPosition.longitude,
//         );

//         if (placemarks.isEmpty || placemarks[0].locality == null) {
//           throw Exception('Failed to get city name from coordinates');
//         }

//         Placemark place = placemarks[0];
//         cityName = place.locality!;
//       }

//       if (cityName.isEmpty) {
//         throw Exception('City name is empty');
//       }

//       var url = Uri.https(
//         'api.openweathermap.org',
//         '/data/2.5/weather',
//         {'q': cityName, 'units': 'metric', 'appid': apiKey},
//       );
//       final http.Response response = await http.get(url);
//       log('Response body: ${response.body}');
//       log('Response status code: ${response.statusCode}');

//       if (response.statusCode == 200) {
//         final Map<String, dynamic> decodedJson = json.decode(response.body);
//         if (decodedJson == null) {
//           throw Exception('Decoded JSON is null');
//         }
//         return WeatherModel.fromMap(decodedJson);
//       } else {
//         throw Exception(
//             'Failed to load weather data. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       log('Error in callWeatherAPi: $e');
//       throw Exception('Failed to load weather data: $e');
//     }
//   }

//   Future<Position> getCurrentPosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       log('Location services are disabled.');
//       return Future.error('Location services are disabled.');
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         log('Location permissions are denied');
//         return Future.error('Location permissions are denied');
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       log('Location permissions are permanently denied, we cannot request permissions.');
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }

//     return await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.best,
//     );
//   }
// }
