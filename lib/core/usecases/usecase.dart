// ignore_for_file: one_member_abstracts
import 'package:starter/core/usecases/result.dart';

/// Abstract base class for all use cases.
///
/// [Output] is the return type of the use case.
/// [Params] is the type of parameters the use case accepts.
///
/// Example:
/// ```dart
/// class GetUserUseCase implements UseCase<User, GetUserParams> {
///   @override
///   Future<Result<User>> call(GetUserParams params) async {
///     return repository.getUser(params.id);
///   }
/// }
/// ```
abstract interface class UseCase<Output, Params> {
  /// Executes the use case with the given [params].
  Future<Result<Output>> call(Params params);
}

/// Use this class when a use case doesn't require any parameters.
///
/// Example:
/// ```dart
/// class LogoutUseCase implements UseCase<void, NoParams> {
///   @override
///   Future<Result<void>> call(NoParams params) async {
///     return repository.logout();
///   }
/// }
///
/// // Usage:
/// await logoutUseCase(NoParams());
/// ```
class NoParams {
  const NoParams();
}
