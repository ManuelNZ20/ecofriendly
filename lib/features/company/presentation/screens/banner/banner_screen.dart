import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/shared/shared.dart';
import '../../../domain/domain.dart';
import '../../providers/banner_provider.dart';
import '../../providers/forms/banner_form_provider.dart';

class BannerCompanyScreen extends ConsumerWidget {
  static const String name = 'banner_screen';
  const BannerCompanyScreen({
    super.key,
    required this.idBanner,
  });
  final String idBanner;

  void showSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Banner Actualizado')));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final banner = ref.watch(bannerProvider(idBanner));
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leading: const IconButtonArrowBack(),
          title: const Text('Editar Banner'),
          actions: [
            IconButton(
              onPressed: () async {
                final photoPath = await CameraGalleryServiceImpl().takePhoto();
                if (photoPath == null) return;

                photoPath;
                ref
                    .read(bannerFormProvider(banner.bannerCard!).notifier)
                    .updateBannerImage(photoPath);
              },
              icon: const Icon(
                Icons.camera,
              ),
            ),
            IconButton(
              onPressed: () async {
                final photoPath =
                    await CameraGalleryServiceImpl().selectPhoto();
                if (photoPath == null) return;

                photoPath;
                ref
                    .read(bannerFormProvider(banner.bannerCard!).notifier)
                    .updateBannerImage(photoPath);
              },
              icon: const Icon(
                Icons.add_photo_alternate,
              ),
            ),
          ],
        ),
        body: banner.isLoading
            ? const FullScreenLoader()
            : _BannerView(
                bannerCard: banner.bannerCard!,
              ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            ref
                .read(bannerFormProvider(banner.bannerCard!).notifier)
                .onFormSubmit()
                .then(
              (value) {
                if (!value) return;
                showSnackbar(context);
              },
            );
          },
          icon: const Icon(Icons.save),
          label: const Text('Guardar'),
        ),
      ),
    );
  }
}

class _BannerView extends ConsumerWidget {
  final BannerCard bannerCard;
  const _BannerView({required this.bannerCard});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bannerForm = ref.watch(bannerFormProvider(bannerCard));
    final size = MediaQuery.of(context).size;
    return ListView(
      children: [
        SizedBox(
          width: size.width,
          height: 250,
          child: ImageGalleryForm(imgUrl: bannerForm.imgUrl),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: _BannerInformation(
            banner: bannerCard,
          ),
        )
      ],
    );
  }
}

class _BannerInformation extends ConsumerWidget {
  const _BannerInformation({
    required this.banner,
  });
  final BannerCard banner;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bannerForm = ref.watch(bannerFormProvider(banner));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        CustomTextFormField(
          label: 'Titulo',
          initialValue: bannerForm.title,
          onChanged:
              ref.read(bannerFormProvider(banner).notifier).onTitleChange,
        ),
        const SizedBox(height: 10),
        CustomTextFormField(
          label: 'Subtitulo',
          initialValue: bannerForm.subTitle,
          keyboardType: TextInputType.multiline,
          maxLines: 6,
          onChanged:
              ref.read(bannerFormProvider(banner).notifier).onSubTitleChange,
        ),
        const SizedBox(height: 10),
        CustomTextFormField(
          label: 'Titulo de boton',
          initialValue: bannerForm.titleButton,
          onChanged:
              ref.read(bannerFormProvider(banner).notifier).onTitleButtonChange,
        ),
        const SizedBox(height: 10),
        SwitchDataStatus(
          isActive: bannerForm.isActive,
          onChanged: ref
              .read(bannerFormProvider(banner).notifier)
              .onIsActiveStateChange,
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
