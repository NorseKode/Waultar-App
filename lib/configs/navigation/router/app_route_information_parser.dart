import 'package:flutter/material.dart';

import 'app_route_path.dart';

class AppRouteInformationParser extends RouteInformationParser<AppRoutePath> {
  // Implement if this turns into a web app
  @override
  Future<AppRoutePath> parseRouteInformation(RouteInformation routeInformation) async {
    // if (routeInformation.location != null) {
    //   final uri = Uri.parse(routeInformation.location!);

    //   // root: /
    //   if (uri.pathSegments.length == 0) {
    //     return AppRoutePath.home();
    //   }

    //   if (uri.pathSegments.length == 1) {
    //     if (uri.pathSegments[0] != 'page2')
    //       return AppRoutePath.unknown();
        
    //     return AppRoutePath.page2();
    //   }
    // }

    return AppRoutePath.unknown();
  }
}
