import 'dart:convert';
import 'dart:io';
import 'package:easystory/models/bookmark.dart';
import 'package:http/http.dart' as http;

class BookmarksProvider {
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

  Future<Bookmark> create(String urlOption) async {
    final requestUrl = "https://easystory-api.herokuapp.com/api/";
    final url = Uri.parse(requestUrl + urlOption);
    final token = await getAuthToken();
    http.Response result = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Beare $token',
      },
    );
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      return Bookmark.fromJson(jsonResponse);
    } else {
      throw Exception('Failed request');
    }
  }

  Future<List> getAll(String urlOption) async {
    final requestUrl = "https://easystory-api.herokuapp.com/api/";
    final url = Uri.parse(requestUrl + urlOption);
    final token = await getAuthToken();
    http.Response result = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      final arrayMap = jsonResponse['content'];
      List items = arrayMap.map((map) => Bookmark.fromJson(map)).toList();
      return items;
    } else {
      throw Exception('Failed request');
    }
  }
}
