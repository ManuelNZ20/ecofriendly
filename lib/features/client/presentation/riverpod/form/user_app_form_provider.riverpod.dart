import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../auth/domain/domain.dart';
import '../users_provider.dart';

final userAppFormProvider =
    StateNotifierProvider.family<UserFormNotifier, UserFormState, UserApp>(
        (ref, userProfile) {
  final createdOrUpdateUser =
      ref.watch(usersProfileProvider.notifier).createOrUpdateUser;

  return UserFormNotifier(
    onSubmitCallback: createdOrUpdateUser,
    userApp: userProfile,
  );
});

class UserFormNotifier extends StateNotifier<UserFormState> {
  final Future<bool> Function(
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
  )? onSubmitCallback;

  UserFormNotifier({
    this.onSubmitCallback,
    required UserApp userApp,
  }) : super(
          UserFormState(
            id: userApp.id,
            email: userApp.email,
            name: userApp.name!,
            lastName: userApp.lastName!,
            phone: userApp.phone!,
            gender: userApp.gender!,
            address: userApp.address!,
            referenceAddress: userApp.referenceAddress!,
            stateAccount: userApp.accountStatus!,
            age: userApp.age!,
            isFormValid: true,
          ),
        );

  void onEmailChange(String value) {
    state = state.copyWith(
      email: value,
      isFormValid: true,
    );
  }

  void onNameChange(String value) {
    state = state.copyWith(
      name: value,
      isFormValid: true,
    );
  }

  void onLastNameChange(String value) {
    state = state.copyWith(
      lastName: value,
      isFormValid: true,
    );
  }

  void onPhoneChange(String value) {
    state = state.copyWith(
      phone: value,
      isFormValid: true,
    );
  }

  void onAddressChange(String value) {
    state = state.copyWith(
      address: value,
      isFormValid: true,
    );
  }

  Future<bool> onFormSubmit() async {
    if (!state.isFormValid) return false;
    if (onSubmitCallback == null) return false;
    try {
      return await onSubmitCallback!(
        state.id!,
        state.email,
        state.name,
        state.lastName,
        state.phone,
        state.gender,
        state.address,
        state.referenceAddress,
        state.stateAccount,
        state.age,
      );
    } catch (e) {
      return false;
    }
  }
}

class UserFormState {
  final bool isFormValid;
  final String? id;
  final String email;
  final String name;
  final String lastName;
  final String phone;
  final String gender;
  final String address;
  final String referenceAddress;
  final bool stateAccount;
  final int age;

  UserFormState({
    this.isFormValid = false,
    this.id = '',
    this.email = '',
    this.name = '',
    this.lastName = '',
    this.phone = '',
    this.gender = '',
    this.address = '',
    this.referenceAddress = '',
    this.stateAccount = true,
    this.age = 0,
  });

  UserFormState copyWith({
    bool? isFormValid,
    String? id,
    String? email,
    String? name,
    String? lastName,
    String? phone,
    String? gender,
    String? address,
    String? referenceAddress,
    bool? stateAccount,
    int? age,
  }) =>
      UserFormState(
        isFormValid: isFormValid ?? this.isFormValid,
        id: id ?? this.id,
        email: email ?? this.email,
        name: name ?? this.name,
        lastName: lastName ?? this.lastName,
        phone: phone ?? this.phone,
        gender: gender ?? this.gender,
        address: address ?? this.address,
        referenceAddress: referenceAddress ?? this.referenceAddress,
        stateAccount: stateAccount ?? this.stateAccount,
        age: age ?? this.age,
      );
}
