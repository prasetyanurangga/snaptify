import 'package:flutter/material.dart';
import 'package:snaptify/layout/layout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snaptify/blocs/snaptify_bloc/snaptify_bloc.dart';
import 'package:snaptify/blocs/snaptify_bloc/snaptify_state.dart';
import 'package:snaptify/models/snaptify_response_model.dart';
import 'package:snaptify/page/result/component/item_track.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {


  Widget _buildMain(){
    return Scaffold(
      body: ResponsiveLayoutBuilder(
        small: (_, __) => Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background_small.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            child: BlocConsumer<SnaptifyBloc, SnaptifyState>(
              listener: (context, state) {
              },
              builder: (context, state) {
                if(state is SnaptifyLoading){
                  return Center(
                    child: Text("Loading")
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
                  return Text(state.error);
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
              image: AssetImage("assets/images/background_medium.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            child: BlocConsumer<SnaptifyBloc, SnaptifyState>(
              listener: (context, state) {
              },
              builder: (context, state) {
                if(state is SnaptifyLoading){
                  return Center(
                    child: Text("Loading")
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
                  return Text(state.error);
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
              image: AssetImage("assets/images/background_large.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            child: BlocConsumer<SnaptifyBloc, SnaptifyState>(
              listener: (context, state) {
                // do stuff here based on BlocA's state
              },
              builder: (context, state) {
                if(state is SnaptifyLoading){
                  return Center(
                    child: Text("Loading")
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
                  return Text(state.error);
                } else {
                  return Container();
                }
              }
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
