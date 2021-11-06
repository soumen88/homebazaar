// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SavedProducts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SavedProducts _$SavedProductsFromJson(Map<String, dynamic> json) =>
    SavedProducts(
      json['count'] as int?,
      Products.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SavedProductsToJson(SavedProducts instance) =>
    <String, dynamic>{
      'count': instance.count,
      'product': instance.product,
    };
