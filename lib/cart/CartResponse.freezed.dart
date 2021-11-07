// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'CartResponse.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CartResponse _$CartResponseFromJson(Map<String, dynamic> json) {
  return _CartResponse.fromJson(json);
}

/// @nodoc
class _$CartResponseTearOff {
  const _$CartResponseTearOff();

  _CartResponse call(
      {@JsonKey(name: "_id") required String? idFirst,
      required int? id,
      required int? userId,
      required String? date,
      required List<dynamic>? products}) {
    return _CartResponse(
      idFirst: idFirst,
      id: id,
      userId: userId,
      date: date,
      products: products,
    );
  }

  CartResponse fromJson(Map<String, Object> json) {
    return CartResponse.fromJson(json);
  }
}

/// @nodoc
const $CartResponse = _$CartResponseTearOff();

/// @nodoc
mixin _$CartResponse {
  @JsonKey(name: "_id")
  String? get idFirst => throw _privateConstructorUsedError;
  int? get id => throw _privateConstructorUsedError;
  int? get userId => throw _privateConstructorUsedError;
  String? get date => throw _privateConstructorUsedError;
  List<dynamic>? get products => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CartResponseCopyWith<CartResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CartResponseCopyWith<$Res> {
  factory $CartResponseCopyWith(
          CartResponse value, $Res Function(CartResponse) then) =
      _$CartResponseCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: "_id") String? idFirst,
      int? id,
      int? userId,
      String? date,
      List<dynamic>? products});
}

/// @nodoc
class _$CartResponseCopyWithImpl<$Res> implements $CartResponseCopyWith<$Res> {
  _$CartResponseCopyWithImpl(this._value, this._then);

  final CartResponse _value;
  // ignore: unused_field
  final $Res Function(CartResponse) _then;

  @override
  $Res call({
    Object? idFirst = freezed,
    Object? id = freezed,
    Object? userId = freezed,
    Object? date = freezed,
    Object? products = freezed,
  }) {
    return _then(_value.copyWith(
      idFirst: idFirst == freezed
          ? _value.idFirst
          : idFirst // ignore: cast_nullable_to_non_nullable
              as String?,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
      date: date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
      products: products == freezed
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
    ));
  }
}

/// @nodoc
abstract class _$CartResponseCopyWith<$Res>
    implements $CartResponseCopyWith<$Res> {
  factory _$CartResponseCopyWith(
          _CartResponse value, $Res Function(_CartResponse) then) =
      __$CartResponseCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: "_id") String? idFirst,
      int? id,
      int? userId,
      String? date,
      List<dynamic>? products});
}

/// @nodoc
class __$CartResponseCopyWithImpl<$Res> extends _$CartResponseCopyWithImpl<$Res>
    implements _$CartResponseCopyWith<$Res> {
  __$CartResponseCopyWithImpl(
      _CartResponse _value, $Res Function(_CartResponse) _then)
      : super(_value, (v) => _then(v as _CartResponse));

  @override
  _CartResponse get _value => super._value as _CartResponse;

  @override
  $Res call({
    Object? idFirst = freezed,
    Object? id = freezed,
    Object? userId = freezed,
    Object? date = freezed,
    Object? products = freezed,
  }) {
    return _then(_CartResponse(
      idFirst: idFirst == freezed
          ? _value.idFirst
          : idFirst // ignore: cast_nullable_to_non_nullable
              as String?,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
      date: date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
      products: products == freezed
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_CartResponse implements _CartResponse {
  const _$_CartResponse(
      {@JsonKey(name: "_id") required this.idFirst,
      required this.id,
      required this.userId,
      required this.date,
      required this.products});

  factory _$_CartResponse.fromJson(Map<String, dynamic> json) =>
      _$$_CartResponseFromJson(json);

  @override
  @JsonKey(name: "_id")
  final String? idFirst;
  @override
  final int? id;
  @override
  final int? userId;
  @override
  final String? date;
  @override
  final List<dynamic>? products;

  @override
  String toString() {
    return 'CartResponse(idFirst: $idFirst, id: $id, userId: $userId, date: $date, products: $products)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _CartResponse &&
            (identical(other.idFirst, idFirst) ||
                const DeepCollectionEquality()
                    .equals(other.idFirst, idFirst)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.date, date) ||
                const DeepCollectionEquality().equals(other.date, date)) &&
            (identical(other.products, products) ||
                const DeepCollectionEquality()
                    .equals(other.products, products)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(idFirst) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(date) ^
      const DeepCollectionEquality().hash(products);

  @JsonKey(ignore: true)
  @override
  _$CartResponseCopyWith<_CartResponse> get copyWith =>
      __$CartResponseCopyWithImpl<_CartResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CartResponseToJson(this);
  }
}

abstract class _CartResponse implements CartResponse {
  const factory _CartResponse(
      {@JsonKey(name: "_id") required String? idFirst,
      required int? id,
      required int? userId,
      required String? date,
      required List<dynamic>? products}) = _$_CartResponse;

  factory _CartResponse.fromJson(Map<String, dynamic> json) =
      _$_CartResponse.fromJson;

  @override
  @JsonKey(name: "_id")
  String? get idFirst => throw _privateConstructorUsedError;
  @override
  int? get id => throw _privateConstructorUsedError;
  @override
  int? get userId => throw _privateConstructorUsedError;
  @override
  String? get date => throw _privateConstructorUsedError;
  @override
  List<dynamic>? get products => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$CartResponseCopyWith<_CartResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
