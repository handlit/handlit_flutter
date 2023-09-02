// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class CustomSnackbar {
  final String message;

  const CustomSnackbar({
    required this.message,
  });

  static show(
    BuildContext context,
    String message,
  ) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    FocusScope.of(context).unfocus();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        elevation: 5.0,
        content: Text(message, style: const TextStyle(color: Colors.white)),
        duration: const Duration(milliseconds: 1500),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
        ),
        action: SnackBarAction(
          textColor: Theme.of(context).colorScheme.background,
          label: '확인',
          onPressed: () {},
        ),
      ),
    );
  }

  static showWithFloating(
    BuildContext context,
    String message,
    EdgeInsets padding,
  ) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    FocusScope.of(context).unfocus();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF2D2C34),
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        margin: padding,
        duration: const Duration(milliseconds: 1500),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        action: SnackBarAction(
          textColor: Theme.of(context).colorScheme.secondary,
          label: '확인',
          onPressed: () {},
        ),
      ),
    );
  }
}
