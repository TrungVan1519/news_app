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

  static Future<String> getAllNews() async {
    final response = http.get(Uri.parse(
        '${Constants.baseUrl}/everything?apiKey=${Constants.apiKey}'));
    print(response);
    return '';
  }
}
