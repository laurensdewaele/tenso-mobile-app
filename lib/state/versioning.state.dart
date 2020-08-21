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
  Version _persistedVersion;
  Version get persistedVersion => _persistedVersion;

  Future<void> init() async {
    _persistedVersion = await _persistenceService.getVersion();
    if (_persistedVersion != null &&
        _persistedVersion.incrementalNo != latestVersion.incrementalNo) {
      _displayChangelog = true;
    }
    _saveVersion(latestVersion);
    return Future.value();
  }

  void _saveVersion(Version version) {
    _persistenceService.saveVersion(version);
  }

  void setDisplayChangelogFalse() {
    _displayChangelog = false;
  }

  dispose() {}
}
