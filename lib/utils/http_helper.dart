import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:easystory/models/post.dart';

class HttpHelper {
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
