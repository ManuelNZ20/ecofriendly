import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/domain/domain.dart';
import '../../domain/repositories/repositories.dart';
import 'repository/repositories_provider.dart';

final usersProfileProvider =
    StateNotifierProvider<UsersNotifier, UsersProfileState>((ref) {
  final userRepository = ref.watch(userAppRepositoryProvider);
  return UsersNotifier(
    userRepository: userRepository,
  );
});

class UsersNotifier extends StateNotifier<UsersProfileState> {
  final UserClientRepository userRepository;

  UsersNotifier({
    required this.userRepository,
  }) : super(UsersProfileState()) {
    loadUsersProfile();
  }

  Future<void> loadUsersProfile() async {
    try {
      state = state.copyWith(
        usersProfile: [],
      );
      if (state.isLoading) return;
      state = state.copyWith(isLoading: true);
      final usersProfile = await userRepository.getUsers();
      if (usersProfile.isEmpty) {
        state = state.copyWith(isLoading: false);
        return;
      }
      state = state.copyWith(
        isLoading: false,
        usersProfile: usersProfile,
      );
    } catch (e) {
      print('Error: $e');
      state = state.copyWith(
        isLoading: false,
      );
    }
  }

  Future<bool> createOrUpdateUser(
    String id,
    String email,
    String name,
    String lastName,
    String phone,
    String gender,
    String address,
    String referenceAddress,
    bool stateAccount,
    int age,
  ) async {
    try {
      // Actualizar datos del usuario
      final user = await userRepository.updateUser(
        id: id,
        email: email,
        name: name,
        lastName: lastName,
        phone: phone,
        gender: gender,
        address: address,
        referenceAddress: referenceAddress,
        stateAccount: stateAccount,
        age: age,
      );
      state = state.copyWith(
        usersProfile:
            state.usersProfile.map((e) => (e.id == id ? user : e)).toList(),
      );
      return true;
    } catch (e) {
      return false;
    }
  }
}

class UsersProfileState {
  final List<UserApp> usersProfile;
  final bool isLoading;
  final bool hasError;

  UsersProfileState({
    this.usersProfile = const [],
    this.isLoading = false,
    this.hasError = false,
  });

  UsersProfileState copyWith({
    List<UserApp>? usersProfile,
    bool? isLoading,
    bool? hasError,
  }) {
    return UsersProfileState(
      usersProfile: usersProfile ?? this.usersProfile,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
    );
  }
}
