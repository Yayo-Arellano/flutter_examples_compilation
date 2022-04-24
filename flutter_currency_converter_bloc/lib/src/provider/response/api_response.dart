import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

@JsonSerializable()
class ApiResponse {
  late final bool success;
  late final int? timestamp;
  late final Map<String, num>? rates;
  late final ApiResponseError? error;

  ApiResponse();

  factory ApiResponse.fromJson(Map<String, dynamic> json) => _$ApiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);
}

@JsonSerializable()
class ApiResponseError {
  late final int code;

  ApiResponseError();

  factory ApiResponseError.fromJson(Map<String, dynamic> json) => _$ApiResponseErrorFromJson(json);

  Map<String, dynamic> toJson() => _$ApiResponseErrorToJson(this);
}
