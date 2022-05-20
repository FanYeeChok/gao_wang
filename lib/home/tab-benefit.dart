

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../shared/network-web-service.dart';
import '../shared/video/video-player.dart';
import 'benefit/BenefitList.dart';

class TabBenefit extends StatefulWidget {

  @override
  _TabBenefitState createState() => _TabBenefitState();
}

class _TabBenefitState extends State<TabBenefit> {

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    // VideoPlayerController _controller = VideoPlayerController.asset('assets/video/Butterfly-209.mp4');
    VideoPlayerController _controller = VideoPlayerController.network(
                'https://filedn.com/lqdL3qjUIOwpNp0bzRsB3zY/gaowang/video/shizun-explain1.mp4'
            );
    // return SingleChildScrollView(
    //   child: Column(
    //     children: <Widget>[
    //       Container(
    //         padding: const EdgeInsets.only(top: 20.0),
    //       ),
    //       const Text('好处1'),
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
              child: FutureBuilder<BenefitList>(
              future: fetchData(),
              builder: (context, snapshot) {
                // print("snapshot");
                // print(snapshot.data);
                if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),


                    child: ListView.builder(
                      // itemExtent: 225.0,
                      itemCount: snapshot.data.benefit.length + 1,
                      // itemBuilder: (context, index) => 
                      itemBuilder: (context, index) {
                        // print("index =:$index");
                        // print("snapshot.data.length =:${snapshot.data.length}");
                        if(index >= snapshot.data.benefit.length){
                          String textLabel;
                          textLabel = '最后支持 谢谢 :)';

                          return TextButton.icon(
                            icon: Icon(Icons.play_circle_outline_rounded),
                            label: Text(textLabel),
                            onPressed: () async {
                            },
                          );
                        }
                        return _buildListItems(context, snapshot.data.benefit[index]);
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

Future<BenefitList> fetchData() async {
  const url = "https://filedn.com/lqdL3qjUIOwpNp0bzRsB3zY/gaowang/json/benefit.json";

  final response = await NetworkWebService().post(url,null);

  BenefitList list = BenefitList.fromJson(response.data);
  // print('Response list: ${list}');
  return list;
}

Widget _buildListItems(BuildContext context, Benefit benefit) {
  VideoPlayerController _controller = VideoPlayerController.network(
                benefit.video
            );
            
  return Center(
   child: Card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListTile(
          title: Text(benefit.title),
        ),
        if(benefit.desc.isNotEmpty)
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Text(
                benefit.desc,
              ),
            ],
          )
        ),
        if(benefit.video.isNotEmpty)
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