import 'package:starter/core/error/error.dart';

/// Represents the result of an operation that can either succeed or fail.
///
/// This is a simple alternative to `dartz` Either type.
/// Use [Result.success] for successful outcomes and [Result.failure] for errors.
sealed class Result<T> {
  const Result();

  /// Creates a successful result with the given [data].
  const factory Result.success(T data) = Success<T>;

  /// Creates a failed result with the given [failure].
  const factory Result.failure(Failure failure) = FailureResult<T>;

  /// Returns true if this is a successful result.
  bool get isSuccess => this is Success<T>;

  /// Returns true if this is a failed result.
  bool get isFailure => this is FailureResult<T>;

  /// Returns the data if successful, otherwise returns null.
  T? get data => switch (this) {
        Success<T>(:final data) => data,
        FailureResult<T>() => null,
      };

  /// Returns the failure if failed, otherwise returns null.
  Failure? get failure => switch (this) {
        Success<T>() => null,
        FailureResult<T>(:final failure) => failure,
      };

  /// Maps the success value to a new type.
  Result<R> map<R>(R Function(T data) mapper) => switch (this) {
        Success<T>(:final data) => Result.success(mapper(data)),
        FailureResult<T>(:final failure) => Result.failure(failure),
      };

  /// Folds the result into a single value.
  R fold<R>({
    required R Function(T data) onSuccess,
    required R Function(Failure failure) onFailure,
  }) =>
      switch (this) {
        Success<T>(:final data) => onSuccess(data),
        FailureResult<T>(:final failure) => onFailure(failure),
      };
}

/// Represents a successful result.
final class Success<T> extends Result<T> {
  const Success(this.data);

  @override
  final T data;
}

/// Represents a failed result.
final class FailureResult<T> extends Result<T> {
  const FailureResult(this.failure);

  @override
  final Failure failure;
}
