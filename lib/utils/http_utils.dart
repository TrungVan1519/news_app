import 'dart:convert';

import 'package:news_app/models/international_news/international_response.dart';
import 'package:news_app/models/domestic_news/domestic_response.dart';
import 'package:news_app/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/utils/constant.dart';

class HttpUtils {
  static const utf8Decoder = Utf8Decoder(allowMalformed: true);

  static Future<String> login(String username, String password) async {
    return '';
  }

  static Future<bool> logout(User user) async {
    return true;
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
    print(response.body);

    //! Because response return data in Vietnamese, we need to compile utf8
    return response.statusCode == 200
        ? DomesticResponse.fromJson(
            jsonDecode(utf8Decoder.convert(response.bodyBytes)),
          )
        : null;
  }

  static Future<InternationalResponse?> getAllInternationalNews(
      String category) async {
    final response = await http.get(
      Uri.parse(
        '${Constants.internationalBaseUrl}/top-headlines?apiKey=${Constants.internationalApiKey}&category=$category&language=en',
      ),
    );

    //! Because response return data in English, we don't need to compile utf8
    return response.statusCode == 200
        ? InternationalResponse.fromJson(jsonDecode(response.body))
        : null;
  }
}
