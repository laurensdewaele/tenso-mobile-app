import 'dart:async';

import 'package:flutter/cupertino.dart' hide Icon;
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';

import 'package:provider/provider.dart';

import 'package:app/models/unit.dart';
import 'package:app/routes/routes.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/settings.dart';
import 'package:app/widgets/card.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/icon.dart';
import 'package:app/widgets/icon_button.dart';
import 'package:app/widgets/number_input_and_description.dart';
import 'package:app/widgets/keyboard_screen.dart';
import 'package:app/widgets/radio_button.dart';
import 'package:app/widgets/section.dart';
import 'package:app/widgets/toast.dart';
import 'package:app/widgets/top_navigation.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final StreamController<bool> _shouldLoseFocusStreamController =
      StreamController<bool>.broadcast();
  final StreamController<Widget> _errorMessageStreamController =
      StreamController<Widget>();
  final ScrollController _scrollController = ScrollController();

  double _keyboardOffsetHeight = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _shouldLoseFocusStreamController.close();
    _errorMessageStreamController.close();
    super.dispose();
  }

  void _onScreenTap() {
    _shouldLoseFocusStreamController.sink.add(true);
    setState(() {
      _keyboardOffsetHeight = 0;
    });
  }

  void _handleErrorMessage(Widget message) {
    _errorMessageStreamController.sink.add(message);
  }

  void _handleKeyboardOffset(Offset offset) {
    setState(() {
      _keyboardOffsetHeight = offset.dy;
    });

    if (offset.dy == 0) return;

    final double originalScrollDifference =
        _scrollController.position.maxScrollExtent - _scrollController.offset;

    SchedulerBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent - originalScrollDifference,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    });
  }

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

  void _handleUnitChanged(dynamic unit) {
    Provider.of<SettingsViewModel>(context, listen: false).setUnit(unit);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: _onScreenTap,
          child: KeyBoardScreen(
              handleKeyboardOffset: _handleKeyboardOffset,
              gradientStartColor: styles.Colors.bgGrayStart,
              gradientStopColor: styles.Colors.bgGrayStop,
              child: ListView(
                  controller: _scrollController,
                  physics: ClampingScrollPhysics(),
                  children: [
                    Column(
                      children: <Widget>[
                        TopNavigation(
                          title: 'settings',
                          dark: true,
                        ),
                        Divider(height: styles.Measurements.xxl),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: styles.Measurements.xs),
                          child: GestureDetector(
                            onHorizontalDragEnd: _onHorizontalDragEnd,
                            child: Card(
                              child: Consumer<SettingsViewModel>(
                                builder: (context, settingsViewModel, child) {
                                  return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                      isDouble: false,
                                                      description: 'seconds',
                                                      initialValue:
                                                          settingsViewModel
                                                              .preparationTimer
                                                              .toDouble(),
                                                      handleIntValueChanged:
                                                          _handlePreparationTimerChanged,
                                                      shouldLoseFocusStream:
                                                          _shouldLoseFocusStreamController
                                                              .stream,
                                                      handleErrorMessage:
                                                          _handleErrorMessage,
                                                      shouldFocus: false,
                                                    )
                                                  ],
                                                ),
                                              ],
                                            )),
                                        _SoundSection(
                                            title: 'sound',
                                            handleNavigation:
                                                _handleSoundNavigation),
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
                                                  title: 'units',
                                                  children: <Widget>[
                                                    RadioButton(
                                                      description:
                                                          'Metric (kg)',
                                                      value: Unit.metric,
                                                      active:
                                                          settingsViewModel.unit ==
                                                              Unit.metric,
                                                      handleSelected:
                                                          _handleUnitChanged,
                                                    ),
                                                    RadioButton(
                                                      description:
                                                          'Imperial (pounds)',
                                                      value: Unit.imperial,
                                                      active:
                                                          settingsViewModel.unit ==
                                                              Unit.imperial,
                                                      handleSelected:
                                                          _handleUnitChanged,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )),
                                        SizedBox(
                                          height: _keyboardOffsetHeight,
                                        )
                                      ]);
                                },
                              ),
                            ),
                          ),
                        ),
                        Divider(height: styles.Measurements.xxl)
                      ],
                    )
                  ])),
        ),
        Toast(messageStream: _errorMessageStreamController.stream),
      ],
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
                  style: styles.Typography.title,
                )),
            IconButton(
                handleTap: () {},
                icon: Icon(
                    iconData: CupertinoIcons.forward,
                    size: styles.Measurements.l,
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
