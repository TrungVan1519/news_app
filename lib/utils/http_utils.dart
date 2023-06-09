import 'dart:convert';

import 'package:news_app/models/international_news/international_response.dart';
import 'package:news_app/models/domestic_news/domestic_response.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/models/local_news/local_news.dart';
import 'package:news_app/models/local_news/local_news_response.dart';
import 'package:news_app/utils/constant.dart';

import '../models/response/response.dart';
import '../models/response/user.dart';

class HttpUtils {
  static const utf8Decoder = Utf8Decoder(allowMalformed: true);

  static Future<Response> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('${Constants.userBaseUrl}/user/login'),
      headers: {
        'Accept': 'application/json',
        'Content-type': 'application/json'
      },
      body: jsonEncode({'username': username, 'password': password}),
    );

    return Response.fromJson(jsonDecode(response.body));
  }

  static Future<Response> signup(User user) async {
    final response = await http.post(
      Uri.parse('${Constants.userBaseUrl}/user/save'),
      headers: {
        'Accept': 'application/json',
        'Content-type': 'application/json'
      },
      body: jsonEncode(user.toJson()),
    );
    return Response.fromJson(jsonDecode(response.body));
  }

  static Future<Response> changePassword(User user, String newPassword) async {
    final response = await http.post(
      Uri.parse(
        '${Constants.userBaseUrl}/user/${user.id}/change-password?newPassword=$newPassword',
      ),
      headers: {
        'Accept': 'application/json',
        'Content-type': 'application/json'
      },
    );
    return Response.fromJson(jsonDecode(response.body));
  }

  static Future<DomesticResponse?> getAllDomesticNews(
    String category,
    String? page,
  ) async {
    final response = await http.get(
      Uri.parse(
        '${Constants.domesticBaseUrl}?apiKey=${Constants.domesticApiKey}&country=vi,us,gb,cn,ru&language=vi${category == Category.General.name ? '' : '&category=$category'}${page == null ? '' : '&page=$page'}',
      ),
    );

    //! Because response return data in Vietnamese, we need to compile utf8
    return response.statusCode == 200
        ? DomesticResponse.fromJson(
            jsonDecode(utf8Decoder.convert(response.bodyBytes)),
          )
        : null;
  }

  static Future<InternationalResponse?> getAllInternationalNews(
    String category,
    int page,
  ) async {
    final response = await http.get(
      Uri.parse(
        '${Constants.internationalBaseUrl}/top-headlines?apiKey=${Constants.internationalApiKey}&category=$category&page=$page&language=en',
      ),
    );

    //! Because response return data in English, we don't need to compile utf8
    return response.statusCode == 200
        ? InternationalResponse.fromJson(jsonDecode(response.body))
        : null;
  }

  static Future<List<LocalNews>> getAllLocalNews(
    bool isDomestic,
    int categoryId,
  ) async {
    final response = await http.get(
      Uri.parse(
        '${Constants.localNewsBaseUrl}/newspaper/list/$categoryId/${isDomestic ? 1 : 2}',
      ),
    );

    return response.statusCode == 200
        ? List<LocalNews>.from(
            jsonDecode(response.body).map((model) => LocalNews.fromJson(model)),
          )
        : [];
  }

  static Future<LocalNewsResponse> getAllFavorite(User user) async {
    final response = await http.get(
      Uri.parse('${Constants.userBaseUrl}/user/list-favorite/${user.id}'),
    );

    return LocalNewsResponse.fromJson(jsonDecode(response.body));
  }

  static Future<bool> addToFavorite(
    User user,
    LocalNews news,
  ) async {
    final response = await http.post(
      Uri.parse('${Constants.userBaseUrl}/user/like'),
      headers: {
        'Accept': 'application/json',
        'Content-type': 'application/json'
      },
      body: jsonEncode({'userId': user.id!, 'newsId': news.id!}),
    );

    print(response.body);
    return response.statusCode == 200;
  }

  static Future<bool> removeFromFavorite(
    User user,
    LocalNews news,
  ) async {
    final response = await http.post(
      Uri.parse('${Constants.userBaseUrl}/user/remove-favorite'),
      headers: {
        'Accept': 'application/json',
        'Content-type': 'application/json'
      },
      body: jsonEncode({'userId': user.id, 'newsId': news.id}),
    );

    print(response.body);
    return response.statusCode == 200;
  }
}
