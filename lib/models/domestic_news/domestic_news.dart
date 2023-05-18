import 'package:equatable/equatable.dart';

class DomesticNews extends Equatable {
  final String? title;
  final String? link;
  final dynamic keywords;
  final dynamic creator;
  final dynamic videoUrl;
  final String? description;
  final String? content;
  final String? pubDate;
  final dynamic imageUrl;
  final String? sourceId;
  final dynamic category;
  final dynamic country;
  final String? language;

  const DomesticNews({
    this.title,
    this.link,
    this.keywords,
    this.creator,
    this.videoUrl,
    this.description,
    this.content,
    this.pubDate,
    this.imageUrl,
    this.sourceId,
    this.category,
    this.country,
    this.language,
  });

  factory DomesticNews.fromJson(Map<String, dynamic> json) => DomesticNews(
        title: json['title'] as String?,
        link: json['link'] as String?,
        keywords: json['keywords'] as dynamic,
        creator: json['creator'] as dynamic,
        videoUrl: json['video_url'] as dynamic,
        description: json['description'] as String?,
        content: json['content'] as String?,
        pubDate: json['pubDate'] as String?,
        imageUrl: json['image_url'] as dynamic,
        sourceId: json['source_id'] as String?,
        category: json['category'] as dynamic,
        country: json['country'] as dynamic,
        language: json['language'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'link': link,
        'keywords': keywords,
        'creator': creator,
        'video_url': videoUrl,
        'description': description,
        'content': content,
        'pubDate': pubDate,
        'image_url': imageUrl,
        'source_id': sourceId,
        'category': category,
        'country': country,
        'language': language,
      };

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      title,
      link,
      keywords,
      creator,
      videoUrl,
      description,
      content,
      pubDate,
      imageUrl,
      sourceId,
      category,
      country,
      language,
    ];
  }
}
