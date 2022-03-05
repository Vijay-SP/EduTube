import 'package:flutter/material.dart';

class L10n {
  static final all = [
    const Locale('en'),
    const Locale('hi'),
    const Locale('mr'),
    const Locale('ta'),
  ];

  static String getFlag(String code) {
    switch (code) {
      case 'hi':
        return 'हिन्दी';
      case 'mr':
        return 'मराठी';
      case 'ta':
        return 'தமிழ்';
      default:
        return 'ENG';
    }
  }
}
