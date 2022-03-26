import 'package:flutter/material.dart';
import 'package:snaptify/layout/layout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snaptify/blocs/snaptify_bloc/snaptify_bloc.dart';
import 'package:snaptify/blocs/snaptify_bloc/snaptify_state.dart';
import 'package:snaptify/models/snaptify_response_model.dart';
import 'package:snaptify/page/result/component/item_track.dart';
import 'package:snaptify/router/router_name.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:spotify/spotify.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:html' as html;


class ResultPage extends StatefulWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {

  late AssetImage imageSmall;
  late AssetImage imageMedium;
  late AssetImage imageLarge;
  List<Data> bunchOfData = [];
  late TextEditingController _editingController;

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


  void onSavePlaylist() async {
    List<String> listIdData = [];
    final String? access_token = html.window.localStorage["access_token"];
    var spotify = SpotifyApi.withAccessToken(access_token ?? "");
    final me = await spotify.me.get();
    final playlist = await spotify.playlists.createPlaylist(me.id ?? "", _editingController.text);
    bunchOfData.forEach((data) => listIdData.add("spotify:track:"+data.id!));
    await spotify.playlists.addTracks(listIdData, playlist.id ?? "");

    _editingController.clear();
    QR.show(QDialog(widget: (pop) => AlertDialog(
      title: Text('Success Save Playlist'),
      actions: [
        TextButton(
          child: Text(
            'Okay',
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                fontSize: 16.0, 
                fontWeight: FontWeight.w400,
                color: Colors.black
            ),
          ),
          onPressed: () {
            QR.back();
          },
        ),
      ],
    )));
  }

  void showDialog(List<Data> data){
    if(html.window.localStorage.containsKey("access_token")){

     QR.show(QDialog(widget: (pop) => AlertDialog(
        title: Text('Create Playlist'),
        content: TextFormField(
          controller: _editingController,
          decoration: InputDecoration(
            hintText: "Type Playlist Name",
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
        actions: [
          TextButton(
            child: Text(
              'Save',
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontSize: 16.0, 
                  fontWeight: FontWeight.w400,
                  color: Colors.black
              ),
            ),
            onPressed: () {
              setState(() {
                bunchOfData = data;
              });

              QR.back();
              onSavePlaylist();
            },
          ),
        ],
      )));
     } else {
      QR.show(QDialog(widget: (pop) => AlertDialog(
        title: Text('Please login to be able to save track'),
        actions: [
          TextButton(
            child: Text(
              'Okay',
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontSize: 16.0, 
                  fontWeight: FontWeight.w400,
                  color: Colors.black
              ),
            ),
            onPressed: () {
              
              QR.back();
            },
          ),
        ],
      )));
     }
  }

  


  Widget _buildMain(){
    return BlocListener<SnaptifyBloc, SnaptifyState>(
      listener: (context, state) {
        if(state is SnaptifyInitial) {
          QR.toName(RoutesName.HOME_PAGE);
        }
      },
      child: Scaffold(
        body: ResponsiveLayoutBuilder(
          small: (_, __) => Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageSmall,
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              child: BlocBuilder<SnaptifyBloc, SnaptifyState>(
                builder: (context, state) {
                  if(state is SnaptifyLoading){
                    return Center(
                      child: Text(
                        "Loading",
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 32,
                          color: Colors.black
                        )
                      )
                    );
                  } else if(state is SnaptifySuccess){
                    var data = state.data as List<Data>;
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: data.length,shrinkWrap: true,
                              itemBuilder: (BuildContext ctx, index) {
                                return Container(
                                  margin: EdgeInsets.symmetric(vertical: 16)
                                  ,child: ItemTrack(
                                    snaptifyData: data[index]
                                  )
                                );
                              }
                            )
                          ),

                            SizedBox(height: 32),
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              backgroundColor: Color(0xFF333333)
                            ),
                            onPressed: () {
                              showDialog(data);
                            },
                            child: Text(
                              "Save As Playlist",
                              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                fontSize: 12.0, 
                                fontWeight: FontWeight.w400,
                                color: Colors.white
                              ),
                            ),
                          ),
                        ]
                    );
                  } else if(state is SnaptifyFailure) {
                    return Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children : [
                          Text(
                            "500",
                            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 56,
                              color: Colors.black
                            )
                          ),
                          Text(
                            "Internal Server Error",
                            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 24,
                              color: Colors.black
                            )
                          )
                        ]
                      )
                    );
                  } else {
                    return Container();
                  }
                }
              )
            )
          ),
          medium: (_, __) => Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageMedium,
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              child: BlocBuilder<SnaptifyBloc, SnaptifyState>(
                builder: (context, state) {
                  if(state is SnaptifyLoading){
                    return Center(
                      child: Text(
                        "Loading",
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 32,
                          color: Colors.black
                        )
                      )
                    );
                  } else if(state is SnaptifySuccess){
                    var data = state.data as List<Data>;
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: data.length,shrinkWrap: true,
                              itemBuilder: (BuildContext ctx, index) {
                                return Container(
                                  margin: EdgeInsets.symmetric(vertical: 16)
                                  ,child: ItemTrack(
                                    snaptifyData: data[index]
                                  )
                                );
                              }
                            )
                          ),
                          SizedBox(height: 32),
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              backgroundColor: Color(0xFF333333)
                            ),
                            onPressed: () {
                              showDialog(data);
                            },
                            child: Text(
                              "Save As Playlist",
                              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                fontSize: 12.0, 
                                fontWeight: FontWeight.w400,
                                color: Colors.white
                              ),
                            ),
                          ),
                        ]
                    );
                  } else if(state is SnaptifyFailure) {
                    return Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children : [
                          Text(
                            "500",
                            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 56,
                              color: Colors.black
                            )
                          ),
                          Text(
                            "Internal Server Error",
                            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 24,
                              color: Colors.black
                            )
                          )
                        ]
                      )
                    );
                  } else {
                    return Container();
                  }
                }
              )
            )
          ),
          large: (_, __) => Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageLarge,
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              child: BlocBuilder<SnaptifyBloc, SnaptifyState>(
                builder: (context, state) {
                  if(state is SnaptifyLoading){
                    return Center(
                      child: Text(
                        "Loading",
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 32,
                          color: Colors.black
                        )
                      )
                    );
                  } else if(state is SnaptifySuccess){
                    var data = state.data as List<Data>;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Result",
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                  fontSize: 24.0, 
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black
                                )
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 16
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  backgroundColor: Color(0xFF333333)
                                ),
                                onPressed: () {
                                  showDialog(data);
                                },
                                child: Text(
                                  "Save As Playlist",
                                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                    fontSize: 12.0, 
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white
                                  ),
                                ),
                              ),
                            ]
                        ),
                        SizedBox(height: 32),
                        Expanded(
                          child : GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              mainAxisExtent: 64.0,
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 16
                            ),
                            itemCount: data.length,shrinkWrap: true,
                            itemBuilder: (BuildContext ctx, index) {
                              return ItemTrack(
                                snaptifyData: data[index]
                              );
                            }
                          )
                        )
                      ]
                    );
                  } else if(state is SnaptifyFailure) {
                    return Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children : [
                          Text(
                            "500",
                            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 56,
                              color: Colors.black
                            )
                          ),
                          Text(
                            "Internal Server Error",
                            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 24,
                              color: Colors.black
                            )
                          )
                        ]
                      )
                    );
                  } else {
                    return Container();
                  }
                }
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
