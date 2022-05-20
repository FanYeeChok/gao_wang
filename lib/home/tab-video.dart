
import 'package:flutter/material.dart';
import 'package:gao_wang/home/video/VideoFollowList.dart';
import 'package:video_player/video_player.dart';

import '../shared/network-web-service.dart';
import '../shared/video/video-player.dart';

class TabVideo extends StatefulWidget {

  @override
  _TabVideoState createState() => _TabVideoState();
}

class _TabVideoState extends State<TabVideo> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

@override
  Widget build(BuildContext context) {
    // VideoPlayerController _controller = VideoPlayerController.asset('assets/video/Butterfly-209.mp4');
    // VideoPlayerController _controller = VideoPlayerController.network(
    //             'https://filedn.com/lqdL3qjUIOwpNp0bzRsB3zY/gaowang/video/nian-song.mp4'
    //         );
    // return SingleChildScrollView(
    //   child: Column(
    //     children: <Widget>[
    //       Container(
    //         padding: const EdgeInsets.only(top: 20.0),
    //       ),
    //       const Text('念诵'),
    //       Container(
    //         padding: const EdgeInsets.all(20),
    //         child: AspectRatio(
    //           aspectRatio: _controller.value.aspectRatio,
    //           child: Stack(
    //             alignment: Alignment.bottomCenter,
    //             children: <Widget>[
    //               VideoItem(
    //                 videoPlayerController: _controller,
    //                 looping: true,
    //                 autoplay: false,
    //               ),
    //             ]
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
      return Column(
        children: <Widget>[
          Expanded(
            flex: 8,
            child: Container(
              alignment: Alignment.center,
              child: FutureBuilder<VideoFollowList>(
              future: fetchData(),
              builder: (context, snapshot) {
                // print("snapshot");
                // print(snapshot.data);
                if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),


                    child: ListView.builder(
                      // itemExtent: 225.0,
                      itemCount: snapshot.data.videoFollowRead.length + 1,
                      // itemBuilder: (context, index) => 
                      itemBuilder: (context, index) {
                        // print("index =:$index");
                        // print("snapshot.data.length =:${snapshot.data.length}");
                        if(index >= snapshot.data.videoFollowRead.length){
                          String textLabel;
                          textLabel = '最后支持 谢谢 :)';

                          return TextButton.icon(
                            icon: Icon(Icons.play_circle_outline_rounded),
                            label: Text(textLabel),
                            onPressed: () async {
                            },
                          );
                        }
                        return _buildListItems(context, snapshot.data.videoFollowRead[index]);
                      },
                    )
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                  // By default, show a loading spinner.
                  return CircularProgressIndicator();
                },
              ),
          ),
          ),
        ],
        );
      }
}

Future<VideoFollowList> fetchData() async {
  const url = "https://filedn.com/lqdL3qjUIOwpNp0bzRsB3zY/gaowang/json/videoFollowRead.json";

  final response = await NetworkWebService().post(url,null);

  VideoFollowList list = VideoFollowList.fromJson(response.data);
  // print('Response list: ${list}');
  return list;
}

Widget _buildListItems(BuildContext context, VideoFollowRead videoRead) {
  VideoPlayerController _controller = VideoPlayerController.network(
                videoRead.video
            );
            
  return Center(
    child: Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            title: Text(videoRead.title),
          ),
          if(videoRead.desc.isNotEmpty)
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Text(
                  videoRead.desc,
                ),
              ],
            )
          ),
          if(videoRead.video.isNotEmpty)
          Container(
                padding: const EdgeInsets.all(1),
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      VideoItem(
                        videoPlayerController: _controller,
                        looping: true,
                        autoplay: false,
                      ),
                    ]
                  ),
                ),
          ),
        ],
      ),
    ),
  );
}

