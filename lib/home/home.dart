import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gao_wang/home/tab-benefit.dart';
import 'package:gao_wang/home/tab-menu.dart';
import 'package:gao_wang/home/tab-read.dart';
import 'package:gao_wang/home/tab-video.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(0.5, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
              colors: <Color>[Color(0xff074684), Color(0xff000046)]),
          ),
        ),
        bottom: TabBar(
          tabs: [
            Tab(icon: Icon(Icons.auto_stories)),
            Tab(icon: Icon(Icons.video_library)),
            Tab(icon: Icon(Icons.thumb_up)),
            Tab(icon: Icon(Icons.menu)),
          ],
        ),
      ),
      body: TabBarView(
        physics: BouncingScrollPhysics(),
        children: [
          TabRead(),
          TabVideo(),
          TabBenefit(),
          TabMenu(),
        ],
      ),
    );
  }
}

InterstitialAd _interstitialAd;
int _numInterstitialLoadAttempts = 0;
const int maxFailedLoadAttempts = 3;

void _createInterstitialAd() {
  InterstitialAd.load(
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/1033173712'
          : 'ca-app-pub-3940256099942544/4411468910',
      // request: request,
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          print('$ad loaded');
          _interstitialAd = ad;
          _numInterstitialLoadAttempts = 0;
          _interstitialAd.setImmersiveMode(true);
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('InterstitialAd failed to load: $error.');
          _numInterstitialLoadAttempts += 1;
          _interstitialAd = null;
          if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
            _createInterstitialAd();
          }
        },
      ));
}