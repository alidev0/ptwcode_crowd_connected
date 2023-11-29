import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'ptwcode_crowd_connected_method_channel.dart';

abstract class PtwcodeCrowdConnectedPlatform extends PlatformInterface {
  /// Constructs a PtwcodeCrowdConnectedPlatform.
  PtwcodeCrowdConnectedPlatform() : super(token: _token);

  static final Object _token = Object();

  static PtwcodeCrowdConnectedPlatform _instance =
      MethodChannelPtwcodeCrowdConnected();

  /// The default instance of [PtwcodeCrowdConnectedPlatform] to use.
  ///
  /// Defaults to [MethodChannelPtwcodeCrowdConnected].
  static PtwcodeCrowdConnectedPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PtwcodeCrowdConnectedPlatform] when
  /// they register themselves.
  static set instance(PtwcodeCrowdConnectedPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<void> start({
    required String appKey,
    required String publicToken,
    required String secretToken,
  }) {
    throw UnimplementedError('start() has not been implemented.');
  }
}
