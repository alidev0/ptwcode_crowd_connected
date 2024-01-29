import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ptwcode_crowd_connected/ptwcode_crowd_connected.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _ptwcodeCrowdConnectedPlugin = PtwcodeCrowdConnected();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await _ptwcodeCrowdConnectedPlugin.getPlatformVersion() ??
              'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  void _onTapPermission() async {
    final locationWhenInUse = await Permission.locationWhenInUse.request();
    debugPrint('====> Permission.locationWhenInUse: $locationWhenInUse');

    if (Platform.isAndroid) {
      final bluetoothScan = await Permission.bluetoothScan.request();
      debugPrint('====> Permission.bluetoothScan: $bluetoothScan');
    }

    if (Platform.isIOS) {
      final bluetooth = await Permission.bluetooth.request();
      debugPrint('====> Permission.bluetooth: $bluetooth');
    }
  }

  void _startService() async {
    await _ptwcodeCrowdConnectedPlugin.start(
      // TODO add appKey here
      appKey: '',
      // TODO add publicToken here
      publicToken: '',
      // TODO add secretToken here
      secretToken: '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            const Row(children: []),
            Text('Running on: $_platformVersion\n'),
            TextButton(
              onPressed: _onTapPermission,
              child: const Text('Request Permissions'),
            ),
            TextButton(
              onPressed: _startService,
              child: const Text('Start Service'),
            ),
          ],
        ),
      ),
    );
  }
}
