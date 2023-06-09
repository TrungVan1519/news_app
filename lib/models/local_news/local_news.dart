import 'package:equatable/equatable.dart';

class LocalNews extends Equatable {
  final int? id;
  final String? title;
  final String? thumbnail;
  final String? content;
  final int? categoryId;
  final String? author;
  final int? type;
  final DateTime? createTime;

  const LocalNews({
    this.id,
    this.title,
    this.thumbnail,
    this.content,
    this.categoryId,
    this.author,
    this.type,
    this.createTime,
  });

  factory LocalNews.fromJson(Map<String, dynamic> json) => LocalNews(
        id: json['id'] as int?,
        title: json['title'] as String?,
        thumbnail: json['thumbnail'] as String?,
        content: json['content'] as String?,
        categoryId: json['categoryId'] as int?,
        author: json['author'] as String?,
        type: json['type'] as int?,
        createTime: json['createTime'] == null
            ? null
            : DateTime.parse(json['createTime'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'thumbnail': thumbnail,
        'content': content,
        'categoryId': categoryId,
        'author': author,
        'type': type,
        'createTime': createTime?.toIso8601String(),
      };

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      title,
      thumbnail,
      content,
      categoryId,
      author,
      type,
      createTime,
    ];
  }
}
