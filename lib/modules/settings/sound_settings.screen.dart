import 'package:flutter/cupertino.dart' hide Icon;
import 'package:flutter/rendering.dart';
import 'package:tenso_app/data/sounds.data.dart';
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/modules/common/card.dart';
import 'package:tenso_app/modules/common/divider.dart';
import 'package:tenso_app/modules/common/radio_button.dart';
import 'package:tenso_app/modules/common/screen.dart';
import 'package:tenso_app/modules/common/section.dart';
import 'package:tenso_app/modules/common/top_navigation.dart';
import 'package:tenso_app/modules/keyboard_input/keyboard_and_toast_provider.dart';
import 'package:tenso_app/modules/keyboard_input/keyboard_list_view.dart';
import 'package:tenso_app/modules/keyboard_input/number_input_and_description.dart';
import 'package:tenso_app/modules/settings/sound_settings.vm.dart';
import 'package:tenso_app/styles/styles.dart' as styles;

class SoundSettingsScreen extends StatefulWidget {
  SoundSettingsScreen({Key key}) : super(key: key);

  @override
  _SoundSettingsScreenState createState() => _SoundSettingsScreenState();
}

class _SoundSettingsScreenState extends State<SoundSettingsScreen> {
  SoundSettingsViewModel _viewModel;

  @override
  void initState() {
    _viewModel = SoundSettingsViewModel();
    _viewModel.addListener(_viewModelListener);
    super.initState();
  }

  void _viewModelListener() {
    setState(() {});
  }

  @override
  void dispose() {
    _viewModel.removeListener(_viewModelListener);
    super.dispose();
  }

  void _handleBackNavigation() async {
    final bool _canNavigate = await _viewModel.canNavigate();
    if (_canNavigate == true) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await _viewModel.canNavigate();
      },
      child: KeyboardAndToastProvider(
        child: Screen(
            handleBackNavigation: _handleBackNavigation,
            child: KeyboardListView(children: [
              Column(
                children: <Widget>[
                  TopNavigation(
                    handleBackNavigation: _handleBackNavigation,
                    title: 'sound settings',
                  ),
                  Divider(height: styles.Measurements.xxl),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: styles.Measurements.xs),
                    child: Card(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: styles.Measurements.m,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Divider(
                                      height: styles.Measurements.l,
                                    ),
                                    Section(
                                      title: 'indicator beeps',
                                      children: <Widget>[
                                        NumberInputAndDescription<int>(
                                          description: 'beeps before hang',
                                          initialValue:
                                              _viewModel.beepsBeforeHangInitial,
                                          handleValueChanged: _viewModel
                                              .handleBeepsBeforeHangInput,
                                        ),
                                        Divider(
                                          height: styles.Measurements.m,
                                        ),
                                        NumberInputAndDescription<int>(
                                          description: 'beeps before rest',
                                          initialValue:
                                              _viewModel.beepsBeforeRestInitial,
                                          handleValueChanged: _viewModel
                                              .handleBeepsBeforeRestInput,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Section(
                                      title: 'hang sound',
                                      children: <Widget>[
                                        RadioButton<Sound>(
                                          description: Sounds.thudDeep.name,
                                          value: Sounds.thudDeep,
                                          active: _viewModel.isThudDeepActive,
                                          handleSelected:
                                              _viewModel.setAndPlayHangSound,
                                        ),
                                        RadioButton<Sound>(
                                          description: Sounds.femaleHang.name,
                                          value: Sounds.femaleHang,
                                          active: _viewModel.isWomanHangActive,
                                          handleSelected:
                                              _viewModel.setAndPlayHangSound,
                                        ),
                                        RadioButton<Sound>(
                                          description: Sounds.off.name,
                                          value: Sounds.off,
                                          active:
                                              _viewModel.isHangSoundOffActive,
                                          handleSelected:
                                              _viewModel.setAndPlayHangSound,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Section(
                                      title: 'rest sound',
                                      children: <Widget>[
                                        RadioButton<Sound>(
                                          description: Sounds.gong.name,
                                          value: Sounds.gong,
                                          active: _viewModel.isGongActive,
                                          handleSelected:
                                              _viewModel.setAndPlayRestSound,
                                        ),
                                        RadioButton<Sound>(
                                          description: Sounds.femaleRelax.name,
                                          value: Sounds.femaleRelax,
                                          active: _viewModel.isWomanRelaxActive,
                                          handleSelected:
                                              _viewModel.setAndPlayRestSound,
                                        ),
                                        RadioButton<Sound>(
                                          description:
                                              Sounds.femaleRelaxSensual.name,
                                          value: Sounds.femaleRelaxSensual,
                                          active: _viewModel
                                              .isWomanRelaxSensualActive,
                                          handleSelected:
                                              _viewModel.setAndPlayRestSound,
                                        ),
                                        RadioButton<Sound>(
                                          description: Sounds.off.name,
                                          value: Sounds.off,
                                          active:
                                              _viewModel.isRestSoundOffActive,
                                          handleSelected:
                                              _viewModel.setAndPlayRestSound,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Section(
                                      title: 'beep sound',
                                      children: <Widget>[
                                        RadioButton<Sound>(
                                          description: Sounds.hitLightSoft.name,
                                          value: Sounds.hitLightSoft,
                                          active:
                                              _viewModel.isHitLightSoftActive,
                                          handleSelected:
                                              _viewModel.setAndPlayBeepSound,
                                        ),
                                        RadioButton<Sound>(
                                          description: Sounds.hitLightHard.name,
                                          value: Sounds.hitLightHard,
                                          active:
                                              _viewModel.isHitLightHardActive,
                                          handleSelected:
                                              _viewModel.setAndPlayBeepSound,
                                        ),
                                        RadioButton<Sound>(
                                          description: Sounds.off.name,
                                          value: Sounds.off,
                                          active:
                                              _viewModel.isBeepSoundOffActive,
                                          handleSelected:
                                              _viewModel.setAndPlayBeepSound,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Section(
                                      title: 'accreditation',
                                      children: <Widget>[
                                        Text(
                                          'Female voice by Ann-Sofie, others obtained from zapsplat.com',
                                          style: styles.Lato.xsGray,
                                        )
                                      ],
                                    ),
                                  ],
                                )),
                          ]),
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
