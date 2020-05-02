import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/custom_board/custom_board.dart';
import 'package:app/widgets/bottom_menu_drawer.dart';
import 'package:app/widgets/custom_board/add_hold_modal.dart';
import 'package:app/widgets/custom_board/hold_input_modal.dart';
import 'package:app/widgets/icons.dart' as icons;
import 'package:app/widgets/keyboard_and_toast_provider.dart';
import 'package:app/widgets/modal_popup.dart';
import 'package:app/widgets/screen.dart';
import 'package:app/widgets/top_navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class CustomBoardScreen extends StatefulWidget {
  CustomBoardScreen({Key key}) : super(key: key);

  @override
  _CustomBoardScreenState createState() => _CustomBoardScreenState();
}

class _CustomBoardScreenState extends State<CustomBoardScreen> {
  CustomBoardViewModel _viewModel;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    _viewModel = CustomBoardViewModel();
    _viewModel.addListener(_viewModelListener);
    super.initState();
  }

  void _viewModelListener() {
    setState(() {});
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _viewModel.removeListener(_viewModelListener);
    super.dispose();
  }

  void _handleSaveTap() {}
  void _handlePreviewTap() {}
  void _handleInfoTap() {}
  void _handleAddHoldTap() async {
    await showAppModalPopup(
        context: context,
        content: HoldInputModal(
          customBoardViewModel: _viewModel,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardAndToastProvider(
      child: Stack(
        children: <Widget>[
          Screen(
            gradientStartColor: styles.Colors.bgGrayStart,
            gradientStopColor: styles.Colors.bgGrayStop,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TopNavigation(
                  title: 'custom board',
                  dark: true,
                  handleBackNavigation: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                  styles.Measurements.xs, 64, styles.Measurements.xs, 45),
              child: Stack(
                children: <Widget>[
                  ClipRRect(
                      borderRadius: styles.kBorderRadiusAll,
                      // The custom_board image has an aspect ratio of 3
                      child:
                          Image.asset('assets/images/boards/custom_board.png')),
                  AspectRatio(
                    aspectRatio: 3,
                    child: GridView.count(
                      padding: EdgeInsets.all(styles.Measurements.xs),
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      crossAxisSpacing: styles.Measurements.xs,
                      mainAxisSpacing: styles.Measurements.xs,
                      childAspectRatio: 3.6,
                      crossAxisCount: 4,
                      children: <Widget>[
                        ..._viewModel.boxes.map((BoxState boxState) =>
                            boxState.selected == true
                                ? _SelectedBox(
                                    handleTap: () =>
                                        _viewModel.handleBoxTap(boxState))
                                : _Box(
                                    handleTap: () =>
                                        _viewModel.handleBoxTap(boxState),
                                  ))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          BottomMenuDrawer(
            dragIndicatorColor: styles.Colors.lightGray,
            menuItems: [
              MenuItem(
                name: 'save',
                handleTap: _handleSaveTap,
              ),
              MenuItem(
                name: 'preview',
                handleTap: _handlePreviewTap,
              ),
              MenuItem(
                name: 'info',
                handleTap: _handleInfoTap,
              )
            ],
            longestMenuItemLength: 120,
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: AddHoldModal(
                open: _viewModel.addHoldModalOpen,
                handleTap: _handleAddHoldTap,
              ))
        ],
      ),
    );
  }
}

class _Box extends StatelessWidget {
  _Box({Key key, @required this.handleTap}) : super(key: key);

  final VoidCallback handleTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: styles.kBorderRadiusAll,
            border:
                Border.all(width: 1, color: styles.Colors.whiteTranslucent)),
        child: Center(
          child: icons.plusIconWhiteS,
        ),
      ),
    );
  }
}

class _SelectedBox extends StatelessWidget {
  _SelectedBox({Key key, @required this.handleTap}) : super(key: key);

  final VoidCallback handleTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: styles.kBorderRadiusAll,
            border: Border.all(width: 1, color: styles.Colors.black)),
        child: Center(
          child: icons.selectedIconBlackS,
        ),
      ),
    );
  }
}
