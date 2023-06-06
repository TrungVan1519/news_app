import 'package:equatable/equatable.dart';

import 'status.dart';
import 'user.dart';

class Response extends Equatable {
  final Status? status;
  final User? user;

  const Response({this.status, this.user});

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        status: json['status'] == null
            ? null
            : Status.fromJson(json['status'] as Map<String, dynamic>),
        user: json['data'] == null
            ? null
            : User.fromJson(json['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'status': status?.toJson(),
        'data': user?.toJson(),
      };

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [status, user];
}
