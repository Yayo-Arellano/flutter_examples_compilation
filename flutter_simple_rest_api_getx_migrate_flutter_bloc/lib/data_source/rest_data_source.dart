import 'dart:convert';
import 'package:flutter_simple_rest_api_getx/models/user_location.dart';
import 'package:flutter_simple_rest_api_getx/models/user_name.dart';
import 'package:flutter_simple_rest_api_getx/models/user_picture.dart';
import 'package:http/http.dart' as http;

class RestDataSource {
  static const String _baseUrl = 'randomuser.me';
  static const String _name = '/api';
  static const String _location = '/api';
  static const String _picture = '/api';

  final http.Client _httpClient;

  RestDataSource({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  Future<T> _callGetApi<T>({
    required String endpoint,
    required Map<String, dynamic> params,
    required T Function(Map<String, dynamic> data) builder,
  }) async {
    var uri = Uri.https(_baseUrl, endpoint, params);

    final response = await _httpClient.get(uri);
    return builder(json.decode(response.body)['results'][0]);
  }

  Future<UserName> getName() async {
    return _callGetApi(
      endpoint: _name,
      params: {'inc': 'name'},
      builder: (data) => UserName.fromJson(data['name']),
    );
  }

  Future<UserLocation> getLocation() async {
    return _callGetApi(
      endpoint: _location,
      params: {'inc': 'location'},
      builder: (data) => UserLocation.fromJson(data['location']),
    );
  }

  Future<UserPicture> getPicture() async {
    return _callGetApi(
      endpoint: _picture,
      params: {'inc': 'picture'},
      builder: (data) => UserPicture.fromJson(data['picture']),
    );
  }
}






















