import 'package:flutter/material.dart';

class SlideApp extends StatelessWidget {
  const SlideApp({
    super.key,
    required this.title,
    required this.caption,
    required this.imgUrl,
  });
  final String title;
  final String caption;
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    final styleTitle = Theme.of(context).textTheme.titleLarge;
    final styleCaption = Theme.of(context).textTheme.bodyLarge;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              image: AssetImage(imgUrl),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: styleTitle,
            ),
            const SizedBox(height: 10),
            Text(
              caption,
              style: styleCaption,
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
