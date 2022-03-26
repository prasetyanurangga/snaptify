import 'package:flutter/material.dart';
import 'package:snaptify/layout/layout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snaptify/blocs/snaptify_bloc/snaptify_bloc.dart';
import 'package:snaptify/blocs/snaptify_bloc/snaptify_event.dart';
import 'package:snaptify/router/router_name.dart';
import 'package:qlevar_router/qlevar_router.dart';

class NotFoundPage extends StatefulWidget {
  const NotFoundPage({Key? key}) : super(key: key);

  @override
  State<NotFoundPage> createState() => _NotFoundPageState();
}

class _NotFoundPageState extends State<NotFoundPage> {

  late AssetImage imageSmall;
  late AssetImage imageMedium;
  late AssetImage imageLarge;

  @override
  void initState() {
    super.initState();
    imageSmall = AssetImage("assets/images/background_small.png");
    imageMedium = AssetImage("assets/images/background_medium.png");
    imageLarge = AssetImage("assets/images/background_large.png");

  }

  @override
  void didChangeDependencies() {
    precacheImage(imageSmall, context);
    precacheImage(imageMedium, context);
    precacheImage(imageLarge, context);
    super.didChangeDependencies();
  }

  Widget _buildMain(){
    return Scaffold(
      body: ResponsiveLayoutBuilder(
        small: (_, __) => Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageSmall,
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children : [
                Text(
                  "404",
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 56,
                    color: Colors.black
                  )
                ),
                Text(
                  "Not Found",
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 24,
                    color: Colors.black
                  )
                )
              ]
            )
          )
        ),
        medium: (_, __) => Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageMedium,
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children : [
                Text(
                  "404",
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 56,
                    color: Colors.black
                  )
                ),
                Text(
                  "Not Found",
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 24,
                    color: Colors.black
                  )
                )
              ]
            )
          ) 
        ),
        large: (_, __) => Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageLarge,
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children : [
                Text(
                  "404",
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 56,
                    color: Colors.black
                  )
                ),
                Text(
                  "Not Found",
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 24,
                    color: Colors.black
                  )
                )
              ]
            )
          )
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildMain();
  }
}
