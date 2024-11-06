import 'dart:io';
import 'package:flutter/material.dart';

class ImageGalleryForm extends StatelessWidget {
  const ImageGalleryForm({
    super.key,
    required this.imgUrl,
  });

  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: Colors.grey.shade400,
          fontWeight: FontWeight.w600,
        );
    if (imgUrl.isEmpty) {
      return Container(
        width: double.infinity,
        color: const Color.fromARGB(34, 158, 158, 158),
        child: Center(
          child: Text(
            'Image not found',
            style: textStyle,
          ),
        ),
      );
    }
    late ImageProvider imgProvider;
    if (imgUrl.startsWith('http') || imgUrl.startsWith('https')) {
      imgProvider = NetworkImage(imgUrl);
    } else {
      imgProvider = FileImage(File(imgUrl));
    }
    return FadeInImage(
      fit: BoxFit.cover,
      placeholder: const NetworkImage(
        'https://upload.wikimedia.org/wikipedia/commons/b/b1/Loading_icon.gif',
      ),
      image: imgProvider,
    );
  }
}
