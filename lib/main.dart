import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'home/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  // thing to add
  // RequestConfiguration configuration = RequestConfiguration(testDeviceIds: ['8A26531922F86AE0']); //poco x3
  // MobileAds.instance.updateRequestConfiguration(configuration);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: MyHomePage(title: '高王观世音经'),
      home: DefaultTabController(
              length: 4,
              child: MyHomePage(title: '南无高王观世音经'),
            ),
    );
  }
}
