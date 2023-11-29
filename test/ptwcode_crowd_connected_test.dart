import 'package:flutter_test/flutter_test.dart';
import 'package:ptwcode_crowd_connected/ptwcode_crowd_connected.dart';
import 'package:ptwcode_crowd_connected/ptwcode_crowd_connected_platform_interface.dart';
import 'package:ptwcode_crowd_connected/ptwcode_crowd_connected_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockPtwcodeCrowdConnectedPlatform
    with MockPlatformInterfaceMixin
    implements PtwcodeCrowdConnectedPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final PtwcodeCrowdConnectedPlatform initialPlatform = PtwcodeCrowdConnectedPlatform.instance;

  test('$MethodChannelPtwcodeCrowdConnected is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelPtwcodeCrowdConnected>());
  });

  test('getPlatformVersion', () async {
    PtwcodeCrowdConnected ptwcodeCrowdConnectedPlugin = PtwcodeCrowdConnected();
    MockPtwcodeCrowdConnectedPlatform fakePlatform = MockPtwcodeCrowdConnectedPlatform();
    PtwcodeCrowdConnectedPlatform.instance = fakePlatform;

    expect(await ptwcodeCrowdConnectedPlugin.getPlatformVersion(), '42');
  });
}
