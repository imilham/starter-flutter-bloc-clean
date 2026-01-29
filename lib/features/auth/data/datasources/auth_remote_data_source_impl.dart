// ignore_for_file: unused_local_variable

import 'dart:developer';

import 'package:starter/features/auth/auth.dart';
import 'package:starter/utils/utils.dart';

// ============================================================================
// API Implementation Strategy:
// - Dummy JSON responses are currently active for testing
// - Real API call structure is commented out and ready to use
// - Uncomment API calls when backend is ready
// - Look for "TODO: API-Implementation-X" comments
// ============================================================================

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({required this.apiClient});
  final ApiClient apiClient;

  // ==========================================================================
  // TODO(api-implementation): Step 2: GET PROFILE API
  // ==========================================================================
  // ENDPOINT: GET /user/profile
  //
  // TO IMPLEMENT:
  // 1. Uncomment the API call code below
  // 2. Comment out the dummy response
  // 3. Verify backend response structure
  // ==========================================================================
  @override
  Future<AuthSessionModel> getProfile() async {
    try {
      // TODO(api-implementation): Step 2: GET PROFILE API
      
      // /*
      // Real API Call
      final response = await apiClient.get('/profile');
      // */

      // Mock Data Pattern (aligned with ApiResponse structure)
      // final data = {
      //   'result': true, // ApiResponse uses 'result'
      //   'message': 'User profile fetched successfully',
      //   'payload': {    // ApiSuccessResponse uses 'payload'
      //     'user_id': 'user_123',
      //     'access_token': 'mock_token_${DateTime.now().millisecondsSinceEpoch}',
      //     'created_at': DateTime.now().toIso8601String(),
      //     'is_email_verified': true,
      //     'is_profile_completed': true,
      //   },
      // };

      // Wrap in Dio Response to simulate real network flow
      // final response = Response<dynamic>(
      //   requestOptions: RequestOptions(path: '/user/profile'), 
      //   data: data,
      //   statusCode: 200,
      // );

      // Verify using standard ApiResponse parser
      final apiResponse = ApiResponse.fromJson(response.data as Map<String, dynamic>);
      
      if (apiResponse.isFailure) {
        throw ApiError(message: apiResponse.message);
      }
      
      // Extract payload
      final payload = apiResponse.data as Map<String, dynamic>;
      
      return AuthSessionModel.fromJson(payload);
    } on DioException catch (e) {
      return onError(e);
    } catch (e) {
      throw ApiError(message: 'Failed to fetch profile: $e');
    }
  }

  // ==========================================================================
  // TODO(api-implementation): Step 3: LOGIN API
  // ==========================================================================
  // ENDPOINT: POST /auth/login
  //
  // TO IMPLEMENT:
  // 1. Uncomment the API call code below
  // 2. Comment out the dummy response
  // 3. Verify backend response structure
  // ==========================================================================
  @override
  Future<AuthSessionModel> login({
    required String email,
    required String password,
    required String deviceId,
    required String deviceType,
    String? devicePushToken,
  }) async {
    try {
      final response = await apiClient.post(
        '/login',
        data: FormData.fromMap({
          'email': email,
          'password': password,
          'device_id': deviceId,
          'device_type': deviceType,
          if (devicePushToken != null) 'device_push_token': devicePushToken,
        }),
      );

      // Parse using standard ApiResponse
      final apiResponse = ApiResponse.fromJson(response.data as Map<String, dynamic>);
      
      if (apiResponse.isFailure) {
        throw ApiError(message: apiResponse.message);
      }
      
      // Extract payload and convert to AuthSessionModel
      final payload = apiResponse.data as Map<String, dynamic>;
      return AuthSessionModel.fromJson(payload);
    } on DioException catch (e) {
      return onError(e);
    } catch (e) {
      throw ApiError(message: 'Login failed: $e');
    }
  }

  // ==========================================================================
  // TODO(api-implementation): Step 4: REGISTER/SIGNUP API
  // ==========================================================================
  // ENDPOINT: POST /auth/register
  //
  // TO IMPLEMENT:
  // 1. Uncomment the API call code below
  // 2. Comment out the dummy response
  // 3. Verify backend response structure
  // ==========================================================================
  @override
  Future<AuthSessionModel> register({
    required String email,
    required String password,
    required String deviceId,
    required String deviceType,
    String? devicePushToken,
  }) async {
    try {
      final response = await apiClient.post(
        '/register',
        data: FormData.fromMap({
          'email': email,
          'password': password,
          'device_id': deviceId,
          'device_type': deviceType,
          if (devicePushToken != null) 'device_push_token': devicePushToken,
        }),
      );

      // Parse using standard ApiResponse
      final apiResponse = ApiResponse.fromJson(response.data as Map<String, dynamic>);
      
      if (apiResponse.isFailure) {
        throw ApiError(message: apiResponse.message);
      }
      
      // Extract payload and convert to AuthSessionModel
      final payload = apiResponse.data as Map<String, dynamic>;
      return AuthSessionModel.fromJson(payload);
    } on DioException catch (e) {
      return onError(e);
    } catch (e) {
      throw ApiError(message: 'Registration failed: $e');
    }
  }

  // ==========================================================================
  // TODO(api-implementation): Step 5: LOGOUT API
  // ==========================================================================
  // ENDPOINT: POST /auth/logout
  // NOTE: AuthInterceptor automatically adds token
  //
  // TO IMPLEMENT:
  // 1. Uncomment the API call code below
  // 2. Remove the dummy delay
  // ==========================================================================
  @override
  Future<void> logout({required String token}) async {
    // TODO(developer): Uncomment when backend is ready
    
    try {
      await apiClient.post('/logout');
    } on DioException catch (e) {
      // Don't throw on logout errors - we still want to clear local session
      log('Remote logout failed: ${e.message}', name: 'AuthRemoteDataSource');
    } catch (e) {
      // Don't throw on logout errors - we still want to clear local session
      log('Remote logout failed: $e', name: 'AuthRemoteDataSource');
    }    
  }

  // ==========================================================================
  // TODO(api-implementation): Step 6: VERIFY EMAIL API
  // ==========================================================================
  // ENDPOINT: POST /auth/verify-email
  // NOTE: AuthInterceptor automatically adds token
  //
  // TO IMPLEMENT:
  // 1. Uncomment the API call code below
  // 2. Comment out the dummy response
  // 3. Verify backend response structure
  // ==========================================================================
  @override
  Future<AuthSessionModel> verifyEmail({
    required String code,
    required String token,
  }) async {
    // TODO(developer): Uncomment when backend is ready
    /*
    try {
      final response = await apiClient.post(
        '/auth/verify-email',
        data: FormData.fromMap({
          'code': code,
        }),
      );
      return AuthSessionModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      return onError(e);
    } catch (e) {
      throw ApiError(message: 'Email verification failed: $e');
    }
    */

    // Dummy response for testing
    await Future<void>.delayed(const Duration(seconds: 1));
    return AuthSessionModel(
      accessToken: 'mock_verified_token_${DateTime.now().millisecondsSinceEpoch}',
      userId: 'user_123',
      createdAt: DateTime.now(),
      isEmailVerified: true,
    );
  }

  // ==========================================================================
  // TODO(api-implementation): Step 7: RESEND VERIFICATION CODE API
  // ==========================================================================
  // ENDPOINT: POST /auth/resend-verification
  // NOTE: AuthInterceptor automatically adds token
  //
  // TO IMPLEMENT:
  // 1. Uncomment the API call code below
  // 2. Remove the dummy delay
  // ==========================================================================
  @override
  Future<void> resendVerificationCode({required String token}) async {
    // TODO(developer): Uncomment when backend is ready
    /*
    try {
      await apiClient.post('/auth/resend-verification');
    } on DioException catch (e) {
      return onError(e);
    } catch (e) {
      throw ApiError(message: 'Resend verification failed: $e');
    }
    */

    // Dummy delay for testing
    await Future<void>.delayed(const Duration(milliseconds: 500));
  }

  // ==========================================================================
  // TODO(api-implementation): Step 8: FORGOT PASSWORD API
  // ==========================================================================
  // ENDPOINT: POST /auth/forgot-password
  //
  // TO IMPLEMENT:
  // 1. Uncomment the API call code below
  // 2. Remove the dummy delay
  // ==========================================================================
  @override
  Future<void> forgotPassword({required String email}) async {
    // TODO(developer): Uncomment when backend is ready
    /*
    try {
      await apiClient.post(
        '/auth/forgot-password',
        data: FormData.fromMap({
          'email': email,
        }),
      );
    } on DioException catch (e) {
      return onError(e);
    } catch (e) {
      throw ApiError(message: 'Forgot password failed: $e');
    }
    */

    // Dummy delay for testing
    await Future<void>.delayed(const Duration(milliseconds: 500));
  }
}

// ============================================================================
// IMPLEMENTATION GUIDE
// ============================================================================
// When your backend is ready:
//
// 1. Uncomment the API call code in each method
// 2. Comment out or remove the dummy response/delay
// 3. Test each endpoint individually
// 4. Verify response structure matches AuthSessionModel
//
// Expected backend response format:
// {
//   "access_token": "string",
//   "user_id": "string",
//   "created_at": "ISO8601 string",
//   "is_email_verified": boolean,
//   "is_profile_completed": boolean
// }
// 1. Find the method (use TODO: API-Implementation-X comments)
// 2. Locate these two lines:
//    return AuthSessionModel.fromJson(dummyResponse);
//    return AuthSessionModel.fromJson(response.data as Map<String, dynamic>);
//
// 3. Comment the first line, uncomment the second:
//    return AuthSessionModel.fromJson(dummyResponse);
//    return AuthSessionModel.fromJson(response.data as Map<String, dynamic>);
//
// 4. Test with real backend
// 5. Done! ✅
// ============================================================================

// ============================================================================
// Expected Backend Response Format
// ============================================================================
// All auth endpoints should return JSON matching this structure:
//
// {
//   "access_token": "string",      // JWT token
//   "user_id": "string",            // Unique user identifier
//   "created_at": "ISO8601 string", // Timestamp
//   "is_email_verified": boolean,   // Email verified status
//   "is_profile_completed": boolean // Profile completion status
// }
//
// Update AuthSessionModel.fromJson() if your backend uses different field names
// ============================================================================
