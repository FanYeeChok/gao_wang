import 'package:flutter/material.dart';
import 'package:gao_wang/home/tab-read.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

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
          // Center(
          //     child: Text(
          //   article.isEmpty? "loading": article['title'],
          //   // style: TextStyle(fontSize: 32),
          // )),
          TabRead(),
          Icon(Icons.directions_transit),
          Icon(Icons.directions_bike),
          Icon(Icons.directions_bike),
        ],
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       Text(
      //         'You have pushed the button this many times:',
      //       ),
      //       Text(
      //         '$_counter',
      //         style: Theme.of(context).textTheme.headline4,
      //       ),
      //     ],
      //   ),
      // ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      ),
    );
  }
}