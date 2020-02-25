import 'package:app/models/sound.dart';

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

  static Sound thudHollow = Sound((b) => b
    ..name = 'Wooden thud holllow'
    ..filename = 'thud_deep_hollow.mp3'
    ..muted = false);

  static Sound thudSoft = Sound((b) => b
    ..name = 'Wooden thud soft'
    ..filename = 'thud_soft.mp3'
    ..muted = false);
}
