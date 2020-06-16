import 'package:app/models/models.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/board/board_with_grips.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/card.dart';
import 'package:app/widgets/dialog.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/icons.dart' as icons;
import 'package:app/widgets/sliding_card.dart';
import 'package:app/widgets/workout_overview/delete_action.dart';
import 'package:app/widgets/workout_overview/edit_action.dart';
import 'package:flutter/cupertino.dart' hide Icon;

class GroupOverview extends StatefulWidget {
  GroupOverview(
      {Key key,
      @required this.groups,
      @required this.weightUnit,
      @required this.handleEditGroup,
      @required this.handleDeleteGroup})
      : super(key: key);

  final List<Group> groups;
  final String weightUnit;
  final void Function(Group group, int groupIndex) handleEditGroup;
  final void Function(Group group, int groupIndex) handleDeleteGroup;

  @override
  _GroupOverviewState createState() => _GroupOverviewState();
}

class _GroupOverviewState extends State<GroupOverview> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleEditTap(int index) {}

  void _handleDeleteTap(int index) {}

  void _handleLongPress(int index) {}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ...widget.groups
            .asMap()
            .map((int index, Group group) {
              final _gripCount =
                  'X${group.repetitions} ${group.sets > 1 ? 'X${group.sets}' : ''}';
              return MapEntry(
                  index,
                  SlidingCard(
                    divider: widget.groups.length > 1 &&
                        index != widget.groups.length - 1,
                    dividerHeight: styles.Measurements.m,
                    leftAction: EditAction(),
                    rightAction: DeleteAction(),
                    content: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: styles.Colors.gray),
                        borderRadius: styles.kBorderRadiusAll,
                        color: styles.Colors.bgWhite,
                      ),
                      padding: EdgeInsets.only(
                          left: 0,
                          top: styles.Measurements.s,
                          right: 0,
                          bottom: styles.Measurements.s),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: styles.Measurements.s),
                              child: BoardWithGrips(
                                rightGrip: group.rightGrip,
                                leftGrip: group.leftGrip,
                                rightGripBoardHold: group.rightGripBoardHold,
                                leftGripBoardHold: group.leftGripBoardHold,
                                boardAspectRatio: group.board.aspectRatio,
                                customBoardHoldImages:
                                    group.board.customBoardHoldImages?.toList(),
                                handToBoardHeightRatio:
                                    group.board.handToBoardHeightRatio,
                                withFixedHeight: false,
                                boardImageAsset: group.board.imageAsset,
                                boardImageAssetWidth:
                                    group.board.imageAssetWidth,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: styles.Measurements.s),
                              child: Text(
                                _gripCount,
                                style: styles.Staatliches.xlBlack,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            flex: 1,
                          ),
                        ],
                      ),
                    ),
                    border: false,
                    handleLeftActionTap: () {
                      _handleEditTap(index);
                    },
                    handleLongPress: () {
                      _handleLongPress(index);
                    },
                    handleRightActionTap: () {
                      _handleDeleteTap(index);
                    },
                  ));
            })
            .values
            .toList()
      ],
    );
  }
}

class _GroupCard extends StatelessWidget {
  const _GroupCard({
    @required this.group,
    @required this.currentGroupIndex,
    @required this.totalGroups,
    @required this.handleEditGroup,
    @required this.handleDeleteGroup,
    @required this.weightUnit,
    @required this.context,
  });

  final Group group;
  final int currentGroupIndex;
  final int totalGroups;
  final void Function(Group group, int groupIndex) handleEditGroup;
  final void Function(Group group, int groupIndex) handleDeleteGroup;
  final String weightUnit;
  final BuildContext context;

  void _handleEditTap() {
    Navigator.of(context).pop();
    handleEditGroup(group, currentGroupIndex);
  }

  void _handleDeleteTap() {
    Navigator.of(context).pop();
    handleDeleteGroup(group, currentGroupIndex);
  }

  void _handleBackTap() {
    Navigator.of(context).pop();
  }

  void _handleInteraction() async {
    await showAppDialog(
        smallWidth: true,
        context: context,
        content: _EditDeleteDialog(
          title: 'group ${currentGroupIndex + 1}/$totalGroups',
          handleEditTap: _handleEditTap,
          handleDeleteTap: _handleDeleteTap,
          handleBackTap: _handleBackTap,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: _handleInteraction,
      onTap: _handleInteraction,
      child: Card(
        bgColor: styles.Colors.white,
        padding: EdgeInsets.all(styles.Measurements.m),
        child: Column(
          children: <Widget>[
            Text(
              'group ${currentGroupIndex + 1}/$totalGroups',
              style: styles.Staatliches.lBlack,
            ),
            Divider(height: styles.Measurements.xs),
            BoardWithGrips(
              rightGrip: group.rightGrip,
              leftGrip: group.leftGrip,
              rightGripBoardHold: group.rightGripBoardHold,
              leftGripBoardHold: group.leftGripBoardHold,
              boardAspectRatio: group.board.aspectRatio,
              customBoardHoldImages:
                  group.board.customBoardHoldImages?.toList(),
              handToBoardHeightRatio: group.board.handToBoardHeightRatio,
              withFixedHeight: true,
              boardImageAsset: group.board.imageAsset,
              boardImageAssetWidth: group.board.imageAssetWidth,
            ),
            _GroupInfo(
              weightUnit: weightUnit,
              group: group,
            )
          ],
        ),
      ),
    );
  }
}

class _GroupInfo extends StatelessWidget {
  const _GroupInfo({@required this.group, @required this.weightUnit});

  final Group group;
  final String weightUnit;

  @override
  Widget build(BuildContext context) {
    const double _rowHeight = 25;
    const double _maxHeight = _rowHeight * 5;

    return Container(
      width: double.infinity,
      height: _maxHeight,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          if (group.repeaters == true)
            RichText(
              text: TextSpan(
                  text: 'Type: ',
                  style: styles.Staatliches.xsBlack,
                  children: [
                    TextSpan(text: 'repeaters', style: styles.Lato.xsGray),
                  ]),
            ),
          RichText(
            text: TextSpan(
                text: 'Repetitions: ',
                style: styles.Staatliches.xsBlack,
                children: [
                  TextSpan(
                      text: group.repetitions.toString(),
                      style: styles.Lato.xsGray),
                ]),
          ),
          RichText(
            text: TextSpan(
                text: 'Hang time: ',
                style: styles.Staatliches.xsBlack,
                children: [
                  TextSpan(
                      text: '${group.hangTimeS.toString()}s',
                      style: styles.Lato.xsGray),
                ]),
          ),
          if (group.repeaters == true)
            RichText(
              textAlign: TextAlign.right,
              text: TextSpan(
                  text: 'sets: ',
                  style: styles.Staatliches.xsBlack,
                  children: [
                    TextSpan(
                        text: group.sets.toString(), style: styles.Lato.xsGray),
                  ]),
            ),
          if (group.addedWeight != null && group.addedWeight != 0.0)
            RichText(
              textAlign: TextAlign.right,
              text: TextSpan(
                  text: 'added weight: ',
                  style: styles.Staatliches.xsBlack,
                  children: [
                    TextSpan(
                        text: '${group.addedWeight.toString()} $weightUnit',
                        style: styles.Lato.xsGray),
                  ]),
            ),
        ],
      ),
    );
  }
}

class _EditDeleteDialog extends StatelessWidget {
  _EditDeleteDialog(
      {Key key,
      @required this.title,
      @required this.handleDeleteTap,
      @required this.handleEditTap,
      @required this.handleBackTap})
      : super(key: key);

  final String title;
  final VoidCallback handleEditTap;
  final VoidCallback handleDeleteTap;
  final VoidCallback handleBackTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(title, style: styles.Staatliches.lBlack),
        Divider(height: styles.Measurements.l),
        Button(
            text: 'Edit',
            backgroundColor: styles.Colors.blue,
            displayBackground: true,
            leadingIcon: icons.editIconWhiteXl,
            handleTap: handleEditTap,
            leadingIconTextCentered: true),
        Divider(height: styles.Measurements.m),
        Button(
            text: 'Delete',
            backgroundColor: styles.Colors.primary,
            displayBackground: true,
            leadingIcon: icons.deleteIconWhiteXl,
            handleTap: handleDeleteTap,
            leadingIconTextCentered: true),
        Divider(height: styles.Measurements.l),
        Button(
            displayBackground: false,
            text: 'Back',
            handleTap: handleBackTap,
            small: true)
      ],
    );
  }
}
