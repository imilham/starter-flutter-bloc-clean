import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/features/profile/profile.dart';
import 'package:starter/utils/utils.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  @override
  void initState() {
    super.initState();
    // Trigger load when entering the page
    context.read<ProfileBloc>().add(const ProfileLoadRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: context.l10n.account,
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          
          if (state is ProfileError) {
             return Center(child: Text(state.message));
          }

          if (state is ProfileLoaded || state is ProfileUpdateSuccess) {
            final userProfile = (state is ProfileLoaded) 
                ? state.profile 
                : (state as ProfileUpdateSuccess).profile;

            return ExtendedColumn(
              children: [
                Gap.medium16,
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
                                color: context.colorScheme.primary,
                                borderRadius: const BorderRadius.all(Radius.circular(8)),
                              ),
                              child: InkWell(
                                onTap: () {
                                  log('Edit Profile');
                                },
                                customBorder: const CircleBorder(),
                                child: Icon(Icons.edit, color: context.colorScheme.onPrimary),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Gap.medium16,
                UserDetailItem(
                  title: context.l10n.firstName,
                  value: userProfile.firstName,
                ),
                Gap.small8,
                UserDetailItem(
                  title: context.l10n.lastName,
                  value: userProfile.lastName,
                ),
                Gap.small8,
                const Spacer(),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    context.l10n.editProfile,
                    style: bodyRegular16(fontWeight: FontWeight.bold),
                  ),
                ),
                Gap.medium16,
                OutlinedButton(
                  onPressed: () {},
                  child: Text(
                    context.l10n.changePassword,
                    style: bodyRegular16(fontWeight: FontWeight.bold),
                  ),
                ),
                const RelativeGap(mainAxisExtent: 0.05),
              ],
            );
          }
          
          return const SizedBox.shrink();
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
        color: context.colorScheme.surface,
        borderRadius: AppRadius.small8,
        border: Border.all(
          color: context.colorScheme.outline,
        ),
      ),
      child: Row(
        children: [
          Text(
            title,
            style: bodyRegular16(),
          ),
          const Spacer(),
          Text(
            value,
            style: bodyRegular16(textColor: context.colorScheme.onSurface.withValues(alpha: 0.6)),
          ),
        ],
      ),
    );
  }
}
