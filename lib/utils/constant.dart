// ignore_for_file: constant_identifier_names

class Constants {
  static String internationalBaseUrl = 'https://newsapi.org/v2';
  static String internationalApiKey = '9b617a87de0d4561bbfb8d6ce0f0f809';

  static String domesticBaseUrl = 'https://newsdata.io/api/1/news';
  static String domesticApiKey = 'pub_22374e72ee7635f6413c5ff0b682e1ca5733a';

  static String userBaseUrl =
      'https://user-service-production-8a36.up.railway.app';
  static String localNewsBaseUrl =
      'https://newspaper-service-production.up.railway.app';

  static String keyUser = 'user';
}

enum Category {
  General,
  Business,
  Entertainment,
  Health,
  Science,
  Sports,
  Technology,
}
