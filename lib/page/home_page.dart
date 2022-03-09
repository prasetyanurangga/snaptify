import 'package:flutter/material.dart';
import 'package:snaptify/layout/layout.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Widget _buildMain(){
    return Scaffold(
      body: ResponsiveLayoutBuilder(
        small: (_, __) => Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background_small.png"),
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
                    "Sort your Spotify music by any mood you like and save them as playlists. ",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontSize: 16.0, 
                      fontWeight: FontWeight.w400,
                      color: Colors.black
                    )
                  ),
                  SizedBox(height: 16),
                  TextFormField(
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
                    onPressed: () {},
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
              image: AssetImage("assets/images/background_medium.png"),
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
                    onPressed: () {},
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
              image: AssetImage("assets/images/background_large.png"),
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
                    onPressed: () {},
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
