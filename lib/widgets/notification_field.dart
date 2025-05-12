import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/provider/setting/notification_state_provider.dart';

import '../provider/setting/shared_preferences_provider.dart';
import '../utils/notification_state.dart';

class NotificationField extends StatelessWidget {
  const NotificationField({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text("Restaurant Notification"),
      subtitle: const Text("Enable Notification"),
      trailing: Consumer<NotificationStateProvider>(
        builder: (context, provider, _) {
          return Switch(
            value: provider.notificationState.isEnable,
            onChanged: (bool value) {
              _changeNotificationSetting(context, value);
            },
          );
        },
      ),
    );
  }

  void _changeNotificationSetting(BuildContext context, bool value) async {
    final notificationStateProvider = context.read<NotificationStateProvider>();
    notificationStateProvider.notificationState =
        value ? NotificationState.enable : NotificationState.disable;

    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final sharedPreferencesProvider = context.read<SharedPreferencesProvider>();
    await sharedPreferencesProvider.saveNotificationSettingValue(value);

    scaffoldMessenger.showSnackBar(
      SnackBar(content: Text(sharedPreferencesProvider.message)),
    );
  }
}
