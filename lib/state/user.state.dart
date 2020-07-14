import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/services/persistence.service.dart';

final DeviceInfo _initialDeviceInfo = DeviceInfo((b) => b..firstLaunch = true);

class UserState {
  UserState._();
  static final UserState _userState = UserState._();
  factory UserState() => _userState;

  PersistenceService _persistenceService = PersistenceService();
  DeviceInfo _deviceInfo;
  DeviceInfo get deviceInfo => _deviceInfo;

  Future<void> init() async {
    _deviceInfo =
        await _persistenceService.getDeviceInfo() ?? _initialDeviceInfo;
    if (_deviceInfo.firstLaunch == true) {
      _setFirstLaunch(false);
    }
  }

  void _setFirstLaunch(bool isFirstLaunch) {
    _saveDeviceInfo(_deviceInfo.rebuild((b) => b..firstLaunch = false));
  }

  void _saveDeviceInfo(DeviceInfo info) {
    _persistenceService.saveDeviceInfo(info);
  }
}
