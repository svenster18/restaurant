import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/data/api/api_service.dart';
import 'package:restaurant/provider/home/restaurant_list_provider.dart';
import 'package:restaurant/screen/home/home_screen.dart';
import 'package:restaurant/static/navigation_route.dart';
import 'package:restaurant/style/theme/restaurant_theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => ApiServices()),
        ChangeNotifierProvider(
          create:
              (context) => RestaurantListProvider(context.read<ApiServices>()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant',
      theme: RestaurantTheme.lightTheme,
      darkTheme: RestaurantTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: NavigationRoute.homeRoute.name,
      routes: {NavigationRoute.homeRoute.name: (context) => HomeScreen()},
    );
  }
}
