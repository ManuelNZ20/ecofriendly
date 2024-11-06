import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:card_swiper/card_swiper.dart';

import '../riverpod/banners_provider.dart';
import '../riverpod/products_provider.dart';
import 'widgets.dart';

class CustomSlideShow extends ConsumerWidget {
  const CustomSlideShow({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final banners = ref.watch(bannersProvider.notifier);
    return SizedBox(
      width: double.infinity,
      height: 230,
      child: StreamBuilder(
        stream: banners.getBannersStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Su conexión a fallado'),
                  TextButton.icon(
                    onPressed: () async {
                      ref.invalidate(productsProvider);
                      ref.invalidate(bannersProvider);
                    },
                    icon: const Icon(Icons.replay_outlined),
                    label: const Text('Intentar otra vez'),
                  ),
                ],
              ),
            );
          }
          final banners = snapshot.data;
          return Swiper(
            itemCount: banners!.length,
            viewportFraction: .8,
            scale: .9,
            autoplay: true,
            itemBuilder: (context, index) {
              final banner = banners[index];
              return BannerCardSwiper(
                imgUrl: banner.imgUrl,
                title: banner.title,
                subTitle: banner.subTitle,
                titleLink: banner.titleLink,
                isActive: banner.isActive,
                location: banner.linkScreen,
              );
            },
          );
        },
      ),
    );
  }
}
