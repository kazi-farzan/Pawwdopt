import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants.dart';

class ApiService {
  static Future<String> fetchRandomDogImage() async {
    final response = await http.get(Uri.parse(Constants.dogApiUrl));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['message'];
    } else {
      throw Exception('Failed to load random dog image');
    }
  }
}
