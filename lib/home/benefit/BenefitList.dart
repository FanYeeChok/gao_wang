class BenefitList {
  List<Benefit> benefit;

  BenefitList({this.benefit});

  BenefitList.fromJson(Map<String, dynamic> json) {
    if (json['benefit'] != null) {
      benefit = <Benefit>[];
      json['benefit'].forEach((v) {
        benefit.add(new Benefit.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.benefit != null) {
      data['benefit'] = this.benefit.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Benefit {
  String title;
  String desc;
  String video;

  Benefit({this.title, this.desc, this.video});

  Benefit.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    desc = json['desc'];
    video = json['video'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['desc'] = this.desc;
    data['video'] = this.video;
    return data;
  }
}