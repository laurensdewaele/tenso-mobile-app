import 'package:app/routes/routes.dart';
import 'package:app/screens/save_custom_board.screen.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/custom_board/custom_board.vm.dart';
import 'package:app/widgets/bottom_menu_drawer.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/custom_board/add_hold_modal.dart';
import 'package:app/widgets/custom_board/custom_board.dart';
import 'package:app/widgets/custom_board/edit_delete_modal.dart';
import 'package:app/widgets/custom_board/hold_input_modal.dart';
import 'package:app/widgets/dialog.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/keyboard_and_toast_provider.dart';
import 'package:app/widgets/modal_popup.dart';
import 'package:app/widgets/screen.dart';
import 'package:app/widgets/top_navigation.dart';
import 'package:flutter/cupertino.dart';

class CustomBoardScreen extends StatefulWidget {
  CustomBoardScreen({Key key}) : super(key: key);

  @override
  _CustomBoardScreenState createState() => _CustomBoardScreenState();
}

class _CustomBoardScreenState extends State<CustomBoardScreen> {
  CustomBoardViewModel _viewModel;

  @override
  void initState() {
    _viewModel = CustomBoardViewModel();
    _viewModel.addListener(_viewModelListener);
    super.initState();
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

  void _handleSaveTap() {
    if (_viewModel.checkBoardHoldAmount() == true) {
      Navigator.of(context).pushNamed(Routes.saveCustomBoardScreen,
          arguments: SaveCustomBoardScreenArguments(
              boardHolds: _viewModel.boardHolds,
              customBoardHoldImages: _viewModel.customBoardHoldImages));
    }
  }

  void _handleInfoTap() async {
    await showAppDialog(context: context, content: _InfoDialog());
  }

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
            handleBackNavigation: () {
              Navigator.of(context).pop();
            },
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
                  handleCustomBoardHoldImageTap:
                      _viewModel.handleCustomBoardHoldImageTap,
                  selectedCustomBoardHoldImage:
                      _viewModel.selectedCustomBoardHoldImage,
                )),
          ),
          BottomMenuDrawer(
            close$: _viewModel.closeBottomMenuDrawer$,
            dragIndicatorColor: styles.Colors.lightGray,
            menuItems: [
              MenuItem(
                name: 'save',
                handleTap: _handleSaveTap,
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
              child: EditDeleteModal(
                holdType: _viewModel.boardHoldForSelectedImage?.holdType,
                depth: _viewModel.boardHoldForSelectedImage?.depth,
                sloperDegrees:
                    _viewModel.boardHoldForSelectedImage?.sloperDegrees,
                supportedFingers:
                    _viewModel.boardHoldForSelectedImage?.supportedFingers,
                open: _viewModel.editDeleteModalOpen,
                handleDeleteTap: _viewModel.deleteSelectedCustomBoardHoldImage,
              )),
          Align(
              alignment: Alignment.bottomCenter,
              child: AddHoldModal(
                open: _viewModel.addHoldModalOpen,
                handleTap: _handleAddHoldTap,
              )),
        ],
      ),
    );
  }
}

class _InfoDialog extends StatelessWidget {
  _InfoDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        RichText(
          text: TextSpan(text: '', style: styles.Lato.xsBlack, children: [
            TextSpan(
                text: 'This section is for people who have created '
                    'their own hangboard, or is needed for people whose hangboard '
                    'is not yet available in the list of boards to choose from.',
                style: styles.Lato.xsBlack),
          ]),
        ),
        Divider(
          height: styles.Measurements.m,
        ),
        RichText(
          text: TextSpan(text: '', style: styles.Lato.xsBlack, children: [
            TextSpan(
                text:
                    'You can select multiple boxes in order to create a hold that stretches across multiple columns.',
                style: styles.Lato.xsBlack),
          ]),
        ),
        Divider(
          height: styles.Measurements.l,
        ),
        Button(
            small: true,
            displayBackground: false,
            text: 'Ok',
            handleTap: () {
              Navigator.of(context).pop();
            })
      ],
    );
  }
}
