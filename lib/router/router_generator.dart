import 'package:flutter/material.dart';
import 'package:snaptify/router/router_name.dart';
import 'package:snaptify/page/home/home.dart';
import 'package:snaptify/page/result/result.dart' deferred as result;
import 'package:snaptify/router/deffered_loader.dart';
import 'package:qlevar_router/qlevar_router.dart';


class RouteGenerator {

  
  static final routes = <QRoute>[
    QRoute(
      name: RoutesName.HOME_PAGE,
      path: '/', 
      builder: () => HomePage()
    ),
    QRoute(
      name: RoutesName.RESULT_PAGE,
      path: '/result',
      builder: () => result.ResultPage(),
      middleware: [
        DefferedLoader(result.loadLibrary),
      ],
    ),
  ];

}
