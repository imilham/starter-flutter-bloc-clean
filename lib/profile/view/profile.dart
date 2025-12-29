import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:starter/profile/profile.dart';
import 'package:starter/utils/utils.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  late UserProfileService _userProfileService;

  @override
  void initState() {
    super.initState();
    _userProfileService = GetIt.instance<UserProfileService>();
    WidgetsBinding.instance.addPostFrameCallback((_) => _userProfileService.fetchUserProfile());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
      ),
      body: StreamBuilder<ProfileState>(
        stream: _userProfileService.profileStateStream,
        builder: (context, snapshot) {
          final userProfile = _userProfileService.userProfile;
          if (userProfile == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ExtendedColumn(
            children: [
              const FixedGap(mainAxisExtent: 16),
              SizedBox(
                width: double.infinity,
                height: 120,
                child: Center(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: const BorderRadius.all(Radius.circular(8)),
                            ),
                            child: InkWell(
                              onTap: () {
                                log('Edit Profile');
                              },
                              customBorder: const CircleBorder(),
                              child: Icon(Icons.edit, color: Theme.of(context).colorScheme.onPrimary),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const FixedGap(mainAxisExtent: 16),
              UserDetailItem(
                title: 'First Name',
                value: userProfile.firstName,
              ),
              const FixedGap(mainAxisExtent: 8),
              UserDetailItem(
                title: 'Last Name',
                value: userProfile.lastName,
              ),
              const FixedGap(mainAxisExtent: 8),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  
                },
                child: const Text('Edit Profile'),
              ),
              const FixedGap(mainAxisExtent: 16),
              OutlinedButton(
                onPressed: () {
                  
                },
                child: const Text('Change Password'),
              ),
              const RelativeGap(mainAxisExtent: 0.05),
            ],
          );
        },
      ),
    );
  }
}

class UserDetailItem extends StatelessWidget {
  const UserDetailItem({
    required this.title,
    required this.value,
    super.key,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline,
        ),
      ),
      child: Row(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const Spacer(),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }
}
