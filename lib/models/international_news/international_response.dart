import 'package:equatable/equatable.dart';

import 'international_news.dart';

class InternationalResponse extends Equatable {
  final String? status;
  final int? totalResults;
  final List<InternationalNews>? articles;

  const InternationalResponse({
    this.status,
    this.totalResults,
    this.articles,
  });

  factory InternationalResponse.fromJson(Map<String, dynamic> json) =>
      InternationalResponse(
        status: json['status'] as String?,
        totalResults: json['totalResults'] as int?,
        articles: (json['articles'] as List<dynamic>?)
            ?.map((e) => InternationalNews.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'totalResults': totalResults,
        'articles': articles?.map((e) => e.toJson()).toList(),
      };

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [status, totalResults, articles];
}
