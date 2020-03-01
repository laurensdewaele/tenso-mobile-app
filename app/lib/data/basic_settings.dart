import 'package:app/data/boards/beastmaker_1000.dart';
import 'package:app/data/sounds.dart';
import 'package:app/models/settings.dart';
import 'package:app/models/unit.dart';

final Settings basicSettings = Settings((b) => b
  ..defaultBoard = beastmaker1000.toBuilder()
  ..preparationTimer = 20
  ..unit = Unit.metric
  ..hangSound = Sounds.thudDeep.toBuilder()
  ..repRestSound = Sounds.metalHitSmall.toBuilder()
  ..gripRestSound = Sounds.metalHitLarge.toBuilder()
  ..setRestSound = Sounds.gong.toBuilder()
  ..beepDuringHangSound = Sounds.hitLightHard.toBuilder()
  ..beepDuringRestSound = Sounds.hitLightSoft.toBuilder()
  ..beepsBeforeHang = 5
  ..beepsBeforeRest = 3);
