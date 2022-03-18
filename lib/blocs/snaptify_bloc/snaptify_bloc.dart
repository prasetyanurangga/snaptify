import 'dart:async';

import 'package:snaptify/blocs/snaptify_bloc/snaptify_event.dart';
import 'package:snaptify/blocs/snaptify_bloc/snaptify_state.dart';
import 'package:snaptify/models/snaptify_response_model.dart';
import 'package:snaptify/providers/response_data.dart';
import 'package:snaptify/repositories/main_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class SnaptifyBloc extends Bloc<SnaptifyEvent, SnaptifyState> {
  MainRepository mainRepository = MainRepository();

  SnaptifyBloc() : super(SnaptifyInitial()) {
    on<GetSnaptifyByKeyword>((event, emit) async {
      emit(SnaptifyLoading());
      try {
        var data = {
          "keyword" : event.keyword
        };
        final ResponseData<dynamic> response = await mainRepository.getSnaptifyByKeyword(data);
        var finalResponse = response.data;
        if (response.status == Status.ConnectivityError) {
          emit(const SnaptifyFailure(error: ""));
        }
        if (response.status == Status.Success) {
          emit(SnaptifySuccess(data: finalResponse.data as List<Data>));
        } else {
          emit(SnaptifyFailure(error: response.message ??  "Error"));
        }
      } catch (error) {
        print(error);
        emit(SnaptifyFailure(error: error.toString()));
      }
    });

    on<GetSnaptifyByImageUrl>((event, emit) async {
      emit(SnaptifyLoading());
      try {
        var data = {
          "url" : event.url
        };
        final ResponseData<dynamic> response = await mainRepository.getSnaptifyByImageUrl(data);
        var finalResponse = response.data;
        if (response.status == Status.ConnectivityError) {
          emit(const SnaptifyFailure(error: ""));
        }
        if (response.status == Status.Success) {
          emit(SnaptifySuccess(data: finalResponse.data as List<Data>));
        } else {
          emit(SnaptifyFailure(error: response.message ??  "Error"));
        }
      } catch (error) {
        print(error);
        emit(SnaptifyFailure(error: error.toString()));
      }
    });
  }

}
