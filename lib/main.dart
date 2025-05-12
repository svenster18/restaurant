import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/data/api/api_service.dart';
import 'package:restaurant/data/local/local_database_service.dart';
import 'package:restaurant/provider/detail/favorite_icon_provider.dart';
import 'package:restaurant/provider/detail/restaurant_detail_provider.dart';
import 'package:restaurant/provider/favorite/local_database_provider.dart';
import 'package:restaurant/provider/home/restaurant_list_provider.dart';
import 'package:restaurant/provider/review/review_provider.dart';
import 'package:restaurant/provider/setting/local_notification_provider.dart';
import 'package:restaurant/provider/setting/notification_state_provider.dart';
import 'package:restaurant/provider/setting/shared_preferences_provider.dart';
import 'package:restaurant/provider/setting/theme_mode_provider.dart';
import 'package:restaurant/screen/detail/detail_screen.dart';
import 'package:restaurant/screen/main_screen.dart';
import 'package:restaurant/services/setting/local_notification_service.dart';
import 'package:restaurant/services/setting/shared_preferences_service.dart';
import 'package:restaurant/static/navigation_route.dart';
import 'package:restaurant/style/theme/restaurant_theme.dart';
import 'package:restaurant/utils/notification_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
      providers: [
        Provider(
          create: (context) => LocalNotificationService()..init()..configureLocalTimeZone(),
        ),
        ChangeNotifierProvider(
          create: (context) => LocalNotificationProvider(
            context.read<LocalNotificationService>(),
          )..requestPermissions(),
        ),
        Provider(create: (context) => ApiServices()),
        ChangeNotifierProvider(
          create:
              (context) => RestaurantListProvider(context.read<ApiServices>()),
        ),
        ChangeNotifierProvider(
          create:
              (context) =>
                  RestaurantDetailProvider(context.read<ApiServices>()),
        ),
        ChangeNotifierProvider(
          create: (context) => ReviewProvider(context.read<ApiServices>()),
        ),
        ChangeNotifierProvider(create: (context) => FavoriteIconProvider()),
        Provider(create: (context) => LocalDatabaseService()),
        ChangeNotifierProvider(
          create:
              (context) =>
                  LocalDatabaseProvider(context.read<LocalDatabaseService>()),
        ),
        Provider(create: (context) => SharedPreferencesService(prefs)),
        ChangeNotifierProvider(
          create:
              (context) => SharedPreferencesProvider(
                context.read<SharedPreferencesService>(),
              ),
        ),
        ChangeNotifierProvider(
          create: (context) => NotificationStateProvider(),
        ),
        ChangeNotifierProvider(create: (context) => ThemeModeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    final notificationStateProvider = context.read<NotificationStateProvider>();
    final themeStateProvider = context.read<ThemeModeProvider>();
    final sharedPreferencesProvider = context.read<SharedPreferencesProvider>();

    Future.microtask(() async {
      sharedPreferencesProvider.getNotificationSettingValue();
      sharedPreferencesProvider.getThemeSettingValue();
      final notificationEnable = sharedPreferencesProvider.notificationEnable;
      final themeMode = sharedPreferencesProvider.themeMode;

      notificationStateProvider.notificationState =
          notificationEnable
              ? NotificationState.enable
              : NotificationState.disable;
      themeStateProvider.themeMode = themeMode;
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModeProvider>(
      builder: (context, provider, _) {
        return MaterialApp(
          title: 'Restaurant',
          theme: RestaurantTheme.lightTheme,
          darkTheme: RestaurantTheme.darkTheme,
          themeMode: provider.themeMode,
          initialRoute: NavigationRoute.mainRoute.name,
          routes: {
            NavigationRoute.mainRoute.name: (context) => MainScreen(),
            NavigationRoute.detailRoute.name:
                (context) => DetailScreen(
                  restaurantId:
                      ModalRoute.of(context)?.settings.arguments as String,
                ),
          },
        );
      },
    );
  }
}
