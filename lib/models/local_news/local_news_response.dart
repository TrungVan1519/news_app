import 'package:equatable/equatable.dart';

import 'local_news.dart';
import 'status.dart';

class LocalNewsResponse extends Equatable {
  final Status? status;
  final List<LocalNews>? data;

  const LocalNewsResponse({this.status, this.data});

  factory LocalNewsResponse.fromJson(Map<String, dynamic> json) {
    return LocalNewsResponse(
      status: json['status'] == null
          ? null
          : Status.fromJson(json['status'] as Map<String, dynamic>),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => LocalNews.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status?.toJson(),
        'data': data?.map((e) => e.toJson()).toList(),
      };

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [status, data];
}
