import 'package:flutter/material.dart';
import 'package:snaptify/layout/layout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snaptify/blocs/snaptify_bloc/snaptify_bloc.dart';
import 'package:snaptify/blocs/snaptify_bloc/snaptify_state.dart';
import 'package:snaptify/models/snaptify_response_model.dart';
import 'package:snaptify/page/result/component/item_track.dart';
import 'package:snaptify/router/router_name.dart';
import 'package:qlevar_router/qlevar_router.dart';


class ResultPage extends StatefulWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {

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
                    return ListView.builder(
                      itemCount: data.length,shrinkWrap: true,
                      itemBuilder: (BuildContext ctx, index) {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 16)
                          ,child: ItemTrack(
                            snaptifyData: data[index]
                          )
                        );
                      });
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
                    return ListView.builder(
                      itemCount: data.length,shrinkWrap: true,
                      itemBuilder: (BuildContext ctx, index) {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 16)
                          ,child: ItemTrack(
                            snaptifyData: data[index]
                          )
                        );
                      });
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
                    return GridView.builder(
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
                      });
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
