
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

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
    // return Row(
    //       children: [
    //           Expanded(
    //             child: Container(
    //               padding: EdgeInsets.all(10),
    //               child: SingleChildScrollView(
    //                 child:Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start ,
    //                 children : [
    //                   VideoItem(
    //                     videoPlayerController: VideoPlayerController.asset(
    //                       'assets/video/Butterfly-209.mp4',
    //                     ),
    //                     looping: true,
    //                     autoplay: true,
    //                   ),
    //                 ],
    //                 ),
    //               ),
    //             ),
    //         ),
    //       ],
    //     );

    // return SingleChildScrollView(
    //   child: Column(
    //     children: <Widget>[
    //       Container(
    //         padding: const EdgeInsets.only(top: 20.0),
    //       ),
    //       const Text('With assets mp4'),
    //       Container(
    //         padding: const EdgeInsets.all(20),
    //         child: AspectRatio(
    //           aspectRatio: _controller.value.aspectRatio,
    //           child: Stack(
    //             alignment: Alignment.bottomCenter,
    //             children: <Widget>[
    //               VideoPlayer(_controller),
    //               // _ControlsOverlay(controller: _controller),
    //               VideoProgressIndicator(_controller, allowScrubbing: true),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );


    // return ListView(
    //     children: <Widget>[
    //       VideoItem(
    //         videoPlayerController: VideoPlayerController.asset(
    //           'assets/video/Butterfly-209.mp4',
    //         ),
    //         looping: true,
    //         autoplay: false,
    //       ),
    //     ],
    // );
    // VideoPlayerController _controller = VideoPlayerController.asset('assets/video/Butterfly-209.mp4');
    VideoPlayerController _controller = VideoPlayerController.network(
                'https://filedn.com/lqdL3qjUIOwpNp0bzRsB3zY/gaowang/video/nian-song.mp4'
            );
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 20.0),
          ),
          const Text('念诵'),
          Container(
            padding: const EdgeInsets.all(20),
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
    );

  }
}

