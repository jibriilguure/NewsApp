import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'darkMode.dart';

class ChangeThemeButton extends StatelessWidget {
  const ChangeThemeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Switch.adaptive(
      // focusColor: Theme.of(context).colorScheme.secondary,
      // activeColor: Theme.of(context).colorScheme.secondary,
      inactiveThumbColor: Colors.black,

      value: themeProvider.isDarkMode,
      onChanged: (newVal) {
        final provider = Provider.of<ThemeProvider>(context, listen: false);
        provider.toggleTheme(newVal);
      },
    );
  }
}
