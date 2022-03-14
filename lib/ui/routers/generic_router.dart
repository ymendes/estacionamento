import 'package:estacionamento/ui/views/home.dart';
import 'package:flutter/material.dart';


class GenericRouter {
  static const String homeRoute = '/home';
  //static const String loginRoute = '/login';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    WidgetBuilder builder;
    switch (settings.name) {
      case homeRoute:
        builder = (BuildContext _) => const Home(title: 'Yuri',);
        break;
      /*
      case loginRoute:
        builder = (BuildContext _) => const LoginScreen();
        break;
      case splashRoute:
        builder = (BuildContext _) => const SplashScreen();
        break;
      */
      default:
        return MaterialPageRoute(
          builder: (_) {
            return Scaffold(
              body: Center(
                child: Text('BUG: Rota não definida para ${settings.name}'),
              ),
            );
          },
        );
    }
    return MaterialPageRoute(builder: builder, settings: settings);
  }
}
