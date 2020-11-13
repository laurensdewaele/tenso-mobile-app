import 'package:flutter/cupertino.dart' hide Icon;
import 'package:flutter/rendering.dart';
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/modules/common/card.dart';
import 'package:tenso_app/modules/common/divider.dart';
import 'package:tenso_app/modules/common/radio_button.dart';
import 'package:tenso_app/modules/common/screen.dart';
import 'package:tenso_app/modules/common/section.dart';
import 'package:tenso_app/modules/common/section_forward_nav.dart';
import 'package:tenso_app/modules/common/top_navigation.dart';
import 'package:tenso_app/modules/keyboard_input/keyboard_and_toast_provider.dart';
import 'package:tenso_app/modules/keyboard_input/keyboard_list_view.dart';
import 'package:tenso_app/modules/keyboard_input/number_input_and_description.dart';
import 'package:tenso_app/modules/settings/settings.vm.dart';
import 'package:tenso_app/styles/styles.dart' as styles;

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  SettingsViewModel _viewModel;

  @override
  void initState() {
    _viewModel = SettingsViewModel();
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _viewModel.handleBackNavigation();
        return false;
      },
      child: KeyboardAndToastProvider(
        child: Screen(
          handleBackNavigation: _viewModel.handleBackNavigation,
          child: KeyboardListView(children: [
            Column(
              children: <Widget>[
                TopNavigation(
                  handleBackNavigation: _viewModel.handleBackNavigation,
                  title: 'settings',
                ),
                Divider(height: styles.Measurements.xxl),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: styles.Measurements.xs),
                  child: Card(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Divider(
                            height: styles.Measurements.xs,
                          ),
                          SectionForwardNav(
                              padding: EdgeInsets.symmetric(
                                horizontal: styles.Measurements.m,
                              ),
                              title: 'boards',
                              handleNavigation:
                                  _viewModel.handleBoardNavigation),
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
                                    title: 'preparation timer',
                                    children: <Widget>[
                                      NumberInputAndDescription<int>(
                                        description: 'seconds',
                                        initialValue:
                                            _viewModel.preparationTimerInitial,
                                        handleValueChanged: _viewModel
                                            .handlePreparationTimerInput,
                                      )
                                    ],
                                  ),
                                ],
                              )),
                          SectionForwardNav(
                              padding: EdgeInsets.symmetric(
                                horizontal: styles.Measurements.m,
                              ),
                              title: 'sound',
                              handleNavigation:
                                  _viewModel.handleSoundNavigation),
                          Divider(
                            height: styles.Measurements.xxl,
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: styles.Measurements.m,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Section(
                                    title: 'weight unit',
                                    children: <Widget>[
                                      RadioButton<WeightSystem>(
                                        description: 'Metric (kg)',
                                        value: WeightSystem.metric,
                                        active: _viewModel.isMetricActive,
                                        handleSelected:
                                            _viewModel.setWeightSystem,
                                      ),
                                      RadioButton<WeightSystem>(
                                        description: 'Imperial (pounds)',
                                        value: WeightSystem.imperial,
                                        active: _viewModel.isImperialActive,
                                        handleSelected:
                                            _viewModel.setWeightSystem,
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
                                    title: 'temperature unit',
                                    children: <Widget>[
                                      RadioButton<TempUnit>(
                                        description: 'Celsius',
                                        value: TempUnit.celsius,
                                        active: _viewModel.isCelsiusActive,
                                        handleSelected: _viewModel.setTempUnit,
                                      ),
                                      RadioButton<TempUnit>(
                                        description: 'Fahrenheit',
                                        value: TempUnit.fahrenheit,
                                        active: _viewModel.isFahrenheitActive,
                                        handleSelected: _viewModel.setTempUnit,
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                        ]),
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
