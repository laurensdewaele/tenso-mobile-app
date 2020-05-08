import 'package:app/routes/routes.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/custom_board/custom_board_vm.dart';
import 'package:app/widgets/bottom_menu_drawer.dart';
import 'package:app/widgets/custom_board/add_hold_modal.dart';
import 'package:app/widgets/custom_board/custom_board.dart';
import 'package:app/widgets/custom_board/hold_input_modal.dart';
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

  void _handleSaveTap() {
    Navigator.of(context).pushNamed(Routes.saveCustomBoardScreen);
  }

  void _handlePreviewTap() {}
  void _handleInfoTap() {}
  void _handleAddHoldTap() async {
    await showAppModalPopup(
        context: context,
        content: HoldInputModal(
          isTopRow: _viewModel.selectedBoxesIsTopRow,
          multipleSelection: _viewModel.selectedBoxes.length > 1,
          handleEdgeInput: _viewModel.handleEdgeInput,
          handleSloperInput: _viewModel.handleSloperInput,
          handlePocketInput: _viewModel.handlePocketInput,
          handleJugInput: _viewModel.handleJugInput,
          handlePinchBlockInput: _viewModel.handlePinchBlockInput,
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
                child: CustomBoard(
                  boxes: _viewModel.boxes,
                  handleBoxTap: _viewModel.handleBoxTap,
                  customBoardHoldImages: _viewModel.customBoardHoldImages,
                  boardHolds: _viewModel.boardHolds,
                )),
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
