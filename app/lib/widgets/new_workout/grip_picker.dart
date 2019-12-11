import 'package:app/widgets/divider.dart';
import 'package:flutter/cupertino.dart';

import 'package:app/models/grips.dart';
import 'package:app/styles/styles.dart' as styles;

final double _kGripPickerHeight = 100;
final double _kGripWidth = 80;
final GlobalKey _kGripPickerContainerKey = GlobalKey();

class GripPicker extends StatefulWidget {
  GripPicker(
      {Key key,
      @required this.grips,
      @required this.handleGripChanged,
      @required this.initialGrip})
      : super(key: key);

  final List<Grip> grips;
  final Grip initialGrip;
  final Function(Grip grip) handleGripChanged;

  @override
  _GripPickerState createState() => _GripPickerState();
}

class _GripPickerState extends State<GripPicker> {
  Grip _selected;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _selected = widget.initialGrip;
    WidgetsBinding.instance.addPostFrameCallback(_afterInitialRender);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _afterInitialRender(Duration timeStamp) {
    _scrollToSelected();
  }

  void _scrollToSelected() {
    print('scrolling to selected');
    print(_selected.name);
    final RenderBox container =
        _kGripPickerContainerKey.currentContext.findRenderObject();
    final Size size = container.size;
    final double center = size.width / 2;
    final int index = widget.grips.indexOf(_selected);
    final double totalWidth = _kGripWidth * widget.grips.length;
    print(index);

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
    setState(() {
      _selected = grip;
    });
    _scrollToSelected();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          _selected.description,
          style: styles.Typography.text,
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
                  selected: _selected == grip)),
            ],
          ),
        ),
      ],
    );
  }
}

class _Grip extends StatelessWidget {
  _Grip({
    Key key,
    this.grip,
    this.handleGripSelected,
    this.selected,
  }) : super(key: key);

  final Grip grip;
  final Function(Grip grip) handleGripSelected;
  final bool selected;

  void _handleTap() {
    handleGripSelected(grip);
  }

  @override
  Widget build(BuildContext context) {
    final Widget image = Image.asset(
      grip.assetSrc,
      color: selected ? styles.Colors.black : styles.Colors.lightGray,
    );

    return GestureDetector(
        onTap: _handleTap,
        child: Container(
          width: _kGripWidth,
          child: selected
              ? image
              : Transform.scale(
                  scale: .8,
                  child: image,
                ),
        ));
  }
}
