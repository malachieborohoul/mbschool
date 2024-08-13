import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mbschool/constants/utils.dart';

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
  required VoidCallback onFailed,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      onFailed();
      showSnackBar(context, jsonDecode(response.body)['msg']);
      break;
    case 500:
      onFailed();
      showSnackBar(context, jsonDecode(response.body)['error']);
      break;
    default:
      onFailed();
      showSnackBar(context, jsonDecode(response.body));
      break;
  }
}
