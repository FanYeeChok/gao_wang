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
  void didChangeDependencies() {
    super.didChangeDependencies();
    _createAnchoredBanner(context);
  }

  static const String testDevice = ''; //Chok Poco x3
  final AdRequest request = AdRequest(
    // testDevices: <String>[testDevice],
    // keywords: <String>['foo', 'bar'],
    // contentUrl: 'http://foo.com/bar.html',
    // nonPersonalizedAds: true,
  );
  BannerAd _anchoredBanner;
  bool _loadingAnchoredBanner = false;
  Future<void> _createAnchoredBanner(BuildContext context) async {
      final AnchoredAdaptiveBannerAdSize size =
          await AdSize.getAnchoredAdaptiveBannerAdSize(
        Orientation.portrait,
        MediaQuery.of(context).size.width.truncate(),
      );

      if (size == null) {
        print('Unable to get height of anchored banner.');
        return;
      }

      _anchoredBanner = BannerAd(
        size: size,
        request: request,
        adUnitId: Platform.isAndroid
            ? 'ca-app-pub-3196525236326771/5733720947'
            : 'ca-app-pub-3196525236326771/7679528013',
        // adUnitId: 'ca-app-pub-3940256099942544/6300978111', //testing
        listener: BannerAdListener(
          onAdLoaded: (Ad ad) {
            print('$BannerAd loaded.');
            setState(() {
              _loadingAnchoredBanner = true;
            });
          },
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            print('$BannerAd failedToLoad: $error');
            ad.dispose();
          },
          onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
          onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
          onAdWillDismissScreen: (Ad ad) => print('$BannerAd onAdWillDismissScreen.'),
        ),
      );
      return _anchoredBanner.load();
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
      body: Column(
          children: <Widget>[
            Expanded(
              child: TabBarView(
              physics: BouncingScrollPhysics(),
              children: [
                TabRead(),
                TabVideo(),
                TabBenefit(),
                TabMenu(),
              ],
              ),
            ),
            if(_loadingAnchoredBanner && _anchoredBanner != null)
              Container(
                  height: _anchoredBanner.size.height.toDouble(),
                  width: _anchoredBanner.size.width.toDouble(),
                  child: AdWidget(ad: _anchoredBanner)
              ),
            
          ],
      ),
    );
  }
}
