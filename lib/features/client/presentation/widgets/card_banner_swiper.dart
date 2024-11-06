import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BannerCardSwiper extends StatelessWidget {
  const BannerCardSwiper({
    super.key,
    required this.imgUrl,
    required this.title,
    required this.subTitle,
    this.location,
    required this.titleLink,
    required this.isActive,
  });
  final String imgUrl;
  final String title;
  final String subTitle;
  final String? location;
  final String titleLink;
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final titleTheme = Theme.of(context).textTheme.titleMedium?.copyWith(
          overflow: TextOverflow.clip,
          fontWeight: FontWeight.w700,
          color: Colors.black,
          backgroundColor: Colors.white,
        );
    final subTitleTheme = Theme.of(context).textTheme.titleMedium?.copyWith(
          overflow: TextOverflow.clip,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: Colors.black,
          backgroundColor: Colors.white.withOpacity(.5),
        );
    // Measure title height
    final textPainter = TextPainter(
      text: TextSpan(text: title, style: titleTheme),
      maxLines: title.length > 21 ? 2 : 1,
      textDirection: TextDirection.ltr,
    )..layout(
        maxWidth: size.width * 0.8,
      );
    final heightTitle = textPainter.size.height;
    return SizedBox(
      width: size.width,
      height: size.height * .3,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Card(
          elevation: 6,
          clipBehavior: Clip.hardEdge,
          child: Stack(
            children: [
              // image
              Positioned(
                // right: 10,
                child: _ImageGallery(imgUrl: imgUrl),
              ),
              // title
              Positioned(
                top: 10,
                left: 10,
                child: SizedBox(
                  width: size.width * .7,
                  height: heightTitle,
                  child: Text(
                    title,
                    style: titleTheme,
                  ),
                ),
              ),
              // subTitle
              Positioned(
                top: 10 + heightTitle + 5,
                left: 10,
                child: SizedBox(
                  width: size.width * .7,
                  child: Text(
                    subTitle,
                    style: subTitleTheme,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
              // button
              Positioned(
                bottom: 10,
                right: 8,
                child: IconButton(
                  onPressed: location == null || location!.isEmpty
                      ? null
                      : () => context.push(location!),
                  icon: const Icon(
                    Icons.business,
                    color: Colors.white,
                  ),
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
      width: size.width,
      height: size.height,
      fit: BoxFit.cover,
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
