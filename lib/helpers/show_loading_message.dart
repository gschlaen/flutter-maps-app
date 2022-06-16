import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showLoadingMessage(BuildContext context) {
  // Android
  if (Platform.isAndroid) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Please wait'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text('Calculating route'),
            SizedBox(height: 15),
            CircularProgressIndicator(strokeWidth: 2, color: Colors.black),
          ],
        ),
      ),
    );
    return;
  }

  showCupertinoDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const CupertinoAlertDialog(
      title: Text('Please wait'),
      content: CupertinoActivityIndicator(),
    ),
  );
}
