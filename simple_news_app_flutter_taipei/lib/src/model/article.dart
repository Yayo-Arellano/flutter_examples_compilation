import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'article.g.dart';

@JsonSerializable()
class Article extends Equatable {
  final String title;
  final String? author;
  final String? description;
  final String? urlToImage;
  final String? content;
  final String url;

  Article({
    required this.title,
    required this.url,
    this.author,
    this.urlToImage,
    this.description,
    this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleToJson(this);

  @override
  List<Object?> get props => [
        title,
        author,
        description,
        urlToImage,
        content,
        url,
      ];
}
