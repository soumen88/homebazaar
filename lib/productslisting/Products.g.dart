// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Products.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Products _$$_ProductsFromJson(Map<String, dynamic> json) => _$_Products(
      id: json['id'] as int?,
      title: json['title'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      description: json['description'] as String?,
      category: json['category'] as String?,
      image: json['image'] as String?,
      rating: json['rating'] == null
          ? null
          : Ratings.fromJson(json['rating'] as Map<String, dynamic>),
      addedCount: json['addedCount'] as int?,
    );

Map<String, dynamic> _$$_ProductsToJson(_$_Products instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'price': instance.price,
      'description': instance.description,
      'category': instance.category,
      'image': instance.image,
      'rating': instance.rating?.toJson(),
      'addedCount': instance.addedCount,
    };
