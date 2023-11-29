import 'ptwcode_crowd_connected_platform_interface.dart';

class PtwcodeCrowdConnected {
  Future<String?> getPlatformVersion() {
    return PtwcodeCrowdConnectedPlatform.instance.getPlatformVersion();
  }

  Future<void> start({
    required String appKey,
    required String publicToken,
    required String secretToken,
  }) {
    return PtwcodeCrowdConnectedPlatform.instance.start(
      appKey: appKey,
      publicToken: publicToken,
      secretToken: secretToken,
    );
  }
}
