// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cart _$CartFromJson(Map<String, dynamic> json) => Cart(
      json['userId'] as int?,
      json['date'] as String?,
      (json['products'] as List<dynamic>?)
          ?.map((e) => CartProducts.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
      'userId': instance.userId,
      'date': instance.date,
      'products': instance.products,
    };
