import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'chip_state_card.dart';

class BannerCardSwiper extends StatelessWidget {
  const BannerCardSwiper({
    super.key,
    required this.imgUrl,
    required this.title,
    required this.subTitle,
    required this.location,
    required this.titleLink,
    required this.isActive,
  });
  final String imgUrl;
  final String title;
  final String subTitle;
  final String location;
  final String titleLink;
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final titleTheme = Theme.of(context)
        .textTheme
        .titleLarge
        ?.copyWith(overflow: TextOverflow.clip);
    final subTitleTheme = Theme.of(context)
        .textTheme
        .titleMedium
        ?.copyWith(overflow: TextOverflow.clip);
// Measure title height
    final textPainter = TextPainter(
      text: TextSpan(text: title, style: titleTheme),
      maxLines: title.length > 21 ? 2 : 1,
      textDirection: TextDirection.ltr,
    )..layout(
        maxWidth: size.width * 0.8,
      );
    final heightTitle = textPainter.size.height;
    return GestureDetector(
      onTap: () => context.push(location),
      child: SizedBox(
        width: size.width,
        height: size.height * .25,
        child: Card(
          child: Stack(
            children: [
              // image
              Positioned(
                right: 0,
                child: _ImageGallery(imgUrl: imgUrl),
              ),
              Positioned(
                right: 0,
                bottom: 4,
                child: ChipStateCard(isActive: isActive),
              ),
              // title
              Positioned(
                top: 10,
                left: 10,
                child: SizedBox(
                  width: size.width * .8,
                  height: heightTitle,
                  child: Text(
                    title,
                    style: titleTheme,
                  ),
                ),
              ),
              // subTitle
              Positioned(
                top: 10 + heightTitle + 10,
                left: 10,
                child: SizedBox(
                  width: size.width * .65,
                  child: Text(
                    subTitle,
                    style: subTitleTheme,
                  ),
                ),
              ),
              // button
              Positioned(
                bottom: 10,
                left: 8,
                child: FilledButton(
                  onPressed: () {},
                  child: Text(titleLink),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ImageGallery extends StatelessWidget {
  const _ImageGallery({
    required this.imgUrl,
  });

  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Image.network(
      width: size.width * .4,
      height: size.height * .3,
      imgUrl == ''
          ? 'https://upload.wikimedia.org/wikipedia/commons/a/a3/Image-not-found.png'
          : imgUrl,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress != null) {
          return SizedBox(
            width: size.width * .4,
            height: size.height * .3,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return child;
      },
    );
  }
}
