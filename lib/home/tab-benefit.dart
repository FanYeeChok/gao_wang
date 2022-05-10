

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../shared/video/video-player.dart';

class TabBenefit extends StatefulWidget {

  @override
  _TabBenefitState createState() => _TabBenefitState();
}

class _TabBenefitState extends State<TabBenefit> {

@override
  Widget build(BuildContext context) {
    // VideoPlayerController _controller = VideoPlayerController.asset('assets/video/Butterfly-209.mp4');
    VideoPlayerController _controller = VideoPlayerController.network(
                'https://filedn.com/lqdL3qjUIOwpNp0bzRsB3zY/gaowang/video/shizun-explain1.mp4'
            );
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 20.0),
          ),
          const Text('好处1'),
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

