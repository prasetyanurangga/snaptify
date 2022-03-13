import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class SnaptifyEvent extends Equatable {
  const SnaptifyEvent();
  @override
  List<Object> get props => [];
}

class GetSnaptifyByKeyword extends SnaptifyEvent {
  final String keyword;
    GetSnaptifyByKeyword({
      required this.keyword
    });
}

class GetSnaptifyByImageUrl extends SnaptifyEvent {
  final String url;
    GetSnaptifyByImageUrl({
      required this.url
    });
}