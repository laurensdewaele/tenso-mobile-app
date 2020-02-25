import 'package:app/data/boards/beastmaker_1000.dart';
import 'package:app/data/sounds.dart';
import 'package:app/models/settings.dart';
import 'package:app/models/unit.dart';

final Settings basicSettings = Settings((b) => b
  ..defaultBoard = beastmaker1000.toBuilder()
  ..preparationTimer = 20
  ..unit = Unit.metric)
  ..hangSound = Sounds.thudDeep
  ..restSound = Sounds.gong
  ..beepSound = Sounds.hitLightSoft
  ..beepsBeforeHang = 5
  ..beepsBeforeRest = 3;
