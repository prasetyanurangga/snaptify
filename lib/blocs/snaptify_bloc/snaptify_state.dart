import 'package:snaptify/models/snaptify_response_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class SnaptifyState extends Equatable {
  const SnaptifyState();

  @override
  List<Object> get props => [];
}

class SnaptifyInitial extends SnaptifyState {}

class SnaptifyLoading extends SnaptifyState {}

class SnaptifySuccess extends SnaptifyState {
  final List<Data> data;

  SnaptifySuccess({required this.data});

}

class SnaptifyFailure extends SnaptifyState {
  final String error;

  const SnaptifyFailure({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'SnaptifyFailure { error: $error }';
}