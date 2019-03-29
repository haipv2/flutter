import 'package:flutter/material.dart';
import 'package:flutter_multilang/language_selector_page.dart';

class LanguageSelectorIconButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        _languageIconTapped(context);
      },
      icon: Icon(
        Icons.settings,
        color: Colors.white,
      ),
    );
  }

  _languageIconTapped(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LanguageSelectorPage(),
      ),
    );
  }
}
