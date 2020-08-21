import 'package:tenso_app/data/versioning.data.dart';
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/services/persistence.service.dart';

class VersioningState {
  VersioningState._();
  static final VersioningState _versioningState = VersioningState._();
  factory VersioningState() => _versioningState;

  PersistenceService _persistenceService = PersistenceService();

  bool _displayChangelog = false;
  bool get displayChangelog => _displayChangelog;
  Versioning _persistedVersioning;
  Versioning get persistedVersioning => _persistedVersioning;

  Future<void> init() async {
    _persistedVersioning = await _getVersioning();
    if (_persistedVersioning != null &&
        _persistedVersioning.versions[0].no !=
            latestVersioning.versions[0].no) {
      _displayChangelog = true;
    }
    _saveVersioning(latestVersioning);
    return Future.value();
  }

  Future<Versioning> _getVersioning() async {
    final Versioning _versioning = await _persistenceService.getVersioning();
    return _versioning;
  }

  void _saveVersioning(Versioning _versioning) {
    _persistenceService.saveVersioning(_versioning);
  }

  void setDisplayChangelogFalse() {
    _displayChangelog = false;
  }

  dispose() {}
}
