import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/setting/shared_preferences_provider.dart';
import '../provider/setting/theme_mode_provider.dart';

class ThemeField extends StatelessWidget {
  const ThemeField({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text("Restaurant Theme"),
      subtitle: const Text("Change Theme"),
      trailing: Consumer<ThemeModeProvider>(
        builder: (_, provider, _) {
          return DropdownMenu(
            initialSelection: provider.themeMode,
            dropdownMenuEntries:
                ThemeMode.values
                    .map(
                      (themeMode) => DropdownMenuEntry(
                        value: themeMode,
                        label: themeMode.name,
                      ),
                    )
                    .toList(),
            onSelected: (value) async {
              _changeThemeSetting(context, value ?? ThemeMode.system);
            },
          );
        },
      ),
    );
  }

  void _changeThemeSetting(BuildContext context, ThemeMode themeMode) async {
    final themeModeProvider = context.read<ThemeModeProvider>();
    themeModeProvider.themeMode = themeMode;
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final sharedPreferencesProvider = context.read<SharedPreferencesProvider>();
    await sharedPreferencesProvider.saveThemeSettingValue(themeMode);

    scaffoldMessenger.showSnackBar(
      SnackBar(content: Text(sharedPreferencesProvider.message)),
    );
  }
}
