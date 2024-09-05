import 'package:package_info_plus/package_info_plus.dart';

class DeviceInfoService {
  static final DeviceInfoService _instance = DeviceInfoService._internal();

  late final String _appName;
  late final String _packageName;
  late final String _version;
  late final String _buildNumber;

  DeviceInfoService._internal();

  factory DeviceInfoService() {
    return _instance;
  }

  static Future<void> init() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _instance._appName = packageInfo.appName;
    _instance._packageName = packageInfo.packageName;
    _instance._version = packageInfo.version;
    _instance._buildNumber = packageInfo.buildNumber;
  }

  static String get appName => _instance._appName;
  static String get packageName => _instance._packageName;
  static String get version => _instance._version;
  static String get buildNumber => _instance._buildNumber;
}
