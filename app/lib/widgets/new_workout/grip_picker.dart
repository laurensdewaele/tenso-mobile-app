import 'package:flutter/cupertino.dart';

import 'package:app/models/grips.dart';
import 'package:app/models/hand_hold.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/grip_image.dart';
import 'package:app/widgets/radio_button.dart';

final double _kGripPickerHeight = 100;
final double _kGripWidth = 80;
final GlobalKey _kGripPickerContainerKey = GlobalKey();

class GripPicker extends StatefulWidget {
  GripPicker(
      {Key key,
      @required this.grips,
      @required this.handleGripChanged,
      @required this.initialGrip,
      @required this.initialHandHold,
      @required this.handleHandHoldChanged,
      @required this.oneHanded})
      : super(key: key);

  final List<Grip> grips;
  final Grip initialGrip;
  final Function(Grip grip) handleGripChanged;
  final HandHolds initialHandHold;
  final bool oneHanded;
  final Function(HandHolds handHold) handleHandHoldChanged;

  @override
  _GripPickerState createState() => _GripPickerState();
}

class _GripPickerState extends State<GripPicker> {
  Grip _selectedGrip;
  HandHolds _selectedHandHold;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _selectedGrip = widget.initialGrip;
    _selectedHandHold = widget.initialHandHold;
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _afterLayout(Duration timeStamp) {
    _scrollToSelected();
  }

  void _scrollToSelected() {
    final RenderBox container =
        _kGripPickerContainerKey.currentContext.findRenderObject();
    final Size size = container.size;
    final double center = size.width / 2;
    final int index = widget.grips.indexOf(_selectedGrip);
    final double totalWidth = _kGripWidth * widget.grips.length;

    if (index * _kGripWidth < center) {
      _scrollController.animateTo(0,
          duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
    }
    if (index * _kGripWidth > totalWidth - center) {
      _scrollController.animateTo(totalWidth,
          duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
    }
    _scrollController.animateTo(
        index * _kGripWidth + (_kGripWidth / 2) - center,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut);
  }

  void _handleGripSelected(Grip grip) {
    widget.handleGripChanged(grip);
    setState(() {
      _selectedGrip = grip;
    });
    _scrollToSelected();
  }

  void _handleHandHoldChanged(HandHolds handHold) {
    widget.handleHandHoldChanged(handHold);
    setState(() {
      _selectedHandHold = handHold;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          _selectedGrip.description,
          style: styles.Typography.textInfoBold,
          textAlign: TextAlign.center,
        ),
        Divider(height: styles.Measurements.m),
        Container(
          width: double.infinity,
          height: _kGripPickerHeight,
          key: _kGripPickerContainerKey,
          child: ListView(
            physics: ClampingScrollPhysics(),
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              ...widget.grips.map((Grip grip) => _Grip(
                  grip: grip,
                  handleGripSelected: _handleGripSelected,
                  selected: _selectedGrip == grip,
                  handHold: _selectedHandHold)),
            ],
          ),
        ),
        Divider(height: styles.Measurements.m),
        _HandHoldsRadioGroup(
          initialHandHold: widget.initialHandHold,
          handleHandHoldChanged: _handleHandHoldChanged,
        )
      ],
    );
  }
}

class _HandHoldsRadioGroup extends StatefulWidget {
  _HandHoldsRadioGroup({this.initialHandHold, this.handleHandHoldChanged});

  final HandHolds initialHandHold;
  final Function(HandHolds handHold) handleHandHoldChanged;

  @override
  __HandHoldsRadioGroupState createState() => __HandHoldsRadioGroupState();
}

class __HandHoldsRadioGroupState extends State<_HandHoldsRadioGroup> {
  HandHolds _selectedHandHold;

  @override
  void initState() {
    super.initState();
    _selectedHandHold = widget.initialHandHold;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleSelectedHandHold(HandHolds handHold) {
    widget.handleHandHoldChanged(handHold);
    setState(() {
      _selectedHandHold = handHold;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      RadioButton(
        description: 'Two handed',
        value: HandHolds.twoHanded,
        active: _selectedHandHold == HandHolds.twoHanded,
        handleSelected: _handleSelectedHandHold,
      ),
      RadioButton(
        description: 'One handed right',
        value: HandHolds.oneHandedRight,
        active: _selectedHandHold == HandHolds.oneHandedRight,
        handleSelected: _handleSelectedHandHold,
      ),
      RadioButton(
        description: 'One handed left',
        value: HandHolds.oneHandedLeft,
        active: _selectedHandHold == HandHolds.oneHandedLeft,
        handleSelected: _handleSelectedHandHold,
      ),
    ]);
  }
}

class _Grip extends StatelessWidget {
  _Grip(
      {Key key,
      @required this.grip,
      @required this.handleGripSelected,
      @required this.selected,
      @required this.handHold})
      : super(key: key);

  final Grip grip;
  final Function(Grip grip) handleGripSelected;
  final bool selected;
  final HandHolds handHold;

  void _handleTap() {
    handleGripSelected(grip);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: _handleTap,
        child: Container(
          width: _kGripWidth,
          child: selected
              ? GripImage(
                  handHold: handHold,
                  imageWidth: _kGripWidth,
                  assetSrc: grip.assetSrc,
                  selected: selected)
              : Transform.scale(
                  scale: .8,
                  child: GripImage(
                    handHold: handHold,
                    imageWidth: _kGripWidth,
                    assetSrc: grip.assetSrc,
                    selected: selected,
                  ),
                ),
        ));
  }
}
