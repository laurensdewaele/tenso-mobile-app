import 'package:flutter/cupertino.dart' hide Icon;
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/routes/routes.dart';
import 'package:tenso_app/services/navigation.service.dart';
import 'package:tenso_app/styles/styles.dart' as styles;
import 'package:tenso_app/view_models/workout_overview.vm.dart';
import 'package:tenso_app/widgets/bottom_menu_drawer.dart';
import 'package:tenso_app/widgets/button.dart';
import 'package:tenso_app/widgets/color_square.dart';
import 'package:tenso_app/widgets/dialog.dart';
import 'package:tenso_app/widgets/divider.dart';
import 'package:tenso_app/widgets/icons.dart' as icons;
import 'package:tenso_app/widgets/screen.dart';
import 'package:tenso_app/widgets/sliding_card.dart';
import 'package:tenso_app/widgets/sliding_expansion_card.dart';
import 'package:tenso_app/widgets/workout_overview/delete_action.dart';
import 'package:tenso_app/widgets/workout_overview/edit_action.dart';
import 'package:tenso_app/widgets/workout_overview/workout_expanded_content.dart';
import 'package:tenso_app/widgets/workout_overview/workout_long_press_dialog.dart';

class WorkoutOverviewScreen extends StatefulWidget {
  WorkoutOverviewScreen();

  @override
  _WorkoutOverviewScreenState createState() => _WorkoutOverviewScreenState();
}

class _WorkoutOverviewScreenState extends State<WorkoutOverviewScreen> {
  WorkoutOverviewViewModel _viewModel;

  @override
  void initState() {
    _viewModel = WorkoutOverviewViewModel();
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

  void _handleLongPress(Workout workout) async {
    await showAppDialog(
        smallWidth: true,
        context: context,
        content: WorkoutLongPressDialog(
            onWorkoutOverviewScreen: true,
            name: workout.name,
            handleDeleteTap: () => _viewModel.deleteWorkout(workout),
            handleCopyTap: () => _viewModel.copyWorkout(workout),
            handleEditTap: () => _viewModel.editWorkout(workout)));
  }

  @override
  Widget build(BuildContext context) {
    final EdgeInsets padding = MediaQuery.of(context).padding;
    final double viewHeight =
        MediaQuery.of(context).size.height - padding.top - padding.bottom;
    return WillPopScope(
      onWillPop: () async => false,
      child: Stack(
        children: <Widget>[
          Screen(
            padding: EdgeInsets.symmetric(
                horizontal: styles.Measurements.xs,
                vertical: styles.Measurements.m),
            child: ListView(
              key: ValueKey(_viewModel.workoutList.hashCode),
              physics: ClampingScrollPhysics(),
              children: <Widget>[
                ..._viewModel.workoutList
                    .asMap()
                    .map((int index, Workout workout) => MapEntry(
                        index,
                        SlidingCard(
                          disabled: false,
                          key: ValueKey(workout.id),
                          border: false,
                          divider: _viewModel.workoutList.length > 1 &&
                              index != _viewModel.workoutList.length - 1,
                          dividerHeight: styles.Measurements.m,
                          leftAction: EditAction(),
                          handleLeftActionTap: () =>
                              _viewModel.editWorkout(workout),
                          rightAction: DeleteAction(),
                          handleRightActionTap: () =>
                              _viewModel.deleteWorkout(workout),
                          handleLongPress: () => _handleLongPress(workout),
                          content: SlidingExpansionCard(
                            padding: const EdgeInsets.symmetric(
                                vertical: styles.Measurements.s),
                            topLeftSection: Container(
                              padding:
                                  EdgeInsets.only(left: styles.Measurements.s),
                              height: styles.Measurements.xxl,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(workout.name,
                                      style: styles.Staatliches.xlBlack,
                                      overflow: TextOverflow.ellipsis),
                                ],
                              ),
                            ),
                            topRightSection: Padding(
                              padding: const EdgeInsets.only(
                                  right: styles.Measurements.s),
                              child: ColorSquare(
                                color: workout.labelColor,
                                width: styles.Measurements.xxl,
                                height: styles.Measurements.xxl,
                              ),
                            ),
                            topRightSectionWidth:
                                styles.Measurements.xxl + styles.Measurements.s,
                            handleTap: () {},
                            content: WorkoutExpandedContent(
                              workout: workout,
                              handleStart: () => _viewModel.start(workout),
                            ),
                            handleLongPress: () => _handleLongPress(workout),
                          ),
                        )))
                    .values
                    .toList(),
                if (_viewModel.workoutList.length > 0)
                  Divider(height: styles.Measurements.l),
                Button(
                    text: 'Add workout',
                    handleTap: _viewModel.addWorkout,
                    leadingIcon: icons.plusIconWhiteXl),
                // When scrolling down, the start button will be centered on the screen.
                Divider(height: viewHeight / 2 - styles.Measurements.m)
              ],
            ),
          ),
          BottomMenuDrawer(
            safeAreaPaddingBottom: MediaQuery.of(context).padding.bottom,
            startOpen: _viewModel.startOpen,
            menuItems: _menuItems,
            longestMenuItemLength: 140,
            dragIndicatorColor: styles.Colors.primary,
            icons: true,
          )
        ],
      ),
    );
  }
}

List<MenuItem> _menuItems = [
  MenuItem(
      name: 'calendar',
      handleTap: () {
        NavigationService().pushNamed(Routes.calendarScreen);
      },
      icon: icons.calendarIconBlackM),
  MenuItem(
      name: 'feedback',
      handleTap: () {
        NavigationService().pushNamed(Routes.feedbackScreen);
      },
      icon: icons.editIconBlackS),
  MenuItem(
      name: 'info',
      handleTap: () {
        NavigationService().pushNamed(Routes.infoScreen);
      },
      icon: icons.infoIconBlackL),
  MenuItem(
      name: 'progress',
      handleTap: () {
        NavigationService().pushNamed(Routes.progressScreen);
      },
      icon: icons.chartIconBlackS),
  MenuItem(
      name: 'settings',
      handleTap: () {
        NavigationService().pushNamed(Routes.settingsScreen);
      },
      icon: icons.settingsIconBlackL),
];
