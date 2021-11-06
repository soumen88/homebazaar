// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'Products.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Products _$ProductsFromJson(Map<String, dynamic> json) {
  return _Products.fromJson(json);
}

/// @nodoc
class _$ProductsTearOff {
  const _$ProductsTearOff();

  _Products call(
      {required int? id,
      required String? title,
      required double? price,
      required String? description,
      required String? category,
      required String? image,
      required Ratings? rating,
      @JsonKey() required int? addedCount}) {
    return _Products(
      id: id,
      title: title,
      price: price,
      description: description,
      category: category,
      image: image,
      rating: rating,
      addedCount: addedCount,
    );
  }

  Products fromJson(Map<String, Object> json) {
    return Products.fromJson(json);
  }
}

/// @nodoc
const $Products = _$ProductsTearOff();

/// @nodoc
mixin _$Products {
  int? get id => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  double? get price => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  Ratings? get rating => throw _privateConstructorUsedError;
  @JsonKey()
  int? get addedCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductsCopyWith<Products> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductsCopyWith<$Res> {
  factory $ProductsCopyWith(Products value, $Res Function(Products) then) =
      _$ProductsCopyWithImpl<$Res>;
  $Res call(
      {int? id,
      String? title,
      double? price,
      String? description,
      String? category,
      String? image,
      Ratings? rating,
      @JsonKey() int? addedCount});

  $RatingsCopyWith<$Res>? get rating;
}

/// @nodoc
class _$ProductsCopyWithImpl<$Res> implements $ProductsCopyWith<$Res> {
  _$ProductsCopyWithImpl(this._value, this._then);

  final Products _value;
  // ignore: unused_field
  final $Res Function(Products) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? price = freezed,
    Object? description = freezed,
    Object? category = freezed,
    Object? image = freezed,
    Object? rating = freezed,
    Object? addedCount = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      price: price == freezed
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double?,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      category: category == freezed
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      image: image == freezed
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      rating: rating == freezed
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as Ratings?,
      addedCount: addedCount == freezed
          ? _value.addedCount
          : addedCount // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }

  @override
  $RatingsCopyWith<$Res>? get rating {
    if (_value.rating == null) {
      return null;
    }

    return $RatingsCopyWith<$Res>(_value.rating!, (value) {
      return _then(_value.copyWith(rating: value));
    });
  }
}

/// @nodoc
abstract class _$ProductsCopyWith<$Res> implements $ProductsCopyWith<$Res> {
  factory _$ProductsCopyWith(_Products value, $Res Function(_Products) then) =
      __$ProductsCopyWithImpl<$Res>;
  @override
  $Res call(
      {int? id,
      String? title,
      double? price,
      String? description,
      String? category,
      String? image,
      Ratings? rating,
      @JsonKey() int? addedCount});

  @override
  $RatingsCopyWith<$Res>? get rating;
}

/// @nodoc
class __$ProductsCopyWithImpl<$Res> extends _$ProductsCopyWithImpl<$Res>
    implements _$ProductsCopyWith<$Res> {
  __$ProductsCopyWithImpl(_Products _value, $Res Function(_Products) _then)
      : super(_value, (v) => _then(v as _Products));

  @override
  _Products get _value => super._value as _Products;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? price = freezed,
    Object? description = freezed,
    Object? category = freezed,
    Object? image = freezed,
    Object? rating = freezed,
    Object? addedCount = freezed,
  }) {
    return _then(_Products(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      price: price == freezed
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double?,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      category: category == freezed
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      image: image == freezed
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      rating: rating == freezed
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as Ratings?,
      addedCount: addedCount == freezed
          ? _value.addedCount
          : addedCount // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_Products implements _Products {
  const _$_Products(
      {required this.id,
      required this.title,
      required this.price,
      required this.description,
      required this.category,
      required this.image,
      required this.rating,
      @JsonKey() required this.addedCount});

  factory _$_Products.fromJson(Map<String, dynamic> json) =>
      _$$_ProductsFromJson(json);

  @override
  final int? id;
  @override
  final String? title;
  @override
  final double? price;
  @override
  final String? description;
  @override
  final String? category;
  @override
  final String? image;
  @override
  final Ratings? rating;
  @override
  @JsonKey()
  final int? addedCount;

  @override
  String toString() {
    return 'Products(id: $id, title: $title, price: $price, description: $description, category: $category, image: $image, rating: $rating, addedCount: $addedCount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Products &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.category, category) ||
                const DeepCollectionEquality()
                    .equals(other.category, category)) &&
            (identical(other.image, image) ||
                const DeepCollectionEquality().equals(other.image, image)) &&
            (identical(other.rating, rating) ||
                const DeepCollectionEquality().equals(other.rating, rating)) &&
            (identical(other.addedCount, addedCount) ||
                const DeepCollectionEquality()
                    .equals(other.addedCount, addedCount)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(price) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(category) ^
      const DeepCollectionEquality().hash(image) ^
      const DeepCollectionEquality().hash(rating) ^
      const DeepCollectionEquality().hash(addedCount);

  @JsonKey(ignore: true)
  @override
  _$ProductsCopyWith<_Products> get copyWith =>
      __$ProductsCopyWithImpl<_Products>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProductsToJson(this);
  }
}

abstract class _Products implements Products {
  const factory _Products(
      {required int? id,
      required String? title,
      required double? price,
      required String? description,
      required String? category,
      required String? image,
      required Ratings? rating,
      @JsonKey() required int? addedCount}) = _$_Products;

  factory _Products.fromJson(Map<String, dynamic> json) = _$_Products.fromJson;

  @override
  int? get id => throw _privateConstructorUsedError;
  @override
  String? get title => throw _privateConstructorUsedError;
  @override
  double? get price => throw _privateConstructorUsedError;
  @override
  String? get description => throw _privateConstructorUsedError;
  @override
  String? get category => throw _privateConstructorUsedError;
  @override
  String? get image => throw _privateConstructorUsedError;
  @override
  Ratings? get rating => throw _privateConstructorUsedError;
  @override
  @JsonKey()
  int? get addedCount => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ProductsCopyWith<_Products> get copyWith =>
      throw _privateConstructorUsedError;
}
