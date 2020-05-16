import 'package:app/data/sounds.data.dart';
import 'package:app/models/models.dart';
import 'package:app/state/boards.state.dart';

final Settings basicSettings = Settings((b) => b
  ..defaultBoard = BoardsState().defaultBoard.toBuilder()
  ..preparationTimer = 20
  ..weightUnit = WeightUnit.metric
  ..tempUnit = TempUnit.celsius
  ..hangSound = Sounds.thudDeep.toBuilder()
  ..restSound = Sounds.gong.toBuilder()
  ..beepSound = Sounds.hitLightHard.toBuilder()
  ..beepsBeforeHang = 5
  ..beepsBeforeRest = 3);
