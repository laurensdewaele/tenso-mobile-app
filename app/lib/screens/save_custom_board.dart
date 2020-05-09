import 'package:app/data/custom_board_hold_builder.dart' as customBoard;
import 'package:app/models/models.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/custom_board/save_custom_board_vm.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/card.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/keyboard_and_toast_provider.dart';
import 'package:app/widgets/keyboard_list_view.dart';
import 'package:app/widgets/screen.dart';
import 'package:app/widgets/section.dart';
import 'package:app/widgets/section_with_info_icon.dart';
import 'package:app/widgets/text_input.dart';
import 'package:app/widgets/top_navigation.dart';
import 'package:app/widgets/workout/board_hold_info.dart';
import 'package:app/widgets/workout/board_hold_picker.dart';
import 'package:flutter/cupertino.dart';

class SaveCustomBoardScreenArguments {
  SaveCustomBoardScreenArguments({
    @required this.boardHolds,
    @required this.customBoardHoldImages,
  });

  List<BoardHold> boardHolds;
  List<CustomBoardHoldImage> customBoardHoldImages;
}

class SaveCustomBoardScreen extends StatefulWidget {
  SaveCustomBoardScreen({Key key}) : super(key: key);

  @override
  _SaveCustomBoardScreenState createState() => _SaveCustomBoardScreenState();
}

class _SaveCustomBoardScreenState extends State<SaveCustomBoardScreen> {
  SaveCustomBoardViewModel _viewModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_viewModel == null) {
      final SaveCustomBoardScreenArguments routeArguments =
          ModalRoute.of(context).settings.arguments;
      _viewModel = SaveCustomBoardViewModel(
          boardHolds: routeArguments.boardHolds,
          customBoardHoldImages: routeArguments.customBoardHoldImages);
      _viewModel.addListener(_viewModelListener);
    }
  }

  @override
  void initState() {
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

  @override
  Widget build(BuildContext context) {
    return KeyboardAndToastProvider(
      child: Stack(
        children: <Widget>[
          Screen(
            gradientStartColor: styles.Colors.bgGrayStart,
            gradientStopColor: styles.Colors.bgGrayStop,
            child: KeyboardListView(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    TopNavigation(
                      title: 'save custom board',
                      dark: true,
                      handleBackNavigation: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(
                            styles.Measurements.xs,
                            64,
                            styles.Measurements.xs,
                            styles.Measurements.xxl),
                        child: Card(
                          padding: EdgeInsets.only(
                            left: styles.Measurements.m,
                            top: 0,
                            right: styles.Measurements.m,
                            bottom: styles.Measurements.l,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Divider(height: 14),
                              SectionWithInfoIcon(
                                title: 'select default holds',
                                appDialogContent: _DefaultHoldInfo(),
                                children: <Widget>[
                                  BoardHoldPicker(
                                    boardAspectRatio: customBoard.kAspectRatio,
                                    boardImageAsset: customBoard.kImageAsset,
                                    handToBoardHeightRatio:
                                        customBoard.kHandToBoardHeightRatio,
                                    imageAsset: customBoard.kImageAsset,
                                    boardHolds: _viewModel.boardHolds,
                                    customBoardHoldImages:
                                        _viewModel.customBoardHoldImages,
                                    rightGrip: _viewModel.rightGrip,
                                    leftGrip: _viewModel.leftGrip,
                                    leftGripBoardHold:
                                        _viewModel.leftGripBoardHold,
                                    rightGripBoardHold:
                                        _viewModel.rightGripBoardHold,
                                    handleLeftGripBoardHoldChanged: _viewModel
                                        .handleLeftGripBoardHoldChanged,
                                    handleRightGripBoardHoldChanged: _viewModel
                                        .handleRightGripBoardHoldChanged,
                                  ),
                                  BoardHoldInfo(
                                    leftGripBoardHold:
                                        _viewModel.leftGripBoardHold,
                                    rightGripBoardHold:
                                        _viewModel.rightGripBoardHold,
                                    leftGrip: _viewModel.leftGrip,
                                    rightGrip: _viewModel.rightGrip,
                                  )
                                ],
                              ),
                              Section(
                                title: 'name',
                                children: <Widget>[
                                  TextInput(
                                      multiLine: false,
                                      enabled: true,
                                      primaryColor: styles.Colors.primary,
                                      initialValue: '',
                                      handleValueChanged: _viewModel.setName)
                                ],
                              ),
                              Center(
                                child: Button(
                                  backgroundColor: styles.Colors.primary,
                                  width: styles.Measurements.xxl * 2,
                                  text: 'save',
                                  handleTap: _viewModel.save,
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DefaultHoldInfo extends StatelessWidget {
  _DefaultHoldInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Place the hands in the most common, '
          'most often used holds of the board. '
          'This is done so you will loose less time '
          'positioning them correctly on every new '
          'workout creation.',
          style: styles.Lato.xsBlack,
        ),
        Divider(height: styles.Measurements.l),
        Center(
          child: Transform.scale(
            scale: .8,
            child: Button(
                displayBackground: false,
                text: 'Ok',
                handleTap: () {
                  Navigator.of(context).pop();
                }),
          ),
        )
      ],
    );
  }
}
