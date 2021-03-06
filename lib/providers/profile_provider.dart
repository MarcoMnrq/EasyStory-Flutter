import 'dart:convert';
import 'dart:io';
import 'package:easystory/models/profile.dart';
import 'package:http/http.dart' as http;


class ProfileProvider {
  Future<String> getAuthToken() async {
    final requestUrl = "https://easystory-api.herokuapp.com/api/";
    http.Response auth = await http.post(Uri.parse(requestUrl + "auth/sign-in"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({'username': 'admin', 'password': 'admin'}));
    return (json.decode(auth.body))['token'];
  }

  Future<Profile> getAll() async {
    final requestURL = "https://easystory-api.herokuapp.com/api/users/1";
    final url = Uri.parse(requestURL);
    final token = await getAuthToken();
    final result = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
  
    print(result);
    final jsonResponse = json.decode(result.body);
    return Profile.fromJson(jsonResponse);
  }

  Future<Profile> update(String urlOption, Map<String, dynamic> payload) async {
    final requestUrl = "https://easystory-api.herokuapp.com/api/";
    final url = Uri.parse(requestUrl + urlOption);
    final token = await getAuthToken();
    http.Response result = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(payload),
    );
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      return Profile.fromJson(jsonResponse);
    } else {
      throw Exception('Failed request');
    }
  }


}
