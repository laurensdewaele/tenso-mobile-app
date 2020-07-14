import 'package:tenso_app/models/models.dart';

abstract class Sounds {
  static Sound off = Sound((b) => b
    ..name = 'Off'
    ..filename = ''
    ..muted = true);

  static Sound gong = Sound((b) => b
    ..name = 'Tibetan gong'
    ..filename = 'gong.mp3'
    ..muted = false);

  static Sound hitLightSoft = Sound((b) => b
    ..name = 'Wood hit soft'
    ..filename = 'hit_light_soft.mp3'
    ..muted = false);

  static Sound hitLightHard = Sound((b) => b
    ..name = 'Wood hit hard'
    ..filename = 'hit_light_hard.mp3'
    ..muted = false);

  static Sound thudDeep = Sound((b) => b
    ..name = 'Wooden thud deep'
    ..filename = 'thud_deep.mp3'
    ..muted = false);

  static Sound femaleHang = Sound((b) => b
    ..name = 'Female hang'
    ..filename = 'hang.m4a'
    ..muted = false);

  static Sound femaleRelax = Sound((b) => b
    ..name = 'Female relax'
    ..filename = 'relax.m4a'
    ..muted = false);

  static Sound femaleRelaxSensual = Sound((b) => b
    ..name = 'Female relax, relaxed'
    ..filename = 'relax_sensual.m4a'
    ..muted = false);
}
