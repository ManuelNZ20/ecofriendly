import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../client/presentation/widgets/widgets.dart';
import '../../providers/providers.dart';

class BannersView extends ConsumerWidget {
  static const String name = 'banner_screen';
  const BannersView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final banners = ref.watch(bannersByCompanyProvider);

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(bannersByCompanyProvider);
      },
      child: banners.when(
        data: (data) {
          if (data.isEmpty) {
            return const Center(
              child: Text('No tiene avisos'),
            );
          }
          final banners = data;
          return ListView.builder(
            itemCount: banners.length,
            itemBuilder: (context, index) {
              final banner = banners[index];
              return BannerCardSwiper(
                imgUrl: banner.imgUrl,
                title: banner.title,
                subTitle: banner.subTitle,
                location: '/home_company/banner/${banner.idBanner}',
                titleLink: banner.titleLink,
                isActive: banner.isActive,
              );
            },
          );
        },
        error: (error, stackTrace) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Se presento el siguiente error $error'),
              const SizedBox(height: 20),
              TextButton.icon(
                onPressed: () async => ref.invalidate(bannersByCompanyProvider),
                label: const Text('Intentar otra vez'),
                icon: const Icon(Icons.replay_outlined),
              )
            ],
          );
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          );
        },
      ),
    );
  }
}
