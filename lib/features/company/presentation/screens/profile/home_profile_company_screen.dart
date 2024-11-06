import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/shared/shared.dart';
import '../../../../../core/utils/functions/show_snackbar.dart';
import '../../../../auth/domain/domain.dart';
import '../../providers/forms/company_form_provider.riverpod.dart';
import '../../providers/providers.dart';
import '../screens.dart';

class HomeProfileCompanyScreen extends ConsumerWidget {
  static const String name = 'home_profile_company_screen';
  const HomeProfileCompanyScreen({
    super.key,
    required this.idCompany,
  });
  final String idCompany;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final company = ref.watch(getCompanyDataProvider);
    final companyRes = ref.watch(companyProvider(idCompany));
    return Scaffold(
      appBar: AppBar(
        leading: const IconButtonArrowBack(),
        title: const Text('Perfil'),
        actions: [
          IconButton(
            onPressed: () => context.pushNamed(
              PageProfileCompany.name,
              pathParameters: {
                'id': idCompany,
                'id_company': idCompany,
              },
            ),
            icon: const Icon(Icons.view_comfortable),
          )
        ],
      ),
      body: companyRes.isLoading
          ? const FullScreenLoader()
          : _CompanyForm(
              companyApp: companyRes.company!,
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ref
              .watch(companyFormProvider(companyRes.company!).notifier)
              .onFormSubmit()
              .then((value) {
            if (!value) return;
            showSnackbar(context, 'Datos Actualizados');
          });
        },
        icon: const Icon(Icons.save_as_outlined),
        label: const Text('Guardar'),
      ),
    );
  }
}

class _CompanyForm extends ConsumerWidget {
  const _CompanyForm({
    required this.companyApp,
  });

  final CompanyApp companyApp;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final companyForm = ref.watch(companyFormProvider(companyApp));
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: Colors.grey.shade400,
          fontWeight: FontWeight.w300,
          fontSize: 14,
        );

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: ListView(
        children: [
          SizedBox(
            width: size.width,
            height: 140,
            child: Stack(
              children: [
                SizedBox(
                  width: size.width,
                  height: 140,
                  child: ImageGalleryForm(
                    imgUrl: companyForm.bannerCompany,
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 10,
                  child: IconButton.outlined(
                    onPressed: () async {
                      final photoPath =
                          await CameraGalleryServiceImpl().selectPhoto();
                      if (photoPath == null) return;
                      ref
                          .read(companyFormProvider(companyApp).notifier)
                          .updateImgBanner(photoPath);
                    },
                    icon: const Icon(Icons.image_outlined),
                  ),
                ),
                Positioned(
                  left: 10,
                  bottom: 10,
                  child: Text(
                    'Banner de la empresa',
                    style: textStyle,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 150,
            height: 150,
            child: Stack(
              children: [
                Center(
                    child: ImageGalleryFormAvatar(
                  img: companyForm.imgPresentation,
                  onPressed: () async {
                    final photoPath =
                        await CameraGalleryServiceImpl().selectPhoto();
                    if (photoPath == null) return;
                    ref
                        .read(companyFormProvider(companyApp).notifier)
                        .updateImgPresentation(photoPath);
                  },
                )),
                Positioned(
                  left: 10,
                  bottom: 10,
                  child: Text(
                    'Avatar de presentación',
                    style: textStyle,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: _CompanyInformation(
              companyApp: companyApp,
            ),
          ),
        ],
      ),
    );
  }
}

class _CompanyInformation extends ConsumerWidget {
  const _CompanyInformation({
    required this.companyApp,
  });
  final CompanyApp companyApp;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final companyForm = ref.watch(companyFormProvider(companyApp));
    final textStyle = Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontWeight: FontWeight.w500,
        );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Información de la empresa',
          style: textStyle,
        ),
        const SizedBox(height: 15),
        CustomTextFormField(
          label: 'Correo de la empresa',
          initialValue: companyForm.email,
        ),
        const SizedBox(height: 15),
        CustomTextFormField(
          label: 'Nombre de la Empresa',
          initialValue: companyForm.nameCompany,
          onChanged: ref
              .read(companyFormProvider(companyApp).notifier)
              .onNameCompanyChange,
        ),
        const SizedBox(height: 15),
        CustomTextFormField(
          label: 'Descripción',
          initialValue: companyForm.description,
          onChanged: ref
              .read(companyFormProvider(companyApp).notifier)
              .onDescriptionChange,
          keyboardType: TextInputType.multiline,
          maxLines: 7,
        ),
        const SizedBox(height: 15),
        CustomTextFormField(
          label: 'Dirección',
          initialValue: companyForm.address,
          onChanged: ref
              .read(companyFormProvider(companyApp).notifier)
              .onAddressChange,
        ),
        const SizedBox(height: 15),
        CustomTextFormField(
          label: 'Localización o referencia',
          initialValue: companyForm.location,
          onChanged: ref
              .read(companyFormProvider(companyApp).notifier)
              .onLocationChange,
        ),
        const SizedBox(height: 15),
        CustomTextFormField(
          label: 'Ruc',
          initialValue: companyForm.ruc,
          onChanged:
              ref.read(companyFormProvider(companyApp).notifier).onRucChange,
        ),
        const SizedBox(height: 15),
        CustomTextFormField(
          label: 'Telefono',
          initialValue: companyForm.phone,
          onChanged:
              ref.read(companyFormProvider(companyApp).notifier).onPhoneChange,
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 80),
      ],
    );
  }
}
