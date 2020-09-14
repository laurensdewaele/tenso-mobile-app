import 'package:flutter/cupertino.dart';
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/styles/styles.dart' as styles;
import 'package:tenso_app/view_models/stats/filter.vm.dart';
import 'package:tenso_app/view_models/stats/filter_state.vm.dart';
import 'package:tenso_app/widgets/button.dart';
import 'package:tenso_app/widgets/card.dart';
import 'package:tenso_app/widgets/color_square.dart';
import 'package:tenso_app/widgets/divider.dart';
import 'package:tenso_app/widgets/label_text_picker.dart';
import 'package:tenso_app/widgets/screen.dart';
import 'package:tenso_app/widgets/top_navigation.dart';

class FilterScreenArguments {
  final Label filteredLabel;
  final Workout filteredWorkout;

  const FilterScreenArguments({
    @required this.filteredLabel,
    @required this.filteredWorkout,
  });
}

class FilterScreen extends StatefulWidget {
  FilterScreen({Key key}) : super(key: key);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  FilterViewModel _viewModel;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_viewModel == null) {
      final FilterScreenArguments _routeArguments =
          ModalRoute.of(context).settings.arguments;
      _viewModel = FilterViewModel(
          filteredLabel: _routeArguments.filteredLabel,
          filteredWorkout: _routeArguments.filteredWorkout);
      _viewModel.addListener(_viewModelListener);
    }
  }

  void _viewModelListener() {
    setState(() {});
  }

  @override
  void dispose() {
    _viewModel.removeListener(_viewModelListener);
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _completedWorkoutsByAmount =
        _viewModel.state.completedWorkoutsByAmount;

    return WillPopScope(
      onWillPop: () async {
        _viewModel.handleBackNavigation();
        return false;
      },
      child: LayoutBuilder(builder: (context, constraints) {
        return Screen(
          backgroundColor: styles.Colors.bgGray,
          handleBackNavigation: _viewModel.handleBackNavigation,
          child: Stack(
            fit: StackFit.expand,
            children: [
              ListView(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      TopNavigation(
                        handleBackNavigation: _viewModel.handleBackNavigation,
                        title: 'choose filter',
                        dark: false,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: styles.Measurements.xs,
                            vertical: styles.Measurements.xxl),
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Card(
                                  padding:
                                      EdgeInsets.all(styles.Measurements.m),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'label',
                                        style: styles.Staatliches.xlBlack,
                                      ),
                                      Divider(height: styles.Measurements.m),
                                      LabelWithTextPicker(
                                        reset$: _viewModel.reset$,
                                        handleLabelChanged:
                                            _viewModel.setSelectedLabel,
                                        labelsWithText:
                                            _viewModel.state.labelsWithText,
                                        initialLabelWithText: _viewModel
                                            .state.initialLabelWithText,
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  height: styles.Measurements.xl,
                                ),
                                Card(
                                  padding:
                                      EdgeInsets.all(styles.Measurements.m),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'workout',
                                        style: styles.Staatliches.xlBlack,
                                      ),
                                      Divider(height: styles.Measurements.l),
                                      ..._completedWorkoutsByAmount
                                          .asMap()
                                          .map((int index,
                                                  WorkoutWithCompletedAmount
                                                      w) =>
                                              MapEntry(
                                                  index,
                                                  GestureDetector(
                                                    onTap: () => _viewModel
                                                        .setSelectedWorkout(
                                                            w.workout),
                                                    child:
                                                        _CompletedWorkoutCard(
                                                      divider: _completedWorkoutsByAmount
                                                                  .length >
                                                              1 &&
                                                          index !=
                                                              _completedWorkoutsByAmount
                                                                      .length -
                                                                  1,
                                                      labelColor:
                                                          w.workout.labelColor,
                                                      completedAmount:
                                                          w.completedAmount,
                                                      isSelected: _viewModel
                                                              .state
                                                              .selectedWorkout
                                                              ?.id ==
                                                          w.workout.id,
                                                      workoutName:
                                                          w.workout.name,
                                                    ),
                                                  )))
                                          .values
                                          .toList(),
                                    ],
                                  ),
                                ),
                                Divider(
                                  height: styles.Measurements.xxl +
                                      styles.Measurements.m,
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                child: LayoutBuilder(builder: (context, _) {
                  final double _dividerWidth = styles.Measurements.m;
                  final double _padding = styles.Measurements.m;
                  final double _buttonWidth =
                      (constraints.maxWidth - _dividerWidth - _padding * 2) / 2;
                  return Card(
                    padding: EdgeInsets.all(_padding),
                    child: Row(
                      children: [
                        Button(
                          handleTap: _viewModel.handleClearTap,
                          text: 'clear',
                          backgroundColor: styles.Colors.primary,
                          width: _buttonWidth,
                          smallText: true,
                          height: styles.kSmallButtonHeight,
                        ),
                        Divider(
                          width: _dividerWidth,
                        ),
                        Button(
                          handleTap: _viewModel.handleApplyTap,
                          text: 'apply',
                          backgroundColor: styles.Colors.turquoise,
                          width: _buttonWidth,
                          smallText: true,
                          height: styles.kSmallButtonHeight,
                        ),
                      ],
                    ),
                  );
                }),
              )
            ],
          ),
        );
      }),
    );
  }
}

class _CompletedWorkoutCard extends StatelessWidget {
  const _CompletedWorkoutCard({
    Key key,
    @required this.isSelected,
    @required this.workoutName,
    @required this.labelColor,
    @required this.completedAmount,
    @required this.divider,
  });

  final bool isSelected;
  final bool divider;
  final String workoutName;
  final Color labelColor;
  final int completedAmount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(
              isSelected ? styles.Measurements.s - 1 : styles.Measurements.s),
          decoration: BoxDecoration(
            borderRadius: styles.kBorderRadiusAll,
            border: Border.all(
              color: isSelected ? styles.Colors.turquoise : styles.Colors.gray,
              width: isSelected ? 2 : 1,
            ),
            color: styles.Colors.bgWhite,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(workoutName,
                      style: styles.Staatliches.xlBlack,
                      overflow: TextOverflow.ellipsis),
                ],
              ),
              ColorSquare(
                color: labelColor,
                width: styles.Measurements.xxl,
                height: styles.Measurements.xxl,
                text: '${completedAmount.toString()}X',
              )
            ],
          ),
        ),
        if (divider == true) Divider(height: styles.Measurements.m)
      ],
    );
  }
}
