import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../auth/domain/domain.dart';
import '../../../auth/presentation/riverpod/providers.dart';
// import '../../../company/domain/domain.dart';
import '../../domain/entities/entities.dart';
import '../delegates/search_product_delegate.dart';
import '../riverpod/form/user_app_form_provider.riverpod.dart';
import '../riverpod/search/search_product_provider.dart';
import '../riverpod/user_provider.dart';

class CustomAppBar extends ConsumerWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    final user = ref.watch(userProvider(auth.user!.email));
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              user.isLoading
                  ? const _LoadingDataUser()
                  : user.userProfile != null
                      ? _TextUserProfile(userProfile: user.userProfile!)
                      : const Text('Error loading user profile'),
              const Spacer(),
              IconButton(
                onPressed: () {
                  final searchedProducts = ref.read(searchProductsProvider);
                  final searchQuery = ref.read(searchQueryProvider);
                  showSearch<ProductClient?>(
                    context: context,
                    query: searchQuery,
                    delegate: SearchProductDelegate(
                      initialProducts: searchedProducts,
                      searchProductsCallback: ref
                          .read(searchProductsProvider.notifier)
                          .searchProductByQuery,
                    ),
                  ).then((product) {
                    if (product == null) return;
                    context.push('/home/0/product/${product.id}');
                  });
                },
                icon: const Icon(Icons.search),
              ),
              IconButton(
                onPressed: () => context.push('/home/0/categories'),
                icon: const Icon(Icons.category_rounded),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoadingDataUser extends StatelessWidget {
  const _LoadingDataUser();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 20,
      color: Colors.grey[300],
    );
  }
}

class _TextUserProfile extends ConsumerWidget {
  const _TextUserProfile({
    required this.userProfile,
  });

  final UserApp userProfile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfileForm = ref.watch(userAppFormProvider(userProfile));
    final titleStyle = Theme.of(context).textTheme.titleMedium;
    return Text(
      'Hola, ${userProfileForm.name}',
      style: titleStyle,
    );
  }
}
