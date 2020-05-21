import 'dart:async';

import 'package:app/models/models.dart';
import 'package:app/routes/routes.dart';
import 'package:app/screens/congratulations.screen.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/rate_workout.vm.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/card.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/keyboard_and_toast_provider.dart';
import 'package:app/widgets/keyboard_list_view.dart';
import 'package:app/widgets/rate_workout/rate_workout_content.dart';
import 'package:flutter/cupertino.dart' hide Icon;
import 'package:flutter/scheduler.dart';

class RateWorkoutScreen extends StatefulWidget {
  RateWorkoutScreen({Key key}) : super(key: key);

  @override
  _RateWorkoutScreenState createState() => _RateWorkoutScreenState();
}

class _RateWorkoutScreenState extends State<RateWorkoutScreen> {
  final StreamController<bool> _scrollToBottomStreamController =
      StreamController<bool>.broadcast();
  Stream get _scrollToBottomStream => _scrollToBottomStreamController.stream;

  RateWorkoutViewModel _viewModel;
  Workout _workout;
  History _history;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final RateWorkoutArguments routeArguments =
        ModalRoute.of(context).settings.arguments;
    _workout = routeArguments.workout;
    _history = routeArguments.history;
  }

  @override
  void initState() {
    _viewModel = RateWorkoutViewModel();
    super.initState();
  }

  @override
  void dispose() {
    _scrollToBottomStreamController.close();
    super.dispose();
  }

  void _handleCompleteTap() {
    if (_viewModel.completeWorkout(workout: _workout, history: _history) ==
        false) {
      return;
    }
    Navigator.of(context).pushNamed(Routes.workoutOverviewScreen);
  }

  void _handleOpen() {
    _scrollToBottomStreamController.sink.add(true);
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData _mediaQueryData = MediaQuery.of(context);
    final double _maxContainerHeight = _mediaQueryData.size.height -
        _mediaQueryData.padding.top -
        _mediaQueryData.padding.bottom;
    final Orientation _orientation = _mediaQueryData.orientation;

    return WillPopScope(
      onWillPop: () async => false,
      child: KeyboardAndToastProvider(
        child: Container(
          decoration: BoxDecoration(color: styles.Colors.bgBlack),
          child: SafeArea(
            child: KeyboardListView(
              children: [
                Column(
                  children: <Widget>[
                    if (_orientation == Orientation.portrait)
                      _PortraitContainer(
                        scrollToBottomStream: _scrollToBottomStream,
                        handleCompleteTap: _handleCompleteTap,
                        maxContainerHeight: _maxContainerHeight,
                        content: RateWorkoutContent(
                          tempUnit: _viewModel.tempUnit,
                          handleOpen: _handleOpen,
                          handleCompleteTap: _handleCompleteTap,
                          handlePerceivedExertionChanged:
                              _viewModel.setPerceivedExertion,
                          handleBodyWeightChanged: _viewModel.setBodyWeight,
                          handleTemperatureChanged: _viewModel.setTemperature,
                          handleHumidityChanged: _viewModel.setHumidity,
                          handleCommentsChanged: _viewModel.setComments,
                        ),
                      ),
                    if (_orientation == Orientation.landscape)
                      _LandscapeContainer(
                        content: Container(
                          child: Column(
                            children: <Widget>[
                              RateWorkoutContent(
                                handleOpen: _handleOpen,
                                handleCompleteTap: _handleCompleteTap,
                                handlePerceivedExertionChanged:
                                    _viewModel.setPerceivedExertion,
                                handleBodyWeightChanged:
                                    _viewModel.setBodyWeight,
                                handleTemperatureChanged:
                                    _viewModel.setTemperature,
                                handleHumidityChanged: _viewModel.setHumidity,
                                handleCommentsChanged: _viewModel.setComments,
                                tempUnit: _viewModel.tempUnit,
                              ),
                              Divider(
                                height: styles.Measurements.m,
                              ),
                              Button(
                                backgroundColor: styles.Colors.turquoise,
                                width: double.infinity,
                                text: 'done',
                                handleTap: _handleCompleteTap,
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PortraitContainer extends StatefulWidget {
  _PortraitContainer(
      {Key key,
      @required this.content,
      @required this.maxContainerHeight,
      @required this.handleCompleteTap,
      @required this.scrollToBottomStream})
      : super(key: key);

  final Widget content;
  final double maxContainerHeight;
  final VoidCallback handleCompleteTap;
  final Stream scrollToBottomStream;

  @override
  __PortraitContainerState createState() => __PortraitContainerState();
}

class __PortraitContainerState extends State<_PortraitContainer> {
  StreamSubscription _sub;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _sub = widget.scrollToBottomStream.listen((_) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 100), curve: Curves.easeIn);
      });
    });
  }

  @override
  void dispose() {
    _sub.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.maxContainerHeight,
      child: Padding(
        padding: EdgeInsets.all(styles.Measurements.m),
        child: Card(
          padding: EdgeInsets.only(
            left: styles.Measurements.m,
            top: 0,
            right: styles.Measurements.m,
            bottom: styles.Measurements.l,
          ),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: ListView(
                          controller: _scrollController,
                          physics: ClampingScrollPhysics(),
                          children: [widget.content]),
                    ),
                  ],
                ),
              ),
              Divider(
                height: styles.Measurements.xxl,
              ),
              Button(
                backgroundColor: styles.Colors.turquoise,
                width: double.infinity,
                text: 'done',
                handleTap: widget.handleCompleteTap,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LandscapeContainer extends StatelessWidget {
  _LandscapeContainer({Key key, @required this.content}) : super(key: key);

  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: styles.kLandscapeDialogWidth,
      child: Padding(
        padding: EdgeInsets.all(styles.Measurements.m),
        child: Card(
          padding: EdgeInsets.only(
            left: styles.Measurements.m,
            top: 0,
            right: styles.Measurements.m,
            bottom: styles.Measurements.l,
          ),
          child: content,
        ),
      ),
    );
  }
}
