import 'package:tenso_app/data/boards/beastmaker_1000.data.dart';
import 'package:tenso_app/data/sounds.data.dart';
import 'package:tenso_app/models/models.dart';

final Settings basicSettings = Settings((b) => b
  ..defaultBoard = beastmaker1000.toBuilder()
  ..preparationTimer = 20
  ..weightSystem = WeightSystem.metric
  ..tempUnit = TempUnit.celsius
  ..hangSound = Sounds.thudDeep.toBuilder()
  ..restSound = Sounds.gong.toBuilder()
  ..beepSound = Sounds.hitLightHard.toBuilder()
  ..beepsBeforeHang = 5
  ..beepsBeforeRest = 3);
