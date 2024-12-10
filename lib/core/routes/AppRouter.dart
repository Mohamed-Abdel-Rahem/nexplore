import 'package:flutter/material.dart';
import 'package:nexplore/auth/screen/accountInfo.dart';
import 'package:nexplore/auth/screen/loginScreeen.dart';
import 'package:nexplore/auth/screen/morePage.dart';
import 'package:nexplore/auth/screen/settingPage.dart';
import 'package:nexplore/core/routes/routres.dart';
import 'package:nexplore/features/movie/ui/screens/movie_screen.dart';

import '../../features/details/ui/screen/details_screen.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const MovieScreen());

      case Routes.details:
        return MaterialPageRoute(
            builder: (_) => DetailsScreen(), settings: settings);
      case Routes.AccountInformation:
        return MaterialPageRoute(
            builder: (_) => AccountInformation(), settings: settings);
      case Routes.login:
        return MaterialPageRoute(
            builder: (_) => LoginScreeen(), settings: settings);
      case Routes.Settinpage:
        return MaterialPageRoute(
            builder: (_) => SettingPage(), settings: settings);
      case Routes.MorePage:
        return MaterialPageRoute(
            builder: (_) => MorePage(), settings: settings);
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
            appBar: AppBar(
              title: const Text("No Route Found"),
            ),
            body: const Center(child: Text("No Route Found"))));
  }
}
