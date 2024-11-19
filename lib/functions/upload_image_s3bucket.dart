import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<String?> uploadImage(File image) async {
  final dio = Dio();
  try {
    final bucketName = dotenv.env['S3_BUCKET_NAME']!;
    final region = dotenv.env['AWS_REGION']!;
    final extension = image.path.split('.').last.toLowerCase();
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.$extension';
    final uploadUrl = 'https://$bucketName.s3.$region.amazonaws.com/$fileName';
    final publicUrl = 'https://$bucketName.s3.amazonaws.com/$fileName';
    final bytes = await image.readAsBytes();
    String contentType;
    switch (extension) {
      case 'jpg':
      case 'jpeg':
        contentType = 'image/jpeg';
        break;
      case 'png':
        contentType = 'image/png';
        break;
      case 'gif':
        contentType = 'image/gif';
        break;
      default:
        contentType = 'image/jpeg';
    }

    final response = await dio.put(
      uploadUrl,
      data: Stream.fromIterable([bytes]),
      options: Options(
        headers: {
          'Content-Type': contentType,  
          'Content-Length': bytes.length.toString(),
        },
        followRedirects: false,
        validateStatus: (status) => true,
      ),
    );

    if (response.statusCode == 200) {
      log('File uploaded successfully');
      return publicUrl;
    } else {
      log('Failed to upload. Status: ${response.statusCode}, Response: ${response.data}');
      return null;
    }
  } catch (e) {
    log('Upload error: ${e.toString()}');
    return null;
  }
}   