import 'package:flutter/material.dart';
import 'package:true_time/true_time.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _initialized = false;
  DateTime _currentTime;

  @override
  initState() {
    super.initState();
    _initPlatformState();
  }

  _initPlatformState() async {
    bool initialized = await TrueTime.init();
    setState(() {
      _initialized = initialized;
    });
    _updateCurrentTime();
  }

  _updateCurrentTime() async {
    DateTime now = await TrueTime.now();
    setState(() {
      _currentTime = now;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        floatingActionButton: new FloatingActionButton(
          tooltip: 'Get current time',
          child: new Icon(Icons.timer),
          onPressed: _updateCurrentTime,
        ),
        appBar: new AppBar(
          title: new Text('Example TrueTime app'),
        ),
        body: new Column(
          children: <Widget>[
            new Text('TrueTime is initialized: $_initialized\n'),
            new Text('Current Time: $_currentTime\n'),
          ],
        ),
      ),
    );
  }
}
