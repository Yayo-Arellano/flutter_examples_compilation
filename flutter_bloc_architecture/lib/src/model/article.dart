import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'article.g.dart';

@JsonSerializable()
class Article extends Equatable {
  late final String title;
  late final String? author;
  late final String? description;
  late final String? urlToImage;
  late final String? content;
  late final String url;

  Article({
    required this.title,
    this.author,
    this.urlToImage,
    this.description,
    this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleToJson(this);

  @override
  List<Object> get props => [title];
}
