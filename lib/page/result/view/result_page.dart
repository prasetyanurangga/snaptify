import 'package:flutter/material.dart';
import 'package:snaptify/layout/layout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snaptify/blocs/snaptify_bloc/snaptify_bloc.dart';
import 'package:snaptify/blocs/snaptify_bloc/snaptify_state.dart';
import 'package:snaptify/models/snaptify_response_model.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {

  Widget _buildMain(){
    return Scaffold(
      body: ResponsiveLayoutBuilder(
        small: (_, __) => Container(),
        medium: (_, __) => Container(),
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
                  return Text("Loading");
                } else if(state is SnaptifySuccess){
                  var data = state.data as List<Data>;
                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                    itemCount: data.length,shrinkWrap: true,
                    itemBuilder: (BuildContext ctx, index) {
                      return Container(
                        height: 150,
                        child : Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children : [
                            Image.network(data[index].image ?? "",  height: 150,  width: 150, 
                                        fit:BoxFit.cover),
                            Expanded(
                              child :Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(data[index].name ?? ""),
                                  Text(data[index].artist ?? "")
                                ]
                              )
                            )
                          ]
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
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildMain();
  }
}
