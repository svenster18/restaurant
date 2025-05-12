import 'package:flutter/widgets.dart';
import 'package:restaurant/utils/notification_state.dart';

class NotificationStateProvider extends ChangeNotifier {
  NotificationState _notificationState = NotificationState.disable;

  NotificationState get notificationState => _notificationState;

  set notificationState(NotificationState value) {
    _notificationState = value;
    notifyListeners();
  }
}
