import 'package:cloudinary_flutter/cloudinary_object.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../core.dart';

enum UploadPreset { banner, product, category }

class CloudinaryInit {
  static late CloudinaryObject cloudinaryObject;

  static initCloudinary() async {
    cloudinaryObject =
        CloudinaryObject.fromCloudName(cloudName: Environment.cloudName);
  }

  static String get urlUploadCloudinary =>
      'https://api.cloudinary.com/v1_1/${Environment.cloudName}/upload';

  static Future<http.MultipartRequest> _requestSend(
    String imgPath,
    UploadPreset uploadPreset,
  ) async {
    String upload = '';
    switch (uploadPreset) {
      case UploadPreset.banner:
        upload = Environment.uploadPresetBanner;
        break;
      case UploadPreset.product:
        upload = Environment.uploadPresetProduct;
        break;
      case UploadPreset.category:
        upload = Environment.uploadPresetCategory;
        break;
    }
    final url = Uri.parse(urlUploadCloudinary);
    final multipartFile = await http.MultipartFile.fromPath('file', imgPath);
    final request = http.MultipartRequest('POST', url)
      ..fields['upload_preset'] = upload
      ..files.add(multipartFile);
    return request;
  }

  static Future<String> uploadImage(
      String imgPath, UploadPreset uploadPreset) async {
    try {
      final request = await _requestSend(imgPath, uploadPreset);
      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.toBytes();
        final responseString = String.fromCharCodes(responseData);
        final jsonMap = jsonDecode(responseString);
        final url = jsonMap['url'];
        return await url;
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
    return '';
  }
}
