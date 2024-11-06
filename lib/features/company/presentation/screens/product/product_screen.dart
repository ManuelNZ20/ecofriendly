import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/utils/functions/show_snackbar.dart';
import '../../../domain/domain.dart';
import '../../../../../core/shared/shared.dart';
import '../../providers/forms/product_discount_form_provider.dart';
import '../../providers/forms/product_form_provider.riverpod.dart';
import '../../providers/product_discount_provider.riverpod.dart';
import '../../providers/product_provider.riverpod.dart';

class ProductCompanyScreen extends ConsumerWidget {
  static const String name = 'product_screen';
  const ProductCompanyScreen({
    super.key,
    required this.idProduct,
  });
  final int idProduct;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = ref.watch(productProvider(idProduct));
    return Scaffold(
      appBar: AppBar(
        leading: const IconButtonArrowBack(),
        title: const Text('Editar Producto'),
        actions: [
          IconButton(
            onPressed: () async {
              final photoPath = await CameraGalleryServiceImpl().takePhoto();
              if (photoPath == null) return;

              ref
                  .read(productFormProvider(product.product!).notifier)
                  .updateProductImage(photoPath);
            },
            icon: const Icon(
              Icons.camera,
            ),
          ),
          IconButton(
            onPressed: () async {
              final photoPath = await CameraGalleryServiceImpl().selectPhoto();
              if (photoPath == null) return;
              ref
                  .read(productFormProvider(product.product!).notifier)
                  .updateProductImage(photoPath);
            },
            icon: const Icon(
              Icons.add_photo_alternate,
            ),
          ),
        ],
      ),
      body: product.isLoading
          ? const FullScreenLoader()
          : _ProductView(product: product.product!),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ref
              .read(productFormProvider(product.product!).notifier)
              .onFormSubmit()
              .then(
            (value) {
              if (!value) return;
              showSnackbar(context, 'Producto Actualizado');
            },
          );
        },
        icon: const Icon(Icons.save_as_outlined),
        label: const Text('Guardar'),
      ),
    );
  }
}

class _ProductView extends ConsumerWidget {
  final Product product;
  const _ProductView({
    required this.product,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productForm = ref.watch(productFormProvider(product));
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: ListView(
        children: [
          SizedBox(
            width: size.width,
            height: 250,
            child: ImageGalleryForm(
              imgUrl: productForm.img,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: _ProductInformation(
              product: product,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductInformation extends ConsumerWidget {
  const _ProductInformation({
    required this.product,
  });
  final Product product;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productForm = ref.watch(productFormProvider(product));
    final productDiscount = ref.watch(productDiscountProvider(product.id));
    final productDiscountForm = ref.watch(productDiscountFormProvider(
        productDiscount.productDiscount == null
            ? newEmptyProductDiscount(product.id)
            : productDiscount.productDiscount!));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        CustomTextFormField(
          label: 'Nombre',
          initialValue: productForm.nameProduct,
          onChanged: ref
              .read(productFormProvider(product).notifier)
              .onNameProductChange,
        ),
        const SizedBox(height: 10),
        CustomTextFormField(
          label: 'Marca',
          initialValue: productForm.brand.toUpperCase(),
          onChanged:
              ref.read(productFormProvider(product).notifier).onBrandChange,
        ),
        const SizedBox(height: 10),
        CustomTextFormField(
          label: 'Descripción',
          initialValue: productForm.description,
          onChanged: ref
              .read(productFormProvider(product).notifier)
              .onDescriptionChange,
          keyboardType: TextInputType.multiline,
          maxLines: 7,
        ),
        const SizedBox(height: 10),
        CustomTextFormField(
          label: 'Precio',
          initialValue:
              '${productForm.price - (productForm.price * productDiscountForm.percentage)}',
          keyboardType: const TextInputType.numberWithOptions(
            decimal: true,
            signed: false,
          ),
          onChanged:
              ref.read(productFormProvider(product).notifier).onPriceChange,
        ),
        const SizedBox(height: 10),
        CustomTextFormField(
          label: 'Cantidad',
          initialValue: '${productForm.amount}',
          keyboardType: const TextInputType.numberWithOptions(
            signed: false,
            decimal: false,
          ),
          onChanged:
              ref.read(productFormProvider(product).notifier).onAmountChange,
        ),
        const SizedBox(height: 10),
        DropdownCategories(
          value: '${productForm.idCategory}',
          onChanged: ref
              .read(productFormProvider(product).notifier)
              .onIdCategoryChange,
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: SwitchDataStatus(
            isActive: productForm.status,
            onChanged:
                ref.read(productFormProvider(product).notifier).onStatusChange,
          ),
        ),
        const SizedBox(height: 10),
        OutlinedButton.icon(
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              useSafeArea: true,
              builder: (context) {
                return FormProductDiscount(
                  idProduct: productForm.idProduct!,
                );
              },
            );
          },
          icon: const Icon(Icons.discount_outlined),
          label: const Text('Agrega un descuento'),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
