import 'package:flutter/material.dart';

void buildMessageBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
     
      content: Text(message),
    ),
  );
}
