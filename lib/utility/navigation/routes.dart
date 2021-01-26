import 'package:flutter/material.dart';
import 'package:list_tracker_app/presentation/screens/main/main_screen.dart';

/// It provides [Routes.onGenerateRoute]
class Routes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return _materialRouteToScreen(const MainScreen());
  }

  static Route<dynamic> _materialRouteToScreen(Widget screen, [RouteSettings settings]) => MaterialPageRoute<dynamic>(
        builder: (_) => screen,
        settings: settings,
      );
}
