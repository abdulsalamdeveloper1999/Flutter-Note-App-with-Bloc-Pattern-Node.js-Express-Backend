import 'package:flutter/material.dart';

showSnackBar(data, context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(data),
    ),
  );
}
