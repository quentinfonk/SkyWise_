import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<dynamic>> getPosition(String cityName) {
  return callPosition(cityName);
}

Future<List<dynamic>> callPosition(String cityName) async {
  String key = dotenv.env['POSITION_KEY'] ?? "";

  if (key == '') {
    print('No key');
    return [];
  }
  try {
    var response = await http.get(
      Uri.parse(
          'http://api.positionstack.com/v1/forward?access_key=$key&query=$cityName'),
    );
    if (response.statusCode == 200) {
      print(response.body);
      return ([
        jsonDecode(response.body)['data'][0]['latitude'],
        jsonDecode(response.body)['data'][0]['longitude'],
        jsonDecode(response.body)['data'][0]['name']
      ]);
    } else {
      print(response.statusCode);
      return [];
    }
  } catch (e) {
    print(e);
  }
  return [];
}
