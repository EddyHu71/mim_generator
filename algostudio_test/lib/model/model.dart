class ImageFlip {
  bool success;
  Data data;

  ImageFlip({this.success, this.data});

  ImageFlip.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  List<Memes> memes;

  Data({this.memes});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['memes'] != null) {
      memes = new List<Memes>();
      json['memes'].forEach((v) {
        memes.add(new Memes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.memes != null) {
      data['memes'] = this.memes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Memes {
  String id;
  String name;
  String url;
  String width;
  String height;
  String boxCount;

  Memes({this.id, this.name, this.url, this.width, this.height, this.boxCount});

  Memes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    url = json['url'];
    width = json['width'].toString();
    height = json['height'].toString();
    boxCount = json['box_count'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['url'] = this.url;
    data['width'] = this.width;
    data['height'] = this.height;
    data['box_count'] = this.boxCount;
    return data;
  }
}
