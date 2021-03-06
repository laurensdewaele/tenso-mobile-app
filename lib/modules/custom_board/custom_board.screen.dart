import 'package:flutter/cupertino.dart';
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/modules/common/bottom_menu_drawer.dart';
import 'package:tenso_app/modules/common/dialog.dart';
import 'package:tenso_app/modules/common/divider.dart';
import 'package:tenso_app/modules/common/modal_popup.dart';
import 'package:tenso_app/modules/common/ok_button.dart';
import 'package:tenso_app/modules/common/screen.dart';
import 'package:tenso_app/modules/common/top_navigation.dart';
import 'package:tenso_app/modules/custom_board/add_hold_modal.dart';
import 'package:tenso_app/modules/custom_board/choose_hold_type_modal.dart';
import 'package:tenso_app/modules/custom_board/custom_board.dart';
import 'package:tenso_app/modules/custom_board/custom_board.vm.dart';
import 'package:tenso_app/modules/custom_board/edit_delete_modal.dart';
import 'package:tenso_app/modules/keyboard_input/keyboard_and_toast_provider.dart';
import 'package:tenso_app/styles/styles.dart' as styles;

class CustomBoardScreenArguments {
  final Board boardToEdit;

  const CustomBoardScreenArguments({
    @required this.boardToEdit,
  });
}

class CustomBoardScreen extends StatefulWidget {
  CustomBoardScreen({Key key}) : super(key: key);

  @override
  _CustomBoardScreenState createState() => _CustomBoardScreenState();
}

class _CustomBoardScreenState extends State<CustomBoardScreen> {
  CustomBoardViewModel _viewModel;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_viewModel == null) {
      final CustomBoardScreenArguments routeArguments =
          ModalRoute.of(context).settings.arguments;
      final Board _boardToEdit = routeArguments?.boardToEdit;
      _viewModel = CustomBoardViewModel(boardToEdit: _boardToEdit);
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

  void _handleInfoTap() async {
    await showAppDialog(
        context: context, content: _InfoDialog(), smallWidth: false);
  }

  void _handleAddHoldTap() async {
    await showAppModalPopup(
        context: context,
        content: ChooseHoldTypeModal(
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
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TopNavigation(
                  title: 'custom board',
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
            safeAreaPaddingBottom: MediaQuery.of(context).padding.bottom,
            close$: _viewModel.closeBottomMenuDrawer$,
            dragIndicatorColor: styles.Colors.lightGray,
            menuItems: [
              MenuItem(
                name: 'save',
                handleTap: _viewModel.handleSaveTap,
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
        OKButton(handleTap: () {
          Navigator.of(context).pop();
        }),
      ],
    );
  }
}
