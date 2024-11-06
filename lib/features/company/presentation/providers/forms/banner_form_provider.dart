import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/shared/shared.dart';
import '../../../domain/domain.dart';
import '../banners_provider.riverpod.dart';

final bannerFormProvider = StateNotifierProvider.family<BannerFormNotifier,
    BannerFormState, BannerCard>((ref, banner) {
  final createdOrUpdatedBanner =
      ref.watch(bannersProvider.notifier).createdOrUpdatedBanner;
  return BannerFormNotifier(
    onSubmitCallback: createdOrUpdatedBanner,
    banner: banner,
  );
});

class BannerFormNotifier extends StateNotifier<BannerFormState> {
  final Future<bool> Function(
    String id,
    String title,
    String subTitle,
    String titleButton,
    bool isActive,
    String imgUrl,
    String linkScreen,
  )? onSubmitCallback;

  BannerFormNotifier({
    this.onSubmitCallback,
    required BannerCard banner,
  }) : super(
          BannerFormState(
            id: banner.idBanner,
            title: banner.title,
            subTitle: banner.subTitle,
            titleButton: banner.titleLink,
            isActive: banner.isActive,
            imgUrl: banner.imgUrl,
            linkScreen: banner.linkScreen,
            isFormValid: true,
          ),
        );

  void updateBannerImage(String imgUrl) {
    state = state.copyWith(
      imgUrl: imgUrl,
    );
  }

  void onTitleChange(String value) {
    state = state.copyWith(
      isFormValid: true,
      title: value,
    );
  }

  void onSubTitleChange(String value) {
    state = state.copyWith(
      isFormValid: true,
      subTitle: value,
    );
  }

  void onTitleButtonChange(String value) {
    state = state.copyWith(
      isFormValid: true,
      titleButton: value,
    );
  }

  void onIsActiveStateChange(bool value) {
    state = state.copyWith(
      isFormValid: true,
      isActive: value,
    );
  }

  Future<bool> onFormSubmit() async {
    if (!state.isFormValid) return false;
    if (onSubmitCallback == null) return false;
    try {
      final keyValueStorageService = KeyValueStorageImpl();
      final id = await keyValueStorageService.getValue<String>('id');
      final linkScreen = '/home_company/profile/$id/page_company/$id';
      // /home_company/profile/572a0580-a492-411e-97bb-0465cccdf422/page_company/572a0580-a492-411e-97bb-0465cccdf422
      return await onSubmitCallback!(
        state.id ?? '',
        state.title,
        state.subTitle,
        state.titleButton,
        state.isActive,
        state.imgUrl,
        linkScreen,
      );
    } catch (e) {
      return false;
    }
  }
}

class BannerFormState {
  final bool isFormValid;
  final String? id;
  final String title;
  final String subTitle;
  final String titleButton;
  final bool isActive;
  final String imgUrl;
  final String? linkScreen;

  BannerFormState({
    this.isFormValid = false,
    this.id = '',
    this.title = '',
    this.subTitle = '',
    this.titleButton = '',
    this.isActive = false,
    this.imgUrl = '',
    this.linkScreen = '',
  });

  BannerFormState copyWith({
    bool? isFormValid,
    String? id,
    String? title,
    String? subTitle,
    String? titleButton,
    bool? isActive,
    String? imgUrl,
    String? linkScreen,
  }) =>
      BannerFormState(
        isFormValid: isFormValid ?? this.isFormValid,
        id: id ?? this.id,
        title: title ?? this.title,
        subTitle: subTitle ?? this.subTitle,
        titleButton: titleButton ?? this.titleButton,
        isActive: isActive ?? this.isActive,
        imgUrl: imgUrl ?? this.imgUrl,
        linkScreen: linkScreen ?? linkScreen,
      );
}
