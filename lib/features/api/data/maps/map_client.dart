import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:latlong2/latlong.dart';

Future<LatLng?> getCoordinatesFromAddress(String address) async {
  try {
    final dio = Dio();
    final apiKey = dotenv.env['KEY_MAPS']!;
    final response = await dio.get(
      'https://maps.googleapis.com/maps/api/geocode/json',
      queryParameters: {
        'address': address,
        'key': apiKey,
      },
    );

    if (response.statusCode == 200) {
      final data = response.data;
      if (data['status'] == 'OK') {
        final location = data['results'][0]['geometry']['location'];
        return LatLng(location['lat'], location['lng']);
      } else {
        print('Google Geocoding error: ${data['status']}');
      }
    } else {
      print('Error HTTP: ${response.statusCode}');
    }
  } catch (e) {
    print('Error en la solicitud Dio: $e');
  }

  return null;
}
