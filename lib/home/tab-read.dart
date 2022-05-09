import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TabRead extends StatefulWidget {
  @override
  _TabReadState createState() => _TabReadState();
}

class _TabReadState extends State<TabRead> {

  Map<String, dynamic> article = new Map<String, dynamic>();
  List<String> descList =[];

  @override
    void initState() {
      super.initState();
      readJson();
    }

  // Fetch content from the json file
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/json/gaowang.json');
    final data = await json.decode(response);

    setState(() {
      article = data;

      var tagsJson = data['desc'];
      descList = tagsJson != null ? List.from(tagsJson).cast<String>() : null;
    });
  }

@override
  Widget build(BuildContext context) {
    // return Center(
    //           child: Text(
    //             article.isEmpty? "loading": article['title'],
    //         // style: TextStyle(fontSize: 32),
    //           )
    //         );
    return Row(
          children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start ,
                    children : [
                      // Text(
                      // "This text is very very very very very very very very very very very very very very very very very very very very very very very very very long",
                      // )
                      // Text("\n奉請八大菩薩："),
                      RichText(
                        text: TextSpan(
                            // text: '高王觀世音真經（高王經）',
                            text: article.isEmpty? "loading": article['title'],
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 21,
                                fontWeight: FontWeight.bold),
                            children: 
                            descList.isNotEmpty? <TextSpan>[
                              for (var item in descList)
                              TextSpan(
                                  // text: "\n奉請八大菩薩：",
                                  text: item,
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 17,
                                      // fontWeight: FontWeight.bold,
                                      ),
                              ),
                            ] : <TextSpan>[]
                        ),
                      ),
                    ],
                    ),
                  ),
                ),
            ),
          ],
        );
  }
}

