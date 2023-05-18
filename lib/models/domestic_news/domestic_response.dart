import 'package:equatable/equatable.dart';

import 'domestic_news.dart';

class DomesticResponse extends Equatable {
  final String? status;
  final int? totalResults;
  final List<DomesticNews>? results;
  final String? nextPage;

  const DomesticResponse({
    this.status,
    this.totalResults,
    this.results,
    this.nextPage,
  });

  factory DomesticResponse.fromJson(Map<String, dynamic> json) =>
      DomesticResponse(
        status: json['status'] as String?,
        totalResults: json['totalResults'] as int?,
        results: (json['results'] as List<dynamic>?)
            ?.map((e) => DomesticNews.fromJson(e as Map<String, dynamic>))
            .toList(),
        nextPage: json['nextPage'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'totalResults': totalResults,
        'results': results?.map((e) => e.toJson()).toList(),
        'nextPage': nextPage,
      };

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [status, totalResults, results, nextPage];
}
