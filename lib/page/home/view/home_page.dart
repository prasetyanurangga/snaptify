import 'package:flutter/material.dart';
import 'package:snaptify/layout/layout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snaptify/blocs/snaptify_bloc/snaptify_bloc.dart';
import 'package:snaptify/blocs/snaptify_bloc/snaptify_event.dart';
import 'package:snaptify/router/router_name.dart';
import 'package:qlevar_router/qlevar_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late TextEditingController _editingController;
  late AssetImage imageSmall;
  late AssetImage imageMedium;
  late AssetImage imageLarge;

  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController();
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

  void onSearch(){
    if(_editingController.text != "") {
      BlocProvider.of<SnaptifyBloc>(context).add(
        GetSnaptifyByKeyword(
          keyword: _editingController.text,
        )
      );

      QR.toName(RoutesName.RESULT_PAGE);
    }
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
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Snaptify",
                    style: Theme.of(context).textTheme.headline2?.copyWith(
                      fontSize: 56.0, 
                      fontWeight: FontWeight.w900,
                      color: Colors.black
                    )
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Sort your Spotify music by any image you like ",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontSize: 16.0, 
                      fontWeight: FontWeight.w400,
                      color: Colors.black
                    )
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _editingController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: "Type URL",
                      fillColor: Color(0xFFECE8E8).withOpacity(0.4),
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 64,
                        vertical: 18
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: Color(0xFF333333)
                    ),
                    onPressed: () {
                      onSearch();
                    },
                    child: Text(
                      "Search",
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: 16.0, 
                        fontWeight: FontWeight.w400,
                        color: Colors.white
                      ),
                    ),
                  ),
                ]
              )
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
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Snaptify",
                    style: Theme.of(context).textTheme.headline2?.copyWith(
                      fontSize: 56.0, 
                      fontWeight: FontWeight.w900,
                      color: Colors.black
                    )
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: 400,
                    child: Text(
                      "Sort your Spotify music by any mood you like and save them as playlists. ",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: 16.0, 
                        fontWeight: FontWeight.w400,
                        color: Colors.black
                      )
                    )
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _editingController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: "Type URL",
                      fillColor: Color(0xFFECE8E8).withOpacity(0.4),
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 64,
                        vertical: 18
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: Color(0xFF333333)
                    ),
                    onPressed: () {
                      onSearch();
                    },
                    child: Text(
                      "Search",
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: 16.0, 
                        fontWeight: FontWeight.w400,
                        color: Colors.white
                      ),
                    ),
                  ),
                ]
              )
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
            child: Container(
              width: 600,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Snaptify",
                    style: Theme.of(context).textTheme.headline2?.copyWith(
                      fontSize: 56.0, 
                      fontWeight: FontWeight.w900,
                      color: Colors.black
                    )
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: 400,
                    child: Text(
                      "Sort your Spotify music by any mood you like and save them as playlists. ",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: 16.0, 
                        fontWeight: FontWeight.w400,
                        color: Colors.black
                      )
                    )
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _editingController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: "Type URL",
                      fillColor: Color(0xFFECE8E8).withOpacity(0.4),
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 64,
                        vertical: 18
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: Color(0xFF333333)
                    ),
                    onPressed: () {
                      onSearch();
                    },
                    child: Text(
                      "Search",
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: 16.0, 
                        fontWeight: FontWeight.w400,
                        color: Colors.white
                      ),
                    ),
                  ),
                ]
              )
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
