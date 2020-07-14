import 'package:flutter/cupertino.dart' hide Icon;
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/routes/routes.dart';
import 'package:tenso_app/styles/styles.dart' as styles;
import 'package:tenso_app/view_models/settings.vm.dart';
import 'package:tenso_app/widgets/card.dart';
import 'package:tenso_app/widgets/divider.dart';
import 'package:tenso_app/widgets/icon_button.dart';
import 'package:tenso_app/widgets/icons.dart' as icons;
import 'package:tenso_app/widgets/keyboard_and_toast_provider.dart';
import 'package:tenso_app/widgets/keyboard_list_view.dart';
import 'package:tenso_app/widgets/number_input_and_description.dart';
import 'package:tenso_app/widgets/radio_button.dart';
import 'package:tenso_app/widgets/screen.dart';
import 'package:tenso_app/widgets/section.dart';
import 'package:tenso_app/widgets/top_navigation.dart';

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

  void _handleBackNavigation() async {
    final bool _canNavigate = await _viewModel.canNavigate();
    if (_canNavigate == true) {
      Navigator.of(context).pushNamed(Routes.workoutOverviewScreen);
    }
  }

  void _handleSoundNavigation() async {
    final bool _canNavigate = await _viewModel.canNavigate();
    if (_canNavigate == true) {
      Navigator.of(context).pushNamed(Routes.soundSettingsScreen);
    }
  }

  void _handleBoardNavigation() async {
    final bool _canNavigate = await _viewModel.canNavigate();
    if (_canNavigate == true) {
      Navigator.of(context).pushNamed(Routes.boardSettingsScreen);
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
                  title: 'settings',
                  dark: true,
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
                          _InfoSection(
                              title: 'boards',
                              handleNavigation: _handleBoardNavigation),
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
                          _InfoSection(
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

class _InfoSection extends StatelessWidget {
  _InfoSection({Key key, @required this.title, @required this.handleNavigation})
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
            IconButton(handleTap: () {}, icon: icons.forwardIconBlackXl)
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
