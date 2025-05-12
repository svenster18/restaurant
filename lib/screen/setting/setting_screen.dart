import 'package:flutter/material.dart';
import 'package:restaurant/widgets/theme_field.dart';

import '../../widgets/notification_field.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Setting")),
      body: Column(
        children: [
          NotificationField(),
          ThemeField(),
        ],
      ),
    );
  }
}
