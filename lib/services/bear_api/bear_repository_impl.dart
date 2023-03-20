import 'dart:convert';

import 'package:bear_test/models/bear.dart';
import 'package:http/http.dart' as http;

import 'bear_repository.dart';

class BearRepositoryImpl implements BearRepository {
  final String baseUrl = "https://api.punkapi.com/v2/beers";
  @override
  Future<Bear> getBear({required int id}) async {
    final http.Response response = await http.get(Uri.parse("$baseUrl/$id"));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((e) => Bear.fromJson(e)).first;
    } else {
      throw Exception("The petition has not been successfull");
    }
  }

  @override
  Future<List<Bear>> getBearList() async {
    final http.Response response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((e) => Bear.fromJson(e)).toList();
    } else {
      throw Exception("The petition has not been successfull");
    }
  }
}
