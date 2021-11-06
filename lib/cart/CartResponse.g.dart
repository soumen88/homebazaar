// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CartResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CartResponse _$$_CartResponseFromJson(Map<String, dynamic> json) =>
    _$_CartResponse(
      idFirst: json['_id'] as String?,
      id: json['id'] as String?,
      userId: json['userId'] as int?,
      date: json['date'] as String?,
      products: json['products'] as List<dynamic>?,
    );

Map<String, dynamic> _$$_CartResponseToJson(_$_CartResponse instance) =>
    <String, dynamic>{
      '_id': instance.idFirst,
      'id': instance.id,
      'userId': instance.userId,
      'date': instance.date,
      'products': instance.products,
    };
