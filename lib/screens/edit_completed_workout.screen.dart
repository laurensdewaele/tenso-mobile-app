import 'package:flutter/cupertino.dart';
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/styles/styles.dart' as styles;
import 'package:tenso_app/view_models/edit_completed_workout.vm.dart';
import 'package:tenso_app/widgets/card.dart';
import 'package:tenso_app/widgets/divider.dart';
import 'package:tenso_app/widgets/keyboard_and_toast_provider.dart';
import 'package:tenso_app/widgets/rate_workout/rate_workout_content.dart';
import 'package:tenso_app/widgets/screen.dart';
import 'package:tenso_app/widgets/top_navigation.dart';

class EditCompletedWorkoutScreenArguments {
  final CompletedWorkout completedWorkout;

  const EditCompletedWorkoutScreenArguments({
    @required this.completedWorkout,
  });
}

class EditCompletedWorkoutScreen extends StatefulWidget {
  EditCompletedWorkoutScreen({Key key}) : super(key: key);

  @override
  _EditCompletedWorkoutScreenState createState() =>
      _EditCompletedWorkoutScreenState();
}

class _EditCompletedWorkoutScreenState
    extends State<EditCompletedWorkoutScreen> {
  EditCompletedWorkoutViewModel _viewModel;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_viewModel == null) {
      final EditCompletedWorkoutScreenArguments routeArguments =
          ModalRoute.of(context).settings.arguments;
      final CompletedWorkout _completedWorkout =
          routeArguments?.completedWorkout;
      _viewModel =
          EditCompletedWorkoutViewModel(completedWorkout: _completedWorkout);
    }
  }

  @override
  void dispose() {
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
            child: ListView(physics: ClampingScrollPhysics(), children: [
              Column(
                children: <Widget>[
                  TopNavigation(
                    title: 'edit completed workout',
                  ),
                  Divider(height: styles.Measurements.xxl),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: styles.Measurements.xs),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: styles.Measurements.m,
                          right: styles.Measurements.m,
                          top: 0,
                          bottom: styles.Measurements.l,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RateWorkoutContent(
                              editing: true,
                              handleBodyWeightChanged:
                                  _viewModel.handleBodyWeightChanged,
                              handleCommentsChanged:
                                  _viewModel.handleCommentsChanged,
                              handleCompleteTap: _viewModel.handleCompleteTap,
                              handleHumidityChanged:
                                  _viewModel.handleHumidityChanged,
                              handlePerceivedExertionChanged:
                                  _viewModel.handlePerceivedExertionChanged,
                              handleTemperatureChanged:
                                  _viewModel.handleTemperatureChanged,
                              initialComments: _viewModel.state.comments,
                              initialPerceivedExertion:
                                  _viewModel.state.perceivedExertion,
                              initialTemperature: _viewModel.state.temperature,
                              initialHumidity: _viewModel.state.humidity,
                              initialBodyWeight: _viewModel.state.bodyWeight,
                              tempUnit: _viewModel.state.tempUnit,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Divider(height: styles.Measurements.xxl)
                ],
              )
            ])),
      ),
    );
  }
}
