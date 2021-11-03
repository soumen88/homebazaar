// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'Ratings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Ratings _$RatingsFromJson(Map<String, dynamic> json) {
  return _Ratings.fromJson(json);
}

/// @nodoc
class _$RatingsTearOff {
  const _$RatingsTearOff();

  _Ratings call(
      {required double? rate,
      required int? count,
      required String? title,
      required String? body}) {
    return _Ratings(
      rate: rate,
      count: count,
      title: title,
      body: body,
    );
  }

  Ratings fromJson(Map<String, Object> json) {
    return Ratings.fromJson(json);
  }
}

/// @nodoc
const $Ratings = _$RatingsTearOff();

/// @nodoc
mixin _$Ratings {
  double? get rate => throw _privateConstructorUsedError;
  int? get count => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get body => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RatingsCopyWith<Ratings> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RatingsCopyWith<$Res> {
  factory $RatingsCopyWith(Ratings value, $Res Function(Ratings) then) =
      _$RatingsCopyWithImpl<$Res>;
  $Res call({double? rate, int? count, String? title, String? body});
}

/// @nodoc
class _$RatingsCopyWithImpl<$Res> implements $RatingsCopyWith<$Res> {
  _$RatingsCopyWithImpl(this._value, this._then);

  final Ratings _value;
  // ignore: unused_field
  final $Res Function(Ratings) _then;

  @override
  $Res call({
    Object? rate = freezed,
    Object? count = freezed,
    Object? title = freezed,
    Object? body = freezed,
  }) {
    return _then(_value.copyWith(
      rate: rate == freezed
          ? _value.rate
          : rate // ignore: cast_nullable_to_non_nullable
              as double?,
      count: count == freezed
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int?,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      body: body == freezed
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$RatingsCopyWith<$Res> implements $RatingsCopyWith<$Res> {
  factory _$RatingsCopyWith(_Ratings value, $Res Function(_Ratings) then) =
      __$RatingsCopyWithImpl<$Res>;
  @override
  $Res call({double? rate, int? count, String? title, String? body});
}

/// @nodoc
class __$RatingsCopyWithImpl<$Res> extends _$RatingsCopyWithImpl<$Res>
    implements _$RatingsCopyWith<$Res> {
  __$RatingsCopyWithImpl(_Ratings _value, $Res Function(_Ratings) _then)
      : super(_value, (v) => _then(v as _Ratings));

  @override
  _Ratings get _value => super._value as _Ratings;

  @override
  $Res call({
    Object? rate = freezed,
    Object? count = freezed,
    Object? title = freezed,
    Object? body = freezed,
  }) {
    return _then(_Ratings(
      rate: rate == freezed
          ? _value.rate
          : rate // ignore: cast_nullable_to_non_nullable
              as double?,
      count: count == freezed
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int?,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      body: body == freezed
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_Ratings implements _Ratings {
  const _$_Ratings(
      {required this.rate,
      required this.count,
      required this.title,
      required this.body});

  factory _$_Ratings.fromJson(Map<String, dynamic> json) =>
      _$$_RatingsFromJson(json);

  @override
  final double? rate;
  @override
  final int? count;
  @override
  final String? title;
  @override
  final String? body;

  @override
  String toString() {
    return 'Ratings(rate: $rate, count: $count, title: $title, body: $body)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Ratings &&
            (identical(other.rate, rate) ||
                const DeepCollectionEquality().equals(other.rate, rate)) &&
            (identical(other.count, count) ||
                const DeepCollectionEquality().equals(other.count, count)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.body, body) ||
                const DeepCollectionEquality().equals(other.body, body)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(rate) ^
      const DeepCollectionEquality().hash(count) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(body);

  @JsonKey(ignore: true)
  @override
  _$RatingsCopyWith<_Ratings> get copyWith =>
      __$RatingsCopyWithImpl<_Ratings>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RatingsToJson(this);
  }
}

abstract class _Ratings implements Ratings {
  const factory _Ratings(
      {required double? rate,
      required int? count,
      required String? title,
      required String? body}) = _$_Ratings;

  factory _Ratings.fromJson(Map<String, dynamic> json) = _$_Ratings.fromJson;

  @override
  double? get rate => throw _privateConstructorUsedError;
  @override
  int? get count => throw _privateConstructorUsedError;
  @override
  String? get title => throw _privateConstructorUsedError;
  @override
  String? get body => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$RatingsCopyWith<_Ratings> get copyWith =>
      throw _privateConstructorUsedError;
}
