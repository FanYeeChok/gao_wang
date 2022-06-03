

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobService {

  //Singleton
  AdmobService._privateConstructor();
  static final AdmobService _instance = AdmobService._privateConstructor();
  factory AdmobService() {
    return _instance;
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
  createRewardedAd(){
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
              createRewardedAd();
            }
          },
        ));

    return _rewardedAd;
  }


  void showRewardedAd() {

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
        createRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        createRewardedAd();
      },
    );

    _rewardedAd.setImmersiveMode(true);
    _rewardedAd.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
      print('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
    });
    _rewardedAd = null;
  }

  BannerAd _anchoredBanner;
  BannerAd get getAnchoredBanner => _anchoredBanner;
  bool _loadingAnchoredBanner = false;
  bool get loadingAnchoredBanner => _loadingAnchoredBanner;
  Future<void> createAnchoredBanner(BuildContext context) async {
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
          : 'ca-app-pub-3940256099942544/6300978111',
      // adUnitId: 'ca-app-pub-3940256099942544/6300978111', //testing
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('$BannerAd loaded.');
          // setState(() {
            _loadingAnchoredBanner = true;
          // });
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

  Orientation _currentOrientation;
  bool _isLoaded = false;

  getOrientation(BuildContext context){
    _currentOrientation = MediaQuery.of(context).orientation;
  }

  /// Load another ad, disposing of the current ad if there is one.
  Future<void> _loadAd(BuildContext context) async {
    await _anchoredBanner?.dispose();
    // setState(() {
      _anchoredBanner = null;
      _isLoaded = false;
    // });

    final AnchoredAdaptiveBannerAdSize size =
        await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
            MediaQuery.of(context).size.width.truncate());

    if (size == null) {
      print('Unable to get height of anchored banner.');
      return;
    }

    _anchoredBanner = BannerAd(
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/6300978111'
          : 'ca-app-pub-3940256099942544/2934735716',
      size: size,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('$ad loaded: ${ad.responseInfo}');
          // setState(() {
            // When the ad is loaded, get the ad size and use it to set
            // the height of the ad container.
            _anchoredBanner = ad as BannerAd;
            _isLoaded = true;
          // });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('Anchored adaptive banner failedToLoad: $error');
          ad.dispose();
        },
      ),
    );
    return _anchoredBanner.load();
  }


  Widget _getAdWidget(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (_currentOrientation == orientation &&
            _anchoredBanner != null &&
            _isLoaded) {
          return Container(
            color: Colors.green,
            width: _anchoredBanner.size.width.toDouble(),
            height: _anchoredBanner.size.height.toDouble(),
            child: AdWidget(ad: _anchoredBanner),
          );
        }
        // Reload the ad if the orientation changes.
        if (_currentOrientation != orientation) {
          _currentOrientation = orientation;
          _loadAd(context);
        }
        return Container();
      },
    );
  }

}


