
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:url_launcher/url_launcher.dart';

class TabMenu extends StatefulWidget {

  @override
  _TabMenuState createState() => _TabMenuState();
}

class _TabMenuState extends State<TabMenu> {

  @override
  void initState() {
    super.initState();
    _createRewardedAd();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final AdRequest request = AdRequest(
    // testDevices: <String>[testDevice],
    // keywords: <String>['foo', 'bar'],
    // contentUrl: 'http://foo.com/bar.html',
    // nonPersonalizedAds: true,
  );
  RewardedAd _rewardedAd;
  int _numRewardedLoadAttempts = 0;
  int maxFailedLoadAttempts = 3;
  _createRewardedAd(){
    RewardedAd.load(
        adUnitId: Platform.isAndroid
            ? 'ca-app-pub-3196525236326771/5919792898'
            : 'ca-app-pub-3940256099942544/1712485313',
        // adUnitId:'ca-app-pub-3940256099942544/5224354917',//testing
        request: request,
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            print('$ad loaded.');
            _rewardedAd = ad;
            _numRewardedLoadAttempts = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedAd failed to load: $error');
            _rewardedAd = null;
            _numRewardedLoadAttempts += 1;
            if (_numRewardedLoadAttempts < maxFailedLoadAttempts) {
              _createRewardedAd();
            }
          },
        ));

    return _rewardedAd;
  }
  
  void _showRewardedAd() {
    if (_rewardedAd == null) {
      print('Warning: attempt to show rewarded before loaded.');
      return;
    }
    _rewardedAd.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createRewardedAd();
      },
    );

    _rewardedAd.setImmersiveMode(true);
    _rewardedAd.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
      print('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
    });
    _rewardedAd = null;
  }

  @override
  Widget build(BuildContext context) {
    final Uri _url = Uri(
      scheme: 'mailto',
      path: 'youpeat4u@gmail.com',);

    void _launchUrl() async {
      if (!await launchUrl(_url)) throw 'Could not launch $_url';
    }
    return ListView(
        children: [
          Card(
            child: ListTile(
              title:Text("反馈") ,
              onTap: _launchUrl,
            ),
            
          ),
          Card(
            child: ListTile(
              title: Text("赞助(影片支持)"),
              onTap: _showRewardedAd,
            ),
          )
        ],
        shrinkWrap: true,
    );

  }
}
