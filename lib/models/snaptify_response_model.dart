class SnaptifyResponseModel {
  List<Data>? data;

  SnaptifyResponseModel({this.data});

  SnaptifyResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? name;
  String? artist;
  String? image;
  String? url;

  Data({this.id, this.name, this.image, this.url});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    artist = json['artist'];
    image = json['image'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['artist'] = this.artist;
    data['image'] = this.image;
    data['url'] = this.url;
    return data;
  }
}