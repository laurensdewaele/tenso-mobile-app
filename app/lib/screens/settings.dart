import 'package:flutter/cupertino.dart' hide Icon;
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';

import 'package:provider/provider.dart';

import 'package:app/models/models.dart';
import 'package:app/routes/routes.dart';
import 'package:app/state/app_state.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/settings_vm.dart';
import 'package:app/widgets/card.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/icon.dart';
import 'package:app/widgets/icon_button.dart';
import 'package:app/widgets/keyboard_and_toast_provider.dart';
import 'package:app/widgets/keyboard_list_view.dart';
import 'package:app/widgets/number_input_and_description.dart';
import 'package:app/widgets/radio_button.dart';
import 'package:app/widgets/section.dart';
import 'package:app/widgets/screen.dart';
import 'package:app/widgets/top_navigation.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  void _onHorizontalDragEnd(DragEndDetails details) {
    if (details.primaryVelocity > 0) {
      Navigator.of(context).pop();
    }
  }

  void _handlePreparationTimerChanged(int value) {
    Provider.of<SettingsViewModel>(context, listen: false)
        .setPreparationTimer(value);
  }

  void _handleSoundNavigation() {
    Navigator.of(context).pushNamed(Routes.soundSettingsScreen);
  }

  void _handleWeightUnitChanged(dynamic weightUnit) {
    Provider.of<SettingsViewModel>(context, listen: false)
        .setWeightUnit(weightUnit);
  }

  void _handleTempUnitChanged(dynamic tempUnit) {
    Provider.of<SettingsViewModel>(context, listen: false)
        .setTempUnit(tempUnit);
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
                  title: 'settings',
                  dark: true,
                ),
                Divider(height: styles.Measurements.xxl),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: styles.Measurements.xs),
                  child: Card(
                    child: Consumer<SettingsViewModel>(
                      builder: (context, _settingsViewModel, child) {
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
                                          title: 'default board',
                                          children: <Widget>[],
                                        ),
                                        Section(
                                          title: 'preparation timer',
                                          children: <Widget>[
                                            NumberInputAndDescription(
                                              description: 'seconds',
                                              initialIntValue: _appState
                                                  .settings.preparationTimer,
                                              handleIntValueChanged:
                                                  _handlePreparationTimerChanged,
                                            )
                                          ],
                                        ),
                                      ],
                                    )),
                                _SoundSection(
                                    title: 'sound',
                                    handleNavigation: _handleSoundNavigation),
                                Divider(
                                  height: styles.Measurements.xxl,
                                ),
                                Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: styles.Measurements.m,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Section(
                                          title: 'weight unit',
                                          children: <Widget>[
                                            RadioButton(
                                              description: 'Metric (kg)',
                                              value: WeightUnit.metric,
                                              active: _appState
                                                      .settings.weightUnit ==
                                                  WeightUnit.metric,
                                              handleSelected:
                                                  _handleWeightUnitChanged,
                                            ),
                                            RadioButton(
                                              description: 'Imperial (pounds)',
                                              value: WeightUnit.imperial,
                                              active: _appState
                                                      .settings.weightUnit ==
                                                  WeightUnit.imperial,
                                              handleSelected:
                                                  _handleWeightUnitChanged,
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
                                          title: 'temperature unit',
                                          children: <Widget>[
                                            RadioButton(
                                              description: 'Celsius',
                                              value: TempUnit.celsius,
                                              active:
                                                  _appState.settings.tempUnit ==
                                                      TempUnit.celsius,
                                              handleSelected:
                                                  _handleTempUnitChanged,
                                            ),
                                            RadioButton(
                                              description: 'Fahrenheit',
                                              value: TempUnit.fahrenheit,
                                              active:
                                                  _appState.settings.tempUnit ==
                                                      TempUnit.fahrenheit,
                                              handleSelected:
                                                  _handleTempUnitChanged,
                                            ),
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
                Divider(height: styles.Measurements.xxl),
              ],
            )
          ]),
        ),
      ),
    );
  }
}

class _SoundSection extends StatelessWidget {
  _SoundSection(
      {Key key, @required this.title, @required this.handleNavigation})
      : super(key: key);

  final String title;
  final VoidCallback handleNavigation;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: styles.Measurements.m,
                ),
                child: Text(
                  title,
                  style: styles.Staatliches.xlBlack,
                )),
            IconButton(
                handleTap: () {},
                icon: Icon(
                    iconData: CupertinoIcons.forward,
                    size: styles.IconMeasurements.xl,
                    color: styles.Colors.black))
          ],
        ),
        GestureDetector(
            onTap: handleNavigation,
            child: Container(
              decoration: BoxDecoration(color: styles.Colors.translucent),
              width: double.infinity,
              height: 73,
            )),
      ],
    );
  }
}
