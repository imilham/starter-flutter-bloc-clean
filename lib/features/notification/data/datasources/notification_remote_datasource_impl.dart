import 'package:starter/core/error/exceptions.dart';
import 'package:starter/features/notification/data/datasources/notification_remote_datasource.dart';
import 'package:starter/features/notification/data/models/models.dart';
import 'package:starter/utils/utils.dart';

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  NotificationRemoteDataSourceImpl({required this.networkClient});

  final ApiClient networkClient;

  @override
  Future<NotificationsPaginatedModel> fetchNotifications({int page = 1}) async {
    try {
      final response = await networkClient.get(
        '/notification',
        queryParameters: {'page': page.toString()},
      );

      final apiResponse = ApiResponse.fromJson(response.data as Map<String, dynamic>);

      if (apiResponse is ApiFailureResponse) {
        throw ServerException(apiResponse.message);
      }

      final data = apiResponse.data as Map<String, dynamic>?;
      final paginator = apiResponse.paginator?.toJson();

      if (data == null || paginator == null) {
        throw const ServerException('Invalid response format');
      }

      return NotificationsPaginatedModel.fromJson({
        ...data,
        'paginator': paginator,
      });
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<NotificationModel> fetchNotificationById(String uuid) async {
    try {
      final response = await networkClient.get(
        '/notification/get-notification',
        queryParameters: {'uuid': uuid},
      );

      final apiResponse = ApiResponse.fromJson(response.data as Map<String, dynamic>);

      if (apiResponse is ApiFailureResponse) {
        throw ServerException(apiResponse.message);
      }

      return NotificationModel.fromJson(apiResponse.data as Map<String, dynamic>);
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<NotificationModel> markAsRead(String uuid) async {
    try {
      final response = await networkClient.post('/notifications/$uuid/read');

      final apiResponse = ApiResponse.fromJson(response.data as Map<String, dynamic>);

      if (apiResponse is ApiFailureResponse) {
        throw ServerException(apiResponse.message);
      }

      return NotificationModel.fromJson(apiResponse.data as Map<String, dynamic>);
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> deleteNotification(String uuid) async {
    try {
      final response = await networkClient.delete('/notifications/$uuid');

      final apiResponse = ApiResponse.fromJson(response.data as Map<String, dynamic>);

      if (apiResponse is ApiFailureResponse) {
        throw ServerException(apiResponse.message);
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> deleteAllNotifications() async {
    try {
      final response = await networkClient.get('/notifications/clear-all');

      final apiResponse = ApiResponse.fromJson(response.data as Map<String, dynamic>);

      if (apiResponse is ApiFailureResponse) {
        throw ServerException(apiResponse.message);
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<bool> getNotificationSettings() async {
    try {
      final response = await networkClient.get('/notification-settings');

      final apiResponse = ApiResponse.fromJson(response.data as Map<String, dynamic>);

      if (apiResponse is ApiFailureResponse) {
        throw ServerException(apiResponse.message);
      }

      return true;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
