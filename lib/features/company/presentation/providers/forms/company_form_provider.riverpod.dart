import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../auth/domain/domain.dart';
import '../providers.dart';

final companyFormProvider = StateNotifierProvider.family
    .autoDispose<CompanyFormNotifier, CompanyFormState, CompanyApp>(
        (ref, company) {
  final updateDataCompany =
      ref.watch(companiesProvider.notifier).updatedCompany;
  return CompanyFormNotifier(
    company: company,
    onSubmitCallback: updateDataCompany,
  );
  // return
});

class CompanyFormNotifier extends StateNotifier<CompanyFormState> {
  final Future<bool> Function(
    String id,
    String imgPresentation,
    String bannerCompany,
    String nameCompany,
    String descriptionCompany,
    String location,
    String ruc,
    String address,
    String phone,
    String email,
    String urlWeb,
    String urlFacebook,
    String urlInstagram,
  )? onSubmitCallback;
  CompanyFormNotifier({
    this.onSubmitCallback,
    required CompanyApp company,
  }) : super(
          CompanyFormState(
            idCompany: company.idCompany,
            imgPresentation: company.imgPresentation!,
            bannerCompany: company.bannerCompany!,
            nameCompany: company.nameCompany,
            description: company.description!,
            location: company.location!,
            ruc: company.ruc!,
            address: company.address!,
            phone: company.phone,
            email: company.email,
            urlWeb: company.urlWeb!,
            urlFacebook: company.urlFacebook!,
            urlInstagram: company.urlInstagram!,
            isFormValid: true,
          ),
        );

  void updateImgBanner(String value) {
    state = state.copyWith(
      bannerCompany: value,
    );
  }

  void updateImgPresentation(String value) {
    state = state.copyWith(
      imgPresentation: value,
    );
  }

  void onNameCompanyChange(String value) {
    state = state.copyWith(
      nameCompany: value,
      isFormValid: true,
    );
  }

  void onDescriptionChange(String value) {
    state = state.copyWith(
      description: value,
      isFormValid: true,
    );
  }

  void onLocationChange(String value) {
    state = state.copyWith(
      location: value,
      isFormValid: true,
    );
  }

  onRucChange(String value) {
    state = state.copyWith(
      ruc: value,
      isFormValid: true,
    );
  }

  onAddressChange(String value) {
    state = state.copyWith(
      address: value,
      isFormValid: true,
    );
  }

  onPhoneChange(String value) {
    state = state.copyWith(
      phone: value,
      isFormValid: true,
    );
  }

  onUrlWebChange(String value) {
    state = state.copyWith(
      urlWeb: value,
      isFormValid: true,
    );
  }

  onUrlFacebookChange(String value) {
    state = state.copyWith(
      urlFacebook: value,
      isFormValid: true,
    );
  }

  onUrlInstagramChange(String value) {
    state = state.copyWith(
      urlInstagram: value,
      isFormValid: true,
    );
  }

  Future<bool> onFormSubmit() async {
    if (!state.isFormValid) return false;
    if (onSubmitCallback == null) return false;

    try {
      return await onSubmitCallback!(
        state.idCompany!,
        state.imgPresentation,
        state.bannerCompany,
        state.nameCompany,
        state.description,
        state.location,
        state.ruc,
        state.address,
        state.phone,
        state.email,
        state.urlWeb,
        state.urlFacebook,
        state.urlInstagram,
      );
    } catch (e) {
      return false;
    }
  }
}

class CompanyFormState {
  final bool isFormValid;
  final String? idCompany;
  final String imgPresentation;
  final String bannerCompany;
  final String nameCompany;
  final String description;
  final String email;
  final String location;
  final String ruc;
  final String address;
  final String phone;
  final String urlWeb;
  final String urlFacebook;
  final String urlInstagram;

  CompanyFormState({
    this.isFormValid = false,
    this.idCompany = '',
    this.imgPresentation = '',
    this.bannerCompany = '',
    this.nameCompany = '',
    this.description = '',
    this.email = '',
    this.location = '',
    this.ruc = '',
    this.address = '',
    this.phone = '',
    this.urlWeb = '',
    this.urlFacebook = '',
    this.urlInstagram = '',
  });

  CompanyFormState copyWith({
    bool? isFormValid,
    String? idCompany,
    String? imgPresentation,
    String? bannerCompany,
    String? nameCompany,
    String? description,
    String? email,
    String? location,
    String? ruc,
    String? address,
    String? phone,
    String? urlWeb,
    String? urlFacebook,
    String? urlInstagram,
  }) =>
      CompanyFormState(
        isFormValid: isFormValid ?? this.isFormValid,
        idCompany: idCompany ?? this.idCompany,
        imgPresentation: imgPresentation ?? this.imgPresentation,
        bannerCompany: bannerCompany ?? this.bannerCompany,
        nameCompany: nameCompany ?? this.nameCompany,
        description: description ?? this.description,
        email: email ?? this.email,
        location: location ?? this.location,
        ruc: ruc ?? this.ruc,
        address: address ?? this.address,
        phone: phone ?? this.phone,
        urlWeb: urlWeb ?? this.urlWeb,
        urlFacebook: urlFacebook ?? this.urlFacebook,
        urlInstagram: urlInstagram ?? this.urlInstagram,
      );
}
