import 'package:equatable/equatable.dart';

class InternationalSource extends Equatable {
  final dynamic id;
  final String? name;

  const InternationalSource({this.id, this.name});

  factory InternationalSource.fromJson(Map<String, dynamic> json) =>
      InternationalSource(
        id: json['id'] as dynamic,
        name: json['name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, name];
}
