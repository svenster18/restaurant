import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/provider/setting/notification_state_provider.dart';

import '../provider/setting/local_notification_provider.dart';
import '../provider/setting/shared_preferences_provider.dart';
import '../utils/notification_state.dart';

class NotificationField extends StatefulWidget {
  
  const NotificationField({
    super.key,
  });

  @override
  State<NotificationField> createState() => _NotificationFieldState();
}

class _NotificationFieldState extends State<NotificationField> {

  Future<void> _requestPermission() async {
    return await context.read<LocalNotificationProvider>().requestPermissions();
  }

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

  void _changeNotificationSetting(BuildContext context, bool isEnable) async {
    await _requestPermission();
    if (context.mounted) {
      bool isPermissionGranted = context.read<LocalNotificationProvider>().permission ?? false;
      if (!isPermissionGranted) {
        final scaffoldMessenger = ScaffoldMessenger.of(context);

        scaffoldMessenger.showSnackBar(
          SnackBar(
            content: Text(
                "Please accept notification permission!"
            ),
          ),
        );
        return;
      }
      final notificationStateProvider = context.read<NotificationStateProvider>();
      notificationStateProvider.notificationState = isEnable ? NotificationState.enable : NotificationState.disable;

      if (isEnable) {
        _scheduleDailyElevenAMNotification();
      } else {
        _cancelNotification();
      }

      final scaffoldMessenger = ScaffoldMessenger.of(context);
      final sharedPreferencesProvider = context.read<SharedPreferencesProvider>();
      await sharedPreferencesProvider.saveNotificationSettingValue(isEnable);

      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text(
              sharedPreferencesProvider.message
          ),
        ),
      );
    }
  }

  Future<void> _scheduleDailyElevenAMNotification() async {
    context.read<LocalNotificationProvider>().scheduleDailyElevenAMNotification();
  }

  Future<void> _cancelNotification() async {
    context.read<LocalNotificationProvider>().cancelNotification();
  }
}
