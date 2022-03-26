import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snaptify/blocs/snaptify_bloc/snaptify_bloc.dart';
import 'package:snaptify/providers/api_provider.dart';
import 'package:snaptify/repositories/main_repository.dart';
import 'package:snaptify/router/router_name.dart';
import 'package:snaptify/router/router_generator.dart';
import 'package:snaptify/page/not_found/not_found.dart';
import 'package:qlevar_router/qlevar_router.dart';

 


void main() {
  QR.setUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    QR.settings.notFoundPage = QRoute(path: '/404', builder: ()=> NotFoundPage());

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<MainRepository>(
          create: (context) => MainRepository(),
          lazy: true,
        ),
        RepositoryProvider<ApiProvider>(
          create: (context) => ApiProvider(),
          lazy: true,
        ),
      ],
      child: MultiBlocProvider  (
        providers: [
          BlocProvider<SnaptifyBloc>(
            create: (context)  => SnaptifyBloc(),
          ),
        ],
        child: MaterialApp.router(
          title: 'Snaptify',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: GoogleFonts.poppinsTextTheme(
              Theme.of(context).textTheme, 
            ),
          ),
          routeInformationParser: const QRouteInformationParser(),
          routerDelegate: QRouterDelegate(RouteGenerator.routes)
        )
      ),
    );
  }
}
