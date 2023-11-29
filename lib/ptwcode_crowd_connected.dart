
import 'ptwcode_crowd_connected_platform_interface.dart';

class PtwcodeCrowdConnected {
  Future<String?> getPlatformVersion() {
    return PtwcodeCrowdConnectedPlatform.instance.getPlatformVersion();
  }
}
