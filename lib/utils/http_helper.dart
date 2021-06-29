import 'dart:convert';
import 'dart:io';
import 'package:easystory/models/hashtag.dart';
import 'package:http/http.dart' as http;
import 'package:easystory/models/post.dart';

class HttpHelper {
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

  Future<List> getAllHashtags(String urlOption) async {
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
      List items = arrayMap.map((map) => Hashtag.fromJson(map)).toList();
      return items;
    } else {
      throw Exception('Failed request');
    }
  }

  Future<List> getAllPosts(String urlOption) async {
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
      List items = arrayMap.map((map) => Post.fromJson(map)).toList();
      return items;
    } else {
      throw Exception('Failed request');
    }
  }

  Future<List?> getMovies(String urlOption) async {
    const urlBase = "https://api.localhost.com";
    const urlApi = "?api_key=";
    const urlKey = "saddsadsa";
    final strPopular = urlBase + urlOption + urlApi + urlKey;
    final url = Uri.parse(strPopular);

    http.Response result = await http.get(url);

    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      final moviesMap = jsonResponse['content'];
      List movies = moviesMap.map((map) => Post.fromJson(map)).toList();
      return movies;
    }
  }
}
