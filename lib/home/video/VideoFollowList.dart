class VideoFollowList {
  List<VideoFollowRead> videoFollowRead;

  VideoFollowList({this.videoFollowRead});

  VideoFollowList.fromJson(Map<String, dynamic> json) {
    if (json['videoFollowRead'] != null) {
      videoFollowRead = <VideoFollowRead>[];
      json['videoFollowRead'].forEach((v) {
        videoFollowRead.add(new VideoFollowRead.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.videoFollowRead != null) {
      data['videoFollowRead'] =
          this.videoFollowRead.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VideoFollowRead {
  String title;
  String desc;
  String video;

  VideoFollowRead({this.title, this.desc, this.video});

  VideoFollowRead.fromJson(Map<String, dynamic> json) {
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
