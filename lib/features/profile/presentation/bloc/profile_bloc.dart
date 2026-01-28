import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/core/core.dart';
import 'package:starter/features/profile/domain/domain.dart';

part 'profile_event.dart';
part 'profile_state.dart';

/// BLoC for managing profile state.
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({
    required GetProfileUseCase getProfileUseCase,
    required UpdateProfileUseCase updateProfileUseCase,
    required DeleteProfileUseCase deleteProfileUseCase,
  })  : _getProfileUseCase = getProfileUseCase,
        _updateProfileUseCase = updateProfileUseCase,
        _deleteProfileUseCase = deleteProfileUseCase,
        super(const ProfileInitial()) {
    on<ProfileLoadRequested>(_onLoadRequested);
    on<ProfileUpdateRequested>(_onUpdateRequested);
    on<ProfileDeleteRequested>(_onDeleteRequested);
  }

  final GetProfileUseCase _getProfileUseCase;
  final UpdateProfileUseCase _updateProfileUseCase;
  final DeleteProfileUseCase _deleteProfileUseCase;

  Future<void> _onLoadRequested(
    ProfileLoadRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileLoading());

    final result = await _getProfileUseCase(const NoParams());

    result.fold(
      onSuccess: (profile) => emit(ProfileLoaded(profile)),
      onFailure: (failure) => emit(ProfileError(failure.message)),
    );
  }

  Future<void> _onUpdateRequested(
    ProfileUpdateRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileLoading());

    final result = await _updateProfileUseCase(
      UpdateProfileParams(
        firstName: event.firstName,
        lastName: event.lastName,
      ),
    );

    result.fold(
      onSuccess: (profile) => emit(ProfileUpdateSuccess(profile)),
      onFailure: (failure) => emit(ProfileError(failure.message)),
    );
  }

  Future<void> _onDeleteRequested(
    ProfileDeleteRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileLoading());

    final result = await _deleteProfileUseCase(const NoParams());

    result.fold(
      onSuccess: (_) => emit(const ProfileDeleted()),
      onFailure: (failure) => emit(ProfileError(failure.message)),
    );
  }
}
