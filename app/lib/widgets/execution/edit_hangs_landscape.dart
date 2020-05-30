import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/execution/edit_hangs_dialog.vm.dart';
import 'package:app/widgets/board/board_with_grips.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/execution/edit_hangs_cupertino_picker.dart';
import 'package:app/widgets/number_input_and_description.dart';
import 'package:flutter/cupertino.dart';

class EditHangsLandScape extends StatelessWidget {
  const EditHangsLandScape({
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
      children: <Widget>[
        Expanded(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      LayoutBuilder(builder:
                          (BuildContext context, BoxConstraints constraints) {
                        return Container(
                          width: constraints.maxWidth / 1.5,
                          child: BoardWithGrips(
                            key: ValueKey(
                                'edit-hangs-dialog-board-${selectedHang.currentHang}'),
                            boardImageAssetWidth: selectedHang.imageAssetWidth,
                            boardImageAsset: selectedHang.imageAsset,
                            customBoardHoldImages:
                                selectedHang.customBoardHoldImages,
                            withFixedHeight: true,
                            handToBoardHeightRatio:
                                selectedHang.handToBoardHeightRatio,
                            boardAspectRatio: selectedHang.boardAspectRatio,
                            rightGripBoardHold: selectedHang.rightGripBoardHold,
                            leftGripBoardHold: selectedHang.leftGripBoardHold,
                            leftGrip: selectedHang.leftGrip,
                            rightGrip: selectedHang.rightGrip,
                          ),
                        );
                      }),
                      NumberInputAndDescription<int>(
                        key: ValueKey(
                            'edit-hangs-dialog-duration-input-landscape-${selectedHang.currentHang}'),
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
                            'edit-hangs-dialog-added-weight-input-landscape-${selectedHang.currentHang}'),
                        enabled: true,
                        description: '${selectedHang.weightUnit} added weight',
                        handleValueChanged: setAddedWeightInput,
                        initialValue: selectedHang.addedWeight,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: EditHangsCupertinoPicker(
                        canScroll: canScroll,
                        handleScrollAttempt: handleScrollAttempt,
                        hangs: hangs,
                        selectedHang: selectedHang,
                        setSelectedHang: setSelectedHang,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Button(
              width: 150,
              handleTap: handleDone,
              text: 'Done',
              small: true,
              displayBackground: false,
            ),
          ],
        )
      ],
    );
  }
}
