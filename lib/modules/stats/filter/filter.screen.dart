import 'package:flutter/cupertino.dart';
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/modules/common/button.dart';
import 'package:tenso_app/modules/common/divider.dart';
import 'package:tenso_app/modules/common/screen.dart';
import 'package:tenso_app/modules/common/top_navigation.dart';
import 'package:tenso_app/modules/stats/filter/filter.vm.dart';
import 'package:tenso_app/modules/stats/filter/filter_completed_workouts_card.dart';
import 'package:tenso_app/modules/stats/filter/filter_label_picker_card.dart';
import 'package:tenso_app/styles/styles.dart' as styles;

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
                                FilterLabelPickerCard(
                                  resetLabelPicker$:
                                      _viewModel.resetLabelPicker$,
                                  handleLabelChanged:
                                      _viewModel.setSelectedLabel,
                                  labelsWithText:
                                      _viewModel.state.labelsWithText,
                                  initialLabelWithText:
                                      _viewModel.state.initialLabelWithText,
                                ),
                                Divider(
                                  height: styles.Measurements.xl,
                                ),
                                FilterCompletedWorkoutsCard(
                                  handleSelectedWorkout:
                                      _viewModel.setSelectedWorkout,
                                  selectedWorkout:
                                      _viewModel.state.selectedWorkout,
                                  workoutsWithCompletedAmount: _viewModel
                                      .state.workoutsWithCompletedAmount,
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
                  return Container(
                    padding: EdgeInsets.all(styles.Measurements.m),
                    decoration: BoxDecoration(
                        color: styles.Colors.bgWhite,
                        borderRadius: BorderRadius.only(
                            topLeft: styles.kBorderRadius,
                            topRight: styles.kBorderRadius),
                        boxShadow: [styles.kBoxShadow]),
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
