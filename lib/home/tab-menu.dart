
import 'package:flutter/material.dart';
import 'package:gao_wang/shared/amod-service.dart';
import 'package:url_launcher/url_launcher.dart';

import '../shared/amod-service.dart';

class TabMenu extends StatefulWidget {

  @override
  _TabMenuState createState() => _TabMenuState();
}

class _TabMenuState extends State<TabMenu> {

  AdmobService admobService = new AdmobService();

  @override
  void initState() {
    super.initState();
    admobService.createRewardedAd();
  }

  @override
  void dispose() {
    super.dispose();
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
              onTap: admobService.showRewardedAd,
            ),
          )
        ],
        shrinkWrap: true,
    );

  }
}
