import 'dart:convert';

import 'package:news_app/models/article_response.dart';
import 'package:news_app/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/utils/constant.dart';

class HttpUtils {
  static Future<String> login(String username, String password) async {
    return '';
  }

  static Future<bool> logout(User userData) async {
    return true;
  }

  static Future<ArticleResponse?> getAllNews(String? q) async {
    final response = await http.get(Uri.parse(
        '${Constants.baseUrl}/everything?apiKey=${Constants.apiKey}&language=en&q=${q ??= 'vietnam'}'));
    return response.statusCode == 200
        ? ArticleResponse.fromJson(jsonDecode(response.body))
        : null;
  }

  static Future<ArticleResponse?> getLatestNews() async {
    final response = await http.get(Uri.parse(
        '${Constants.baseUrl}/top-headlines?apiKey=${Constants.apiKey}&language=en&category=general'));
    return response.statusCode == 200
        ? ArticleResponse.fromJson(jsonDecode(response.body))
        : null;
  }
}
