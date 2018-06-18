# TrueTime - NTP plugin for Flutter

[![pub package](https://img.shields.io/pub/v/true_time.svg)](https://pub.dartlang.org/packages/true_time)

Calculate the date and time "now" impervious to manual changes to device clock time.
                                     
In certain applications it becomes important to get the real or "true" date and time. On most devices, if the clock has been changed manually, then a new DateTime instance gives you a time impacted by local settings.
                                     
Users may do this for a variety of reasons, like being in different timezones, trying to be punctual by setting their clocks 5 – 10 minutes early, etc. Your application or service may want a date that is unaffected by these changes and reliable as a source of truth. TrueTime gives you that.

This plugin is based on [`truetime`][1] in Android and [`TrueTime`][2] in iOS for the whole SNTP protocol implementation.

## Installation

Just add `true_time` as a [dependency in your pubspec.yaml file](https://flutter.io/using-packages/).

### Android

Ensure the following permission is present in your Android Manifest file, located in `<project root>/android/app/src/main/AndroidManifest.xml:

```xml
<uses-permission android:name="android.permission.INTERNET"/>
```

The Flutter project template adds it, so it may already be there.

### iOS

Already good to go.

### Example

```dart
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
```

[1]: https://github.com/instacart/truetime-android
[2]: https://github.com/instacart/TrueTime.swift