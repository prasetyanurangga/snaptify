import 'package:flutter/material.dart';
import 'package:snaptify/layout/layout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snaptify/blocs/snaptify_bloc/snaptify_bloc.dart';
import 'package:snaptify/blocs/snaptify_bloc/snaptify_event.dart';
import 'package:snaptify/router/router_name.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'dart:html' as html;
import 'package:uni_links/uni_links.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:spotify/spotify.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  String displayName = "";

  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController();
    imageSmall = AssetImage("assets/images/background_small.png");
    imageMedium = AssetImage("assets/images/background_medium.png");
    imageLarge = AssetImage("assets/images/background_large.png");
    getSpotify();
    
  }

  void getSpotify() async {

    if(html.window.localStorage.containsKey("code")){

      final String itemName = html.window.localStorage["code"] ?? "";
      Dio dio = new Dio();
      dio.options.headers['content-type'] = "application/x-www-form-urlencoded";
      dio.options.headers['authorization'] = "Basic MmQyZTZkZDRiNWI3NGQxNjg3OGQ4NzE2MDQ0YmI3MmM6NWI2ZTU1MjI5M2FkNGFkODhhMWZkZDBjY2Q4MmIxMzQ=";
      var result = await dio.post(
        'https://accounts.spotify.com/api/token',
        data: {
          "code": itemName,
          "redirect_uri": "http://localhost:1234/snaptify/callback.html",
          "grant_type": "authorization_code",
          "code_verifier" : "TjDRHMNr74-x~O2~n-sf6QB0Ij8RZPGL5H2~I9V__meEyr5TQyYP1QbnBGHgM7pXt~XkPZf3UzNor~IK2LsOY1y7Ya6zgGl_E5KRrR_8rk7I7D.eRAE0vNxd7VVekO02"
        }
      );

      var responseBody = result.data;
      print(result);

      if(responseBody['access_token'] != ""){
        html.window.localStorage["access_token"] = responseBody['access_token'];

        var spotify = SpotifyApi.withAccessToken(responseBody['access_token'] ?? "");
        final me = await spotify.me.get();
        setState(() {
            displayName = me.displayName ?? "";
        });
      }
    }
  }

  @override
  void didChangeDependencies() {
    precacheImage(imageSmall, context);
    precacheImage(imageMedium, context);
    precacheImage(imageLarge, context);
    super.didChangeDependencies();
  }

  void onLogin() async {
    final credentials = SpotifyApiCredentials("2d2e6dd4b5b74d16878d8716044bb72c", "5b6e552293ad4ad88a1fdd0ccd82b134");
    final grant = SpotifyApi.authorizationCodeGrant(credentials);
    final redirectUri = 'http://localhost:1234/snaptify/callback.html';
    final scopes = ['playlist-modify-public', 'playlist-modify-private'];

    final authUri = grant.getAuthorizationUrl(
      Uri.parse(redirectUri),
      scopes: scopes,
    );

    html.window.open(authUri.toString()+"&code_challenge_method=S256&code_challenge=Y-rYS_9VOLkbYhxle4yCsXrAO7h3RsRRE4r8a811KhE", '_self');

    
  }



  void onSearch(){
    if(_editingController.text != "") {
      BlocProvider.of<SnaptifyBloc>(context).add(
        GetSnaptifyByImageUrl(
          url: _editingController.text,
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
                    "Sort your Spotify music by any image you like",
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
                      "Sort your Spotify music by any image you like",
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
                      "Sort your Spotify music by any image you like",
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
                  SizedBox(height: 16),
                  displayName == "" ? TextButton(
                    onPressed: () {
                      onLogin();
                    },
                    child: Text(
                      "Login to Save Result Track",
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: 16.0, 
                        fontWeight: FontWeight.w400,
                        color: Colors.black
                      ),
                    ),
                  ) : Text(
                    "Log In As ${displayName}",
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontSize: 16.0, 
                      fontWeight: FontWeight.w400,
                      color: Colors.black
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
