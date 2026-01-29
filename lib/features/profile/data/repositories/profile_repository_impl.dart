import 'package:starter/core/core.dart';
import 'package:starter/features/profile/data/datasources/datasources.dart';
import 'package:starter/features/profile/domain/domain.dart';

/// Implementation of [IProfileRepository].
class ProfileRepositoryImpl implements IProfileRepository {
  ProfileRepositoryImpl({
    this.remoteDataSource,
  });

  final ProfileRemoteDataSource? remoteDataSource;

  @override
  Future<Result<UserProfile>> getProfile() async {
    final remote = remoteDataSource;
    if (remote == null) {
      return const Result.failure(ServerFailure('Remote data source not configured'));
    }
    try {
      final result = await remote.getProfile();
      return Result.success(result);
    } on Exception catch (e) {
      return Result.failure(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Result<UserProfile>> updateProfile({
    required String firstName,
    required String lastName,
    String? phoneNumber,
    DateTime? dateOfBirth,
  }) async {
    final remote = remoteDataSource;
    if (remote == null) {
      return const Result.failure(ServerFailure('Remote data source not configured'));
    }
    try {
      final result = await remote.updateProfile(
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        dateOfBirth: dateOfBirth,
      );
      return Result.success(result);
    } on Exception catch (e) {
      return Result.failure(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Result<void>> deleteProfile() async {
    final remote = remoteDataSource;
    if (remote == null) {
      return const Result.failure(ServerFailure('Remote data source not configured'));
    }
    try {
      await remote.deleteProfile();
      return const Result.success(null);
    } on Exception catch (e) {
      return Result.failure(ServerFailure(e.toString()));
    }
  }
}
