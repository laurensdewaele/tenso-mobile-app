import 'package:flutter/cupertino.dart' hide Icon;
import 'package:flutter/rendering.dart';

import 'package:provider/provider.dart';

import 'package:app/data/sounds.dart';
import 'package:app/models/models.dart';
import 'package:app/services/audio_player.dart';
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
  AudioPlayerService _audioPlayerService;

  @override
  void initState() {
    _audioPlayerService =
        Provider.of<AudioPlayerService>(context, listen: false);
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
      _audioPlayerService.play(sound.filename);
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
                        builder: (context, _viewModel, child) {
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
                                              description: 'beeps before hang',
                                              initialIntValue: _viewModel
                                                  .beepsBeforeHangInitial,
                                              handleIntValueChanged:
                                                  _viewModel.setBeepsBeforeHang,
                                            ),
                                            Divider(
                                              height: styles.Measurements.m,
                                            ),
                                            NumberInputAndDescription(
                                              description: 'beeps before rest',
                                              initialIntValue: _viewModel
                                                  .beepsBeforeRestInitial,
                                              handleIntValueChanged:
                                                  _viewModel.setBeepsBeforeRest,
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
                                            RadioButton<Sound>(
                                              description: Sounds.thudDeep.name,
                                              value: Sounds.thudDeep,
                                              active:
                                                  _viewModel.isThudDeepActive,
                                              handleSelected: (Sound s) {
                                                _viewModel.setHangSound(s);
                                                _playSound(s);
                                              },
                                            ),
                                            RadioButton<Sound>(
                                              description:
                                                  Sounds.thudHollow.name,
                                              value: Sounds.thudHollow,
                                              active:
                                                  _viewModel.isThudHollowActive,
                                              handleSelected: (Sound s) {
                                                _viewModel.setHangSound(s);
                                                _playSound(s);
                                              },
                                            ),
                                            RadioButton<Sound>(
                                              description: Sounds.thudSoft.name,
                                              value: Sounds.thudSoft,
                                              active:
                                                  _viewModel.isThudSoftActive,
                                              handleSelected: (Sound s) {
                                                _viewModel.setHangSound(s);
                                                _playSound(s);
                                              },
                                            ),
                                            RadioButton<Sound>(
                                              description: Sounds.off.name,
                                              value: Sounds.off,
                                              active: _viewModel
                                                  .isHangSoundOffActive,
                                              handleSelected: (Sound s) {
                                                _viewModel.setHangSound(s);
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
                                            RadioButton<Sound>(
                                              description:
                                                  Sounds.metalHitSmall.name,
                                              value: Sounds.metalHitSmall,
                                              active: _viewModel
                                                  .isMetalHitSmallActive,
                                              handleSelected: (Sound s) {
                                                _viewModel.setRestSound(s);
                                                _playSound(s);
                                              },
                                            ),
                                            RadioButton<Sound>(
                                              description:
                                                  Sounds.metalHitLarge.name,
                                              value: Sounds.metalHitLarge,
                                              active: _viewModel
                                                  .isMetalHitLargeActive,
                                              handleSelected: (Sound s) {
                                                _viewModel.setRestSound(s);
                                                _playSound(s);
                                              },
                                            ),
                                            RadioButton<Sound>(
                                              description: Sounds.gong.name,
                                              value: Sounds.gong,
                                              active: _viewModel.isGongActive,
                                              handleSelected: (Sound s) {
                                                _viewModel.setRestSound(s);
                                                _playSound(s);
                                              },
                                            ),
                                            RadioButton<Sound>(
                                              description: Sounds.off.name,
                                              value: Sounds.off,
                                              active: _viewModel
                                                  .isRestSoundOffActive,
                                              handleSelected: (Sound s) {
                                                _viewModel.setRestSound(s);
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
                                            RadioButton<Sound>(
                                              description:
                                                  Sounds.hitLightSoft.name,
                                              value: Sounds.hitLightSoft,
                                              active: _viewModel
                                                  .isHitLightSoftActive,
                                              handleSelected: (Sound s) {
                                                _viewModel.setBeepSound(s);
                                                _playSound(s);
                                              },
                                            ),
                                            RadioButton<Sound>(
                                              description:
                                                  Sounds.hitLightHard.name,
                                              value: Sounds.hitLightHard,
                                              active: _viewModel
                                                  .isHitLightHardActive,
                                              handleSelected: (Sound s) {
                                                _viewModel.setBeepSound(s);
                                                _playSound(s);
                                              },
                                            ),
                                            RadioButton<Sound>(
                                              description: Sounds.off.name,
                                              value: Sounds.off,
                                              active: _viewModel
                                                  .isBeepSoundOffActive,
                                              handleSelected: (Sound s) {
                                                _viewModel.setBeepSound(s);
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
