import 'package:flutter/material.dart';

customErrorMessage(BuildContext ctx, String text) {
  ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
    content: Text(text),
    backgroundColor: Colors.red,
  ));
}
