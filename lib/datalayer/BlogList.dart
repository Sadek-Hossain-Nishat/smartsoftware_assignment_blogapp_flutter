import 'dart:convert';

import '../domainlayer/Blog.dart';
import 'package:http/http.dart' as http;

import '../domainlayer/UTIL.dart';


class BlogList{



  static Future<List<Blog>> fetchAllBlogs(String token) async {
    final response = await http.get(
        Uri.parse(uriget),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        }

    );

    return json
        .decode(response.body)['data']['blogs']['data']
        .map<Blog>((e) => Blog.fromJson(e))
        .toList();
  }
}