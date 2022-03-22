import 'dart:convert';

import 'package:file_picker/file_picker.dart';

class GoogleServicesParser {
  static Future<Map?> execute() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      withData: true,
    );
    if (result == null) {
      return null;
    }
    var firstFile = result.files[0];
    if (firstFile.extension != 'json') {
      return null;
    }
    var bytes = result.files[0].bytes;
    if (bytes == null) {
      return null;
    }
    var raw = String.fromCharCodes(bytes);
    var parsed = jsonDecode(raw);
    return {
      'apiKey': parsed['client'][0]['api_key'][0]['current_key'],
      'appId': parsed['client'][0]['client_info']['mobilesdk_app_id'],
      'messagingSenderId': parsed['client'][0]['oauth_client'][0]['client_id'],
      'projectId': parsed['project_info']['project_id'],
    };
    // result!.files[0].readStream.toString()
  }
}
