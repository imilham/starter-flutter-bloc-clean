// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notifications_paginated_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PaginationMetadataModel {
  int get currentPage;
  int get lastPage;
  int get perPage;
  int get total;

  /// Create a copy of PaginationMetadataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PaginationMetadataModelCopyWith<PaginationMetadataModel> get copyWith =>
      _$PaginationMetadataModelCopyWithImpl<PaginationMetadataModel>(
          this as PaginationMetadataModel, _$identity);

  /// Serializes this PaginationMetadataModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PaginationMetadataModel &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.lastPage, lastPage) ||
                other.lastPage == lastPage) &&
            (identical(other.perPage, perPage) || other.perPage == perPage) &&
            (identical(other.total, total) || other.total == total));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, currentPage, lastPage, perPage, total);

  @override
  String toString() {
    return 'PaginationMetadataModel(currentPage: $currentPage, lastPage: $lastPage, perPage: $perPage, total: $total)';
  }
}

/// @nodoc
abstract mixin class $PaginationMetadataModelCopyWith<$Res> {
  factory $PaginationMetadataModelCopyWith(PaginationMetadataModel value,
          $Res Function(PaginationMetadataModel) _then) =
      _$PaginationMetadataModelCopyWithImpl;
  @useResult
  $Res call({int currentPage, int lastPage, int perPage, int total});
}

/// @nodoc
class _$PaginationMetadataModelCopyWithImpl<$Res>
    implements $PaginationMetadataModelCopyWith<$Res> {
  _$PaginationMetadataModelCopyWithImpl(this._self, this._then);

  final PaginationMetadataModel _self;
  final $Res Function(PaginationMetadataModel) _then;

  /// Create a copy of PaginationMetadataModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentPage = null,
    Object? lastPage = null,
    Object? perPage = null,
    Object? total = null,
  }) {
    return _then(_self.copyWith(
      currentPage: null == currentPage
          ? _self.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      lastPage: null == lastPage
          ? _self.lastPage
          : lastPage // ignore: cast_nullable_to_non_nullable
              as int,
      perPage: null == perPage
          ? _self.perPage
          : perPage // ignore: cast_nullable_to_non_nullable
              as int,
      total: null == total
          ? _self.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [PaginationMetadataModel].
extension PaginationMetadataModelPatterns on PaginationMetadataModel {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_PaginationMetadataModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PaginationMetadataModel() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_PaginationMetadataModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PaginationMetadataModel():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_PaginationMetadataModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PaginationMetadataModel() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int currentPage, int lastPage, int perPage, int total)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PaginationMetadataModel() when $default != null:
        return $default(
            _that.currentPage, _that.lastPage, _that.perPage, _that.total);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int currentPage, int lastPage, int perPage, int total)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PaginationMetadataModel():
        return $default(
            _that.currentPage, _that.lastPage, _that.perPage, _that.total);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(int currentPage, int lastPage, int perPage, int total)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PaginationMetadataModel() when $default != null:
        return $default(
            _that.currentPage, _that.lastPage, _that.perPage, _that.total);
      case _:
        return null;
    }
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _PaginationMetadataModel implements PaginationMetadataModel {
  const _PaginationMetadataModel(
      {required this.currentPage,
      required this.lastPage,
      required this.perPage,
      required this.total});
  factory _PaginationMetadataModel.fromJson(Map<String, dynamic> json) =>
      _$PaginationMetadataModelFromJson(json);

  @override
  final int currentPage;
  @override
  final int lastPage;
  @override
  final int perPage;
  @override
  final int total;

  /// Create a copy of PaginationMetadataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PaginationMetadataModelCopyWith<_PaginationMetadataModel> get copyWith =>
      __$PaginationMetadataModelCopyWithImpl<_PaginationMetadataModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PaginationMetadataModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PaginationMetadataModel &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.lastPage, lastPage) ||
                other.lastPage == lastPage) &&
            (identical(other.perPage, perPage) || other.perPage == perPage) &&
            (identical(other.total, total) || other.total == total));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, currentPage, lastPage, perPage, total);

  @override
  String toString() {
    return 'PaginationMetadataModel(currentPage: $currentPage, lastPage: $lastPage, perPage: $perPage, total: $total)';
  }
}

/// @nodoc
abstract mixin class _$PaginationMetadataModelCopyWith<$Res>
    implements $PaginationMetadataModelCopyWith<$Res> {
  factory _$PaginationMetadataModelCopyWith(_PaginationMetadataModel value,
          $Res Function(_PaginationMetadataModel) _then) =
      __$PaginationMetadataModelCopyWithImpl;
  @override
  @useResult
  $Res call({int currentPage, int lastPage, int perPage, int total});
}

/// @nodoc
class __$PaginationMetadataModelCopyWithImpl<$Res>
    implements _$PaginationMetadataModelCopyWith<$Res> {
  __$PaginationMetadataModelCopyWithImpl(this._self, this._then);

  final _PaginationMetadataModel _self;
  final $Res Function(_PaginationMetadataModel) _then;

  /// Create a copy of PaginationMetadataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? currentPage = null,
    Object? lastPage = null,
    Object? perPage = null,
    Object? total = null,
  }) {
    return _then(_PaginationMetadataModel(
      currentPage: null == currentPage
          ? _self.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      lastPage: null == lastPage
          ? _self.lastPage
          : lastPage // ignore: cast_nullable_to_non_nullable
              as int,
      perPage: null == perPage
          ? _self.perPage
          : perPage // ignore: cast_nullable_to_non_nullable
              as int,
      total: null == total
          ? _self.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$NotificationsPaginatedModel {
  List<NotificationModel> get items;
  PaginationMetadataModel get metadata;

  /// Create a copy of NotificationsPaginatedModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NotificationsPaginatedModelCopyWith<NotificationsPaginatedModel>
      get copyWith => _$NotificationsPaginatedModelCopyWithImpl<
              NotificationsPaginatedModel>(
          this as NotificationsPaginatedModel, _$identity);

  /// Serializes this NotificationsPaginatedModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NotificationsPaginatedModel &&
            const DeepCollectionEquality().equals(other.items, items) &&
            (identical(other.metadata, metadata) ||
                other.metadata == metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(items), metadata);

  @override
  String toString() {
    return 'NotificationsPaginatedModel(items: $items, metadata: $metadata)';
  }
}

/// @nodoc
abstract mixin class $NotificationsPaginatedModelCopyWith<$Res> {
  factory $NotificationsPaginatedModelCopyWith(
          NotificationsPaginatedModel value,
          $Res Function(NotificationsPaginatedModel) _then) =
      _$NotificationsPaginatedModelCopyWithImpl;
  @useResult
  $Res call({List<NotificationModel> items, PaginationMetadataModel metadata});

  $PaginationMetadataModelCopyWith<$Res> get metadata;
}

/// @nodoc
class _$NotificationsPaginatedModelCopyWithImpl<$Res>
    implements $NotificationsPaginatedModelCopyWith<$Res> {
  _$NotificationsPaginatedModelCopyWithImpl(this._self, this._then);

  final NotificationsPaginatedModel _self;
  final $Res Function(NotificationsPaginatedModel) _then;

  /// Create a copy of NotificationsPaginatedModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? metadata = null,
  }) {
    return _then(_self.copyWith(
      items: null == items
          ? _self.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<NotificationModel>,
      metadata: null == metadata
          ? _self.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as PaginationMetadataModel,
    ));
  }

  /// Create a copy of NotificationsPaginatedModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PaginationMetadataModelCopyWith<$Res> get metadata {
    return $PaginationMetadataModelCopyWith<$Res>(_self.metadata, (value) {
      return _then(_self.copyWith(metadata: value));
    });
  }
}

/// Adds pattern-matching-related methods to [NotificationsPaginatedModel].
extension NotificationsPaginatedModelPatterns on NotificationsPaginatedModel {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_NotificationsPaginatedModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NotificationsPaginatedModel() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_NotificationsPaginatedModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NotificationsPaginatedModel():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_NotificationsPaginatedModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NotificationsPaginatedModel() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            List<NotificationModel> items, PaginationMetadataModel metadata)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NotificationsPaginatedModel() when $default != null:
        return $default(_that.items, _that.metadata);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            List<NotificationModel> items, PaginationMetadataModel metadata)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NotificationsPaginatedModel():
        return $default(_that.items, _that.metadata);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            List<NotificationModel> items, PaginationMetadataModel metadata)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NotificationsPaginatedModel() when $default != null:
        return $default(_that.items, _that.metadata);
      case _:
        return null;
    }
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _NotificationsPaginatedModel implements NotificationsPaginatedModel {
  const _NotificationsPaginatedModel(
      {required final List<NotificationModel> items, required this.metadata})
      : _items = items;
  factory _NotificationsPaginatedModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationsPaginatedModelFromJson(json);

  final List<NotificationModel> _items;
  @override
  List<NotificationModel> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final PaginationMetadataModel metadata;

  /// Create a copy of NotificationsPaginatedModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$NotificationsPaginatedModelCopyWith<_NotificationsPaginatedModel>
      get copyWith => __$NotificationsPaginatedModelCopyWithImpl<
          _NotificationsPaginatedModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$NotificationsPaginatedModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NotificationsPaginatedModel &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.metadata, metadata) ||
                other.metadata == metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_items), metadata);

  @override
  String toString() {
    return 'NotificationsPaginatedModel(items: $items, metadata: $metadata)';
  }
}

/// @nodoc
abstract mixin class _$NotificationsPaginatedModelCopyWith<$Res>
    implements $NotificationsPaginatedModelCopyWith<$Res> {
  factory _$NotificationsPaginatedModelCopyWith(
          _NotificationsPaginatedModel value,
          $Res Function(_NotificationsPaginatedModel) _then) =
      __$NotificationsPaginatedModelCopyWithImpl;
  @override
  @useResult
  $Res call({List<NotificationModel> items, PaginationMetadataModel metadata});

  @override
  $PaginationMetadataModelCopyWith<$Res> get metadata;
}

/// @nodoc
class __$NotificationsPaginatedModelCopyWithImpl<$Res>
    implements _$NotificationsPaginatedModelCopyWith<$Res> {
  __$NotificationsPaginatedModelCopyWithImpl(this._self, this._then);

  final _NotificationsPaginatedModel _self;
  final $Res Function(_NotificationsPaginatedModel) _then;

  /// Create a copy of NotificationsPaginatedModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? items = null,
    Object? metadata = null,
  }) {
    return _then(_NotificationsPaginatedModel(
      items: null == items
          ? _self._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<NotificationModel>,
      metadata: null == metadata
          ? _self.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as PaginationMetadataModel,
    ));
  }

  /// Create a copy of NotificationsPaginatedModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PaginationMetadataModelCopyWith<$Res> get metadata {
    return $PaginationMetadataModelCopyWith<$Res>(_self.metadata, (value) {
      return _then(_self.copyWith(metadata: value));
    });
  }
}

// dart format on
