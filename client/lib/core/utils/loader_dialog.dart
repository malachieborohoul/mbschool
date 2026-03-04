import 'package:flutter/material.dart';
import 'package:mbschool/core/common/widgets/loader.dart';

void showLoaderDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const Loader();
    },
  );
}

void closeLoaderDialog(BuildContext context) {

  if (Navigator.canPop(context)) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
