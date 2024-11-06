import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../features/company/domain/domain.dart';
import '../../../features/company/presentation/providers/forms/product_discount_form_provider.dart';
import '../../../features/company/presentation/providers/product_discount_provider.riverpod.dart';
import '../shared.dart';

class FormProductDiscount extends ConsumerWidget {
  const FormProductDiscount({
    super.key,
    required this.idProduct,
  });
  final int idProduct;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productDiscount = ref.watch(productDiscountProvider(idProduct));
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              padding: EdgeInsets.zero,
              width: 100,
              height: 8,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadius.all(Radius.circular(50)),
              ),
            ),
            productDiscount.isLoading
                ? const Center(
                    child: CircularProgressContainer(),
                  )
                : _ProductDiscountFormView(
                    productDiscount: productDiscount.productDiscount == null
                        ? newEmptyProductDiscount(idProduct)
                        : productDiscount.productDiscount!,
                  ),
          ],
        ),
      ),
    );
  }
}

class _ProductDiscountFormView extends ConsumerWidget {
  const _ProductDiscountFormView({
    required this.productDiscount,
  });

  final ProductDiscount productDiscount;
  void showSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Descuento de producto actualizado')));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productDiscountForm =
        ref.watch(productDiscountFormProvider(productDiscount));
    return Expanded(
        child: ListView(
      children: [
        const Text('Editar Descuento'),
        const SizedBox(height: 20),
        CustomTextFormField(
          label: 'Porcentaje de descuento',
          initialValue: productDiscountForm.percentage.toString(),
          keyboardType: const TextInputType.numberWithOptions(
            decimal: true,
            signed: false,
          ),
          onChanged: ref
              .read(productDiscountFormProvider(productDiscount).notifier)
              .onDiscountPercentageChange,
        ),
        const SizedBox(height: 20),
        OutlinedButton.icon(
          onPressed: () {
            ref
                .read(productDiscountFormProvider(productDiscount).notifier)
                .onFormSubmit()
                .then((value) {
              if (!value) return;
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: const Text('Descuento Actualizado'),
                    actionsAlignment: MainAxisAlignment.center,
                    actions: [
                      FilledButton.icon(
                          onPressed: () => context.pop(),
                          icon: const Icon(Icons.close),
                          label: const Text('Cerrar')),
                    ],
                  );
                },
              );
            });
          },
          icon: const Icon(Icons.save_outlined),
          label: const Text('Guardar'),
        ),
      ],
    ));
  }
}

ProductDiscount newEmptyProductDiscount(int idproduct) => ProductDiscount(
    idproductdiscount: 'new',
    idproduct: idproduct,
    discountpercentage: 0.0,
    createdAt: DateTime.now(),
    product: Product(
      id: idproduct,
      nameProduct: '',
      brand: '',
      description: '',
      status: false,
      img: '',
      price: 0,
      amount: 0,
      createAt: DateTime.now(),
      updateAt: DateTime.now(),
      expireProduct: DateTime(2024, DateTime.december, 10, 11, 59),
      idCategory: 0,
    ));
