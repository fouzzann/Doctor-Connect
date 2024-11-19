import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<String?> uploadImage(File image) async {
  final Dio dio = Dio();
  try {
    String bucketName = dotenv.env['S3_BUCKET_NAME']!;
    String region = dotenv.env['AWS_REGION']!;
    // String accessKey = dotenv.env['AWS_ACCESS_KEY']!;
    // String secretKey = dotenv.env['AWS_SECRET_KEY']!;
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    String url = "https://$bucketName.s3.$region.amazonaws.com/$fileName";
    Map<String, String> headers = {
      "Content-Type": "image/jpeg",
      "x-amz-acl": "public-read",
    };

    File file = File(image.path);
    Response response = await dio.put( 
      url,
      data: file.openRead(),
      options: Options(headers: headers),
    );
    if (response.statusCode == 200) {
      log("File uploaded successfully");

      return url;
    }
    else{
      log('faild to Upload ${response.statusCode}');
      return null;
    }
  } catch (e) {
    log(e.toString());
  }
  return null;


}
