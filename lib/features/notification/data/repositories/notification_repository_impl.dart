import 'package:starter/core/usecases/result.dart';
import 'package:starter/core/error/exceptions.dart';
import 'package:starter/core/error/failures.dart';
import 'package:starter/features/notification/data/datasources/datasources.dart';
import 'package:starter/features/notification/data/models/models.dart';
import 'package:starter/features/notification/domain/domain.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  NotificationRepositoryImpl({
    required this.remoteDataSource,
  });

  final NotificationRemoteDataSource remoteDataSource;

  @override
  Future<Result<NotificationsPaginatedEntity>> fetchNotifications({
    int page = 1,
  }) async {
    try {
      // Fetch from remote
      final result = await remoteDataSource.fetchNotifications(page: page);
      return Result.success(result.toEntity());
    } on ServerException catch (e) {
      return Result.failure(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Result.failure(NetworkFailure(e.message));
    } catch (e) {
      return Result.failure(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Result<NotificationEntity>> fetchNotificationById(String uuid) async {
    try {
      final result = await remoteDataSource.fetchNotificationById(uuid);
      return Result.success(result.toEntity());
    } on ServerException catch (e) {
      return Result.failure(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Result.failure(NetworkFailure(e.message));
    } catch (e) {
      return Result.failure(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Result<NotificationEntity>> markAsRead(String uuid) async {
    try {
      final result = await remoteDataSource.markAsRead(uuid);
      return Result.success(result.toEntity());
    } on ServerException catch (e) {
      return Result.failure(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Result.failure(NetworkFailure(e.message));
    } catch (e) {
      return Result.failure(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Result<void>> deleteNotification(String uuid) async {
    try {
      await remoteDataSource.deleteNotification(uuid);
      return const Result.success(null);
    } on ServerException catch (e) {
      return Result.failure(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Result.failure(NetworkFailure(e.message));
    } catch (e) {
      return Result.failure(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Result<void>> deleteAllNotifications() async {
    try {
      await remoteDataSource.deleteAllNotifications();
      return const Result.success(null);
    } on ServerException catch (e) {
      return Result.failure(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Result.failure(NetworkFailure(e.message));
    } catch (e) {
      return Result.failure(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Result<bool>> getNotificationSettings() async {
    try {
      final result = await remoteDataSource.getNotificationSettings();
      return Result.success(result);
    } on ServerException catch (e) {
      return Result.failure(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Result.failure(NetworkFailure(e.message));
    } catch (e) {
      return Result.failure(ServerFailure(e.toString()));
    }
  }
}
