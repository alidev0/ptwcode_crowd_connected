import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ptwcode_crowd_connected/ptwcode_crowd_connected_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelPtwcodeCrowdConnected platform = MethodChannelPtwcodeCrowdConnected();
  const MethodChannel channel = MethodChannel('ptwcode_crowd_connected');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
