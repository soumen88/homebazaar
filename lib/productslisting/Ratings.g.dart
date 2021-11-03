// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Ratings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Ratings _$$_RatingsFromJson(Map<String, dynamic> json) => _$_Ratings(
      rate: (json['rate'] as num?)?.toDouble(),
      count: json['count'] as int?,
      title: json['title'] as String?,
      body: json['body'] as String?,
    );

Map<String, dynamic> _$$_RatingsToJson(_$_Ratings instance) =>
    <String, dynamic>{
      'rate': instance.rate,
      'count': instance.count,
      'title': instance.title,
      'body': instance.body,
    };
