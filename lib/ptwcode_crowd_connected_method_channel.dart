import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'ptwcode_crowd_connected_platform_interface.dart';

/// An implementation of [PtwcodeCrowdConnectedPlatform] that uses method channels.
class MethodChannelPtwcodeCrowdConnected extends PtwcodeCrowdConnectedPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('ptwcode_crowd_connected');

  @override
  Future<String?> getPlatformVersion() async {
    final res = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return res;
  }

  @override
  Future<void> start({
    required String appKey,
    required String publicToken,
    required String secretToken,
  }) async {
    final params = {
      "app_key": appKey,
      "public_token": publicToken,
      "secret_token": secretToken,
    };

    await methodChannel.invokeMethod<String>('start', params);
  }
}
