import 'package:flutter/cupertino.dart' hide Icon;
import 'package:flutter/rendering.dart';

import 'package:audioplayers/audio_cache.dart';
import 'package:provider/provider.dart';

import 'package:app/data/sounds.dart';
import 'package:app/models/sound.dart';
import 'package:app/state/app_state.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/sound_settings_vm.dart';
import 'package:app/widgets/card.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/keyboard_and_toast_provider.dart';
import 'package:app/widgets/keyboard_list_view.dart';
import 'package:app/widgets/number_input_and_description.dart';
import 'package:app/widgets/radio_button.dart';
import 'package:app/widgets/screen.dart';
import 'package:app/widgets/section.dart';
import 'package:app/widgets/top_navigation.dart';

class SoundSettingsScreen extends StatefulWidget {
  SoundSettingsScreen({Key key}) : super(key: key);

  @override
  _SoundSettingsScreenState createState() => _SoundSettingsScreenState();
}

class _SoundSettingsScreenState extends State<SoundSettingsScreen> {
  AudioCache _audioPlayer = AudioCache(prefix: 'audio/');

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    if (details.primaryVelocity > 0) {
      Navigator.of(context).pop();
    }
  }

  void _playSound(Sound sound) {
    if (sound.muted != true) {
      _audioPlayer.play(sound.filename);
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardAndToastProvider(
      child: GestureDetector(
        onHorizontalDragEnd: _onHorizontalDragEnd,
        child: Screen(
            gradientStartColor: styles.Colors.bgGrayStart,
            gradientStopColor: styles.Colors.bgGrayStop,
            child: KeyboardListView(children: [
              Column(
                children: <Widget>[
                  TopNavigation(
                    title: 'sound settings',
                    dark: true,
                  ),
                  Divider(height: styles.Measurements.xxl),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: styles.Measurements.xs),
                    child: Card(
                      child: Consumer<SoundSettingsViewModel>(
                        builder:
                            (context, _soundSettingsScreenViewModel, child) {
                          return Consumer<AppState>(
                              builder: (context, _appState, child) {
                            return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: styles.Measurements.m,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Divider(
                                            height: styles.Measurements.l,
                                          ),
                                          Section(
                                            title: 'indicator beeps',
                                            children: <Widget>[
                                              NumberInputAndDescription(
                                                description:
                                                    'beeps before hang',
                                                initialIntValue: _appState
                                                    .settings.beepsBeforeHang,
                                                handleIntValueChanged: (int
                                                        v) =>
                                                    _soundSettingsScreenViewModel
                                                        .setBeepsBeforeHang(v),
                                              ),
                                              Divider(
                                                height: styles.Measurements.m,
                                              ),
                                              NumberInputAndDescription(
                                                description:
                                                    'beeps before rest',
                                                initialIntValue: _appState
                                                    .settings.beepsBeforeRest,
                                                handleIntValueChanged: (int
                                                        v) =>
                                                    _soundSettingsScreenViewModel
                                                        .setBeepsBeforeRest(v),
                                              ),
                                              Divider(
                                                height: styles.Measurements.m,
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: styles.Measurements.m,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Section(
                                            title: 'hang sound',
                                            children: <Widget>[
                                              RadioButton(
                                                description:
                                                    Sounds.thudDeep.name,
                                                value: Sounds.thudDeep,
                                                active: _appState
                                                        .settings.hangSound ==
                                                    Sounds.thudDeep,
                                                handleSelected: (dynamic s) {
                                                  _soundSettingsScreenViewModel
                                                      .setHangSound(s);
                                                  _playSound(s);
                                                },
                                              ),
                                              RadioButton(
                                                description:
                                                    Sounds.thudHollow.name,
                                                value: Sounds.thudHollow,
                                                active: _appState
                                                        .settings.hangSound ==
                                                    Sounds.thudHollow,
                                                handleSelected: (dynamic s) {
                                                  _soundSettingsScreenViewModel
                                                      .setHangSound(s);
                                                  _playSound(s);
                                                },
                                              ),
                                              RadioButton(
                                                description:
                                                    Sounds.thudSoft.name,
                                                value: Sounds.thudSoft,
                                                active: _appState
                                                        .settings.hangSound ==
                                                    Sounds.thudSoft,
                                                handleSelected: (dynamic s) {
                                                  _soundSettingsScreenViewModel
                                                      .setHangSound(s);
                                                  _playSound(s);
                                                },
                                              ),
                                              RadioButton(
                                                description: Sounds.off.name,
                                                value: Sounds.off,
                                                active: _appState
                                                        .settings.hangSound ==
                                                    Sounds.off,
                                                handleSelected: (dynamic s) {
                                                  _soundSettingsScreenViewModel
                                                      .setHangSound(s);
                                                  _playSound(s);
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: styles.Measurements.m,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Section(
                                            title: 'rest sound',
                                            children: <Widget>[
                                              RadioButton(
                                                description:
                                                    Sounds.metalHitSmall.name,
                                                value: Sounds.metalHitSmall,
                                                active: _appState
                                                        .settings.restSound ==
                                                    Sounds.metalHitSmall,
                                                handleSelected: (dynamic s) {
                                                  _soundSettingsScreenViewModel
                                                      .setRestSound(s);
                                                  _playSound(s);
                                                },
                                              ),
                                              RadioButton(
                                                description:
                                                    Sounds.metalHitLarge.name,
                                                value: Sounds.metalHitLarge,
                                                active: _appState
                                                        .settings.restSound ==
                                                    Sounds.metalHitLarge,
                                                handleSelected: (dynamic s) {
                                                  _soundSettingsScreenViewModel
                                                      .setRestSound(s);
                                                  _playSound(s);
                                                },
                                              ),
                                              RadioButton(
                                                description: Sounds.gong.name,
                                                value: Sounds.gong,
                                                active: _appState
                                                        .settings.restSound ==
                                                    Sounds.gong,
                                                handleSelected: (dynamic s) {
                                                  _soundSettingsScreenViewModel
                                                      .setRestSound(s);
                                                  _playSound(s);
                                                },
                                              ),
                                              RadioButton(
                                                description: Sounds.off.name,
                                                value: Sounds.off,
                                                active: _appState
                                                        .settings.restSound ==
                                                    Sounds.off,
                                                handleSelected: (dynamic s) {
                                                  _soundSettingsScreenViewModel
                                                      .setRestSound(s);
                                                  _playSound(s);
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: styles.Measurements.m,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Section(
                                            title: 'beep sound',
                                            children: <Widget>[
                                              RadioButton(
                                                description:
                                                    Sounds.hitLightSoft.name,
                                                value: Sounds.hitLightSoft,
                                                active: _appState
                                                        .settings.beepSound ==
                                                    Sounds.hitLightSoft,
                                                handleSelected: (dynamic s) {
                                                  _soundSettingsScreenViewModel
                                                      .setBeepSound(s);
                                                  _playSound(s);
                                                },
                                              ),
                                              RadioButton(
                                                description:
                                                    Sounds.hitLightHard.name,
                                                value: Sounds.hitLightHard,
                                                active: _appState
                                                        .settings.beepSound ==
                                                    Sounds.hitLightHard,
                                                handleSelected: (dynamic s) {
                                                  _soundSettingsScreenViewModel
                                                      .setBeepSound(s);
                                                  _playSound(s);
                                                },
                                              ),
                                              RadioButton(
                                                description: Sounds.off.name,
                                                value: Sounds.off,
                                                active: _appState
                                                        .settings.beepSound ==
                                                    Sounds.off,
                                                handleSelected: (dynamic s) {
                                                  _soundSettingsScreenViewModel
                                                      .setBeepSound(s);
                                                  _playSound(s);
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: styles.Measurements.m,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Section(
                                            title: 'accreditation',
                                            children: <Widget>[
                                              Text(
                                                'Sounds obtained from zapsplat.com',
                                                style: styles.Lato.xsGray,
                                              )
                                            ],
                                          ),
                                        ],
                                      )),
                                ]);
                          });
                        },
                      ),
                    ),
                  ),
                  Divider(
                    height: styles.Measurements.xxl,
                  )
                ],
              )
            ])),
      ),
    );
  }
}
