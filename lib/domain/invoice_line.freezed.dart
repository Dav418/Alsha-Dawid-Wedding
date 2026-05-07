// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invoice_line.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$InvoiceLine {
  String get description => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;

  /// Create a copy of InvoiceLine
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InvoiceLineCopyWith<InvoiceLine> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvoiceLineCopyWith<$Res> {
  factory $InvoiceLineCopyWith(
          InvoiceLine value, $Res Function(InvoiceLine) then) =
      _$InvoiceLineCopyWithImpl<$Res, InvoiceLine>;
  @useResult
  $Res call({String description, double amount});
}

/// @nodoc
class _$InvoiceLineCopyWithImpl<$Res, $Val extends InvoiceLine>
    implements $InvoiceLineCopyWith<$Res> {
  _$InvoiceLineCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InvoiceLine
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? amount = null,
  }) {
    return _then(_value.copyWith(
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InvoiceLineImplCopyWith<$Res>
    implements $InvoiceLineCopyWith<$Res> {
  factory _$$InvoiceLineImplCopyWith(
          _$InvoiceLineImpl value, $Res Function(_$InvoiceLineImpl) then) =
      __$$InvoiceLineImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String description, double amount});
}

/// @nodoc
class __$$InvoiceLineImplCopyWithImpl<$Res>
    extends _$InvoiceLineCopyWithImpl<$Res, _$InvoiceLineImpl>
    implements _$$InvoiceLineImplCopyWith<$Res> {
  __$$InvoiceLineImplCopyWithImpl(
      _$InvoiceLineImpl _value, $Res Function(_$InvoiceLineImpl) _then)
      : super(_value, _then);

  /// Create a copy of InvoiceLine
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? amount = null,
  }) {
    return _then(_$InvoiceLineImpl(
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$InvoiceLineImpl implements _InvoiceLine {
  const _$InvoiceLineImpl({required this.description, this.amount = 0.0});

  @override
  final String description;
  @override
  @JsonKey()
  final double amount;

  @override
  String toString() {
    return 'InvoiceLine(description: $description, amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvoiceLineImpl &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, description, amount);

  /// Create a copy of InvoiceLine
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InvoiceLineImplCopyWith<_$InvoiceLineImpl> get copyWith =>
      __$$InvoiceLineImplCopyWithImpl<_$InvoiceLineImpl>(this, _$identity);
}

abstract class _InvoiceLine implements InvoiceLine {
  const factory _InvoiceLine(
      {required final String description,
      final double amount}) = _$InvoiceLineImpl;

  @override
  String get description;
  @override
  double get amount;

  /// Create a copy of InvoiceLine
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InvoiceLineImplCopyWith<_$InvoiceLineImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
