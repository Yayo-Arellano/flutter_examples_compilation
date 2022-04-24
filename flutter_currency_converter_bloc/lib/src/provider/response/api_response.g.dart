// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResponse _$ApiResponseFromJson(Map<String, dynamic> json) => ApiResponse()
  ..success = json['success'] as bool
  ..timestamp = json['timestamp'] as int?
  ..rates = (json['rates'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, e as num),
  )
  ..error = json['error'] == null
      ? null
      : ApiResponseError.fromJson(json['error'] as Map<String, dynamic>);

Map<String, dynamic> _$ApiResponseToJson(ApiResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'timestamp': instance.timestamp,
      'rates': instance.rates,
      'error': instance.error,
    };

ApiResponseError _$ApiResponseErrorFromJson(Map<String, dynamic> json) =>
    ApiResponseError()..code = json['code'] as int;

Map<String, dynamic> _$ApiResponseErrorToJson(ApiResponseError instance) =>
    <String, dynamic>{
      'code': instance.code,
    };
