import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/execution/edit_hangs_dialog.vm.dart';
import 'package:app/widgets/board/board_with_grips.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/execution/edit_hangs_cupertino_picker.dart';
import 'package:app/widgets/number_input_and_description.dart';
import 'package:flutter/cupertino.dart';

class EditHangsPortrait extends StatelessWidget {
  const EditHangsPortrait({
    @required this.hangText,
    @required this.selectedHang,
    @required this.setText,
    @required this.handleDone,
    @required this.setHangTimeInput,
    @required this.setAddedWeightInput,
    @required this.handleScrollAttempt,
    @required this.canScroll,
    @required this.hangs,
    @required this.setSelectedHang,
  });

  final String hangText;
  final Hang selectedHang;
  final String setText;
  final VoidCallback handleDone;
  final void Function(String s) setHangTimeInput;
  final void Function(String s) setAddedWeightInput;

  final VoidCallback handleScrollAttempt;
  final bool canScroll;
  final List<Hang> hangs;
  final Function(int index) setSelectedHang;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        hangText,
                        style: styles.Staatliches.xlBlack,
                      ),
                      if (selectedHang.totalSets > 1)
                        Text(
                          setText,
                          style: styles.Staatliches.xlBlack,
                        ),
                    ],
                  ),
                  Divider(height: styles.Measurements.l),
                  BoardWithGrips(
                    key: ValueKey(
                        'edit-hangs-dialog-board-${selectedHang.currentHang}'),
                    boardImageAssetWidth: selectedHang.imageAssetWidth,
                    boardImageAsset: selectedHang.imageAsset,
                    customBoardHoldImages: selectedHang.customBoardHoldImages,
                    withFixedHeight: true,
                    handToBoardHeightRatio: selectedHang.handToBoardHeightRatio,
                    boardAspectRatio: selectedHang.boardAspectRatio,
                    rightGripBoardHold: selectedHang.rightGripBoardHold,
                    leftGripBoardHold: selectedHang.leftGripBoardHold,
                    leftGrip: selectedHang.leftGrip,
                    rightGrip: selectedHang.rightGrip,
                  ),
                  NumberInputAndDescription<int>(
                    key: ValueKey(
                        'edit-hangs-dialog-duration-input-${selectedHang.currentHang}'),
                    enabled: true,
                    description: selectedHang.isPastHang
                        ? 'effective hung seconds'
                        : 'hang time seconds',
                    handleValueChanged: setHangTimeInput,
                    initialValue: selectedHang.duration,
                  ),
                  Divider(
                    height: styles.Measurements.m,
                  ),
                  NumberInputAndDescription<double>(
                    key: ValueKey(
                        'edit-hangs-dialog-added-weight-input-${selectedHang.currentHang}'),
                    enabled: true,
                    description: '${selectedHang.weightUnit} added weight',
                    handleValueChanged: setAddedWeightInput,
                    initialValue: selectedHang.addedWeight,
                  ),
                ],
              ),
              Divider(
                height: styles.Measurements.l,
              ),
              Container(
                height: 1,
                width: double.infinity,
                decoration: BoxDecoration(color: styles.Colors.lighestGray),
              ),
              Expanded(
                child: EditHangsCupertinoPicker(
                  canScroll: canScroll,
                  handleScrollAttempt: handleScrollAttempt,
                  hangs: hangs,
                  selectedHang: selectedHang,
                  setSelectedHang: setSelectedHang,
                ),
              ),
              Container(
                height: 1,
                width: double.infinity,
                decoration: BoxDecoration(color: styles.Colors.lighestGray),
              ),
            ],
          ),
        ),
        Button(
          handleTap: handleDone,
          text: 'Done',
          small: true,
          displayBackground: false,
        )
      ],
    );
  }
}
