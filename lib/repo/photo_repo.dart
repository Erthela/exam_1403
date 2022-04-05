import 'dart:convert';

import 'package:http/http.dart';

import '../models/photo.dart';

mixin PhotoRepository {
  static Future<List<Photo>> fetchData() async {
    var url = 'https://jsonplaceholder.typicode.com/photos';
    var response = await get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body).map<Photo>((e) => Photo.fromJson(e)).toList();
    }
    throw Exception('Данные не загрузились');
  }
}