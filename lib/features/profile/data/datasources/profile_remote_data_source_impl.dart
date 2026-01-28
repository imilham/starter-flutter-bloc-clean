import 'package:starter/features/profile/data/datasources/datasources.dart';
import 'package:starter/features/profile/data/models/models.dart';

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  @override
  Future<UserProfileModel> getProfile() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return const UserProfileModel(
      uuid: '1',
      firstName: 'John',
      lastName: 'Doe',
    );
  }

  @override
  Future<UserProfileModel> updateProfile({required String firstName, required String lastName}) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return UserProfileModel(
      uuid: '1',
      firstName: firstName,
      lastName: lastName,
    );
  }

  @override
  Future<void> deleteProfile() async {
    await Future<void>.delayed(const Duration(seconds: 1));
  }
}
