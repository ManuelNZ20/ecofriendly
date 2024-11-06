import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/domain/domain.dart';
import '../../domain/repositories/repositories.dart';
import 'repository/repositories_provider.dart';

final userProvider =
    StateNotifierProvider.family<UserProfileNotifier, UserProfileState, String>(
        (ref, email) {
  final userRepository = ref.watch(userAppRepositoryProvider);
  return UserProfileNotifier(
    userRepository: userRepository,
    email: email,
  );
});

class UserProfileNotifier extends StateNotifier<UserProfileState> {
  final UserClientRepository userRepository;
  UserProfileNotifier({
    required this.userRepository,
    required String email,
  }) : super(UserProfileState(email: email)) {
    print(email);
    loadUserProfile();
  }

  Future<void> loadUserProfile() async {
    try {
      final userProfile = await userRepository.getUserByEmail(state.email);
      state = state.copyWith(
        isLoading: false,
        userProfile: userProfile,
      );
    } catch (e) {
      throw (e.toString());
    }
  }
}

class UserProfileState {
  final String email;
  final UserApp? userProfile;
  final bool isLoading;
  final bool isSaving;

  UserProfileState({
    required this.email,
    this.userProfile,
    this.isLoading = true,
    this.isSaving = false,
  });
  UserProfileState copyWith({
    String? email,
    UserApp? userProfile,
    bool? isLoading,
    bool? isSaving,
  }) =>
      UserProfileState(
        email: email ?? this.email,
        userProfile: userProfile ?? this.userProfile,
        isLoading: isLoading ?? this.isLoading,
        isSaving: isSaving ?? this.isSaving,
      );
}
