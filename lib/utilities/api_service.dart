import 'dart:async'; // Import dart:async for TimeoutException
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants.dart';

class ApiService {
  static Future<String> fetchRandomDogImage() async {
    try {
      final client = http.Client();
      final response = await client.get(
        Uri.parse(Constants.dogApiUrl),
      ).timeout(Duration(seconds: 10), onTimeout: () {
        throw TimeoutException('Connection timed out, please try again later.');
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['message'];
      } else {
        throw Exception('Failed to load random dog image: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
