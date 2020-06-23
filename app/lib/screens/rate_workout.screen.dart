import 'package:app/models/models.dart';
import 'package:app/routes/routes.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/rate_workout.vm.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/card.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/rate_workout/rate_workout_content.dart';
import 'package:app/widgets/toast_provider.dart';
import 'package:flutter/cupertino.dart' hide Icon;
import 'package:flutter/scheduler.dart';

class RateWorkoutArguments {
  RateWorkoutArguments({@required this.workout, @required this.history});

  final Workout workout;
  final History history;
}

class RateWorkoutScreen extends StatefulWidget {
  RateWorkoutScreen({Key key}) : super(key: key);

  @override
  _RateWorkoutScreenState createState() => _RateWorkoutScreenState();
}

class _RateWorkoutScreenState extends State<RateWorkoutScreen> {
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
    super.dispose();
  }

  void _handleCompleteTap() {
    if (_viewModel.completeWorkout(workout: _workout, history: _history) ==
        false) {
      return;
    }
    Navigator.of(context).pushNamed(Routes.workoutOverviewScreen);
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
      child: ToastProvider(
        child: Container(
          decoration: BoxDecoration(color: styles.Colors.bgBlack),
          child: SafeArea(
            child: Column(
              children: <Widget>[
                if (_orientation == Orientation.portrait)
                  _PortraitContainer(
                    handleCompleteTap: _handleCompleteTap,
                    maxContainerHeight: _maxContainerHeight,
                    content: RateWorkoutContent(
                      handleOpen: () {},
                      tempUnit: _viewModel.tempUnit,
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
                            handleOpen: () {},
                            handleCompleteTap: _handleCompleteTap,
                            handlePerceivedExertionChanged:
                                _viewModel.setPerceivedExertion,
                            handleBodyWeightChanged: _viewModel.setBodyWeight,
                            handleTemperatureChanged: _viewModel.setTemperature,
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
            ),
          ),
        ),
      ),
    );
  }
}

class _PortraitContainer extends StatelessWidget {
  _PortraitContainer({
    Key key,
    @required this.content,
    @required this.maxContainerHeight,
    @required this.handleCompleteTap,
  }) : super(key: key);

  final Widget content;
  final double maxContainerHeight;
  final VoidCallback handleCompleteTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: maxContainerHeight,
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
                          physics: ClampingScrollPhysics(),
                          children: [content]),
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
                handleTap: handleCompleteTap,
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
