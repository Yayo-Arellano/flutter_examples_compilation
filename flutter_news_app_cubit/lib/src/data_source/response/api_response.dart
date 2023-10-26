import 'package:equatable/equatable.dart';
import 'package:flutter_news_app_cubit/src/model/article.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

@JsonSerializable()
class ApiResponse extends Equatable {
  final String status;
  final String? code;
  final List<Article>? articles;

  const ApiResponse(
    this.status,
    this.code,
    this.articles,
  );

  factory ApiResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);

  @override
  List<Object?> get props => [status, code, articles];
}
