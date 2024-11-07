import 'package:fast_chat/screens/chat_screen.dart';
import 'package:fast_chat/screens/login_screen.dart';
import 'package:fast_chat/screens/registration_screen.dart';
import 'package:fast_chat/screens/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoutesNames {
  static const String firstScreen = '/';
  static const String registrationRoutes = 'registrationRoutes';
  static const String loginRoute = 'loginRoute';
  static const String chatRoute = 'chatRoute';
}


class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSetting) {
    switch (routeSetting.name) {
      case RoutesNames.firstScreen:
        return MaterialPageRoute(builder: (builder) => WelcomeScreen());
      case RoutesNames.registrationRoutes:
        return MaterialPageRoute(builder: (builder) => RegistrationScreen());
      case RoutesNames.loginRoute:
        return MaterialPageRoute(builder: (builder) => LoginScreen());
      case RoutesNames.chatRoute:
        return MaterialPageRoute(builder: (builder) => ChatScreen());
      default:
        return unDefinedRoute();
    }
  }
}

Route<dynamic> unDefinedRoute() {
  return MaterialPageRoute(
      builder: (builder) => Scaffold(
            appBar: AppBar(
              title: Text("UnDefined Routes"),
            ),
            body: Container(
              child: Center(
                child: Text("You are trying to navigate to Undefined Route"),
              ),
            ),
          ));
}
