import 'package:app/styles/styles.dart' as styles;
import 'package:flutter/cupertino.dart';

class SlidingExpansionCard extends StatefulWidget {
  const SlidingExpansionCard({
    Key key,
    @required this.topLeftSection,
    @required this.topRightSection,
    @required this.topRightSectionWidth,
    @required this.content,
    @required this.handleTap,
    @required this.handleLongPress,
  });

  final Widget topLeftSection;
  final Widget topRightSection;
  final double topRightSectionWidth;
  final Widget content;
  final VoidCallback handleTap;
  final VoidCallback handleLongPress;

  @override
  _SlidingExpansionCardState createState() => _SlidingExpansionCardState();
}

class _SlidingExpansionCardState extends State<SlidingExpansionCard>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  Animatable<double> _easeInOutTween;
  Animatable<double> _topLeftSectionAlignmentTween;
  // Moves the label off screen to the right.
  // It is being clipped, therefore invisible.
  Animatable<double> _topRightSectionAlignmentTween;
  Animatable<double> _topRightSectionWidthTween;

  AnimationController _controller;
  Animation<double> _heightFactor;
  Animation<double> _topLeftSectionAlignment;
  Animation<double> _topRightSectionAlignment;
  Animation<double> _topRightSectionWidthAnimation;

  bool _isExpanded = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _easeInOutTween = CurveTween(curve: Curves.easeInOut);
    _controller =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    _heightFactor = _controller.drive(_easeInOutTween);

    _topLeftSectionAlignmentTween = Tween(begin: -1, end: 0);
    _topLeftSectionAlignment =
        _controller.drive(_topLeftSectionAlignmentTween.chain(_easeInOutTween));

    _topRightSectionAlignmentTween =
        Tween(begin: 0, end: -widget.topRightSectionWidth - 1);
    _topRightSectionWidthTween =
        Tween(begin: widget.topRightSectionWidth, end: 0);
    _topRightSectionAlignment = _controller
        .drive(_topRightSectionAlignmentTween.chain(_easeInOutTween));
    _topRightSectionWidthAnimation =
        _controller.drive(_topRightSectionWidthTween.chain(_easeInOutTween));

    _isExpanded = PageStorage.of(context)?.readState(context) ?? false;
    if (_isExpanded) _controller.value = 1.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() async {
    widget.handleTap();

    setState(() {
      _isExpanded = !_isExpanded;
    });

    if (_isExpanded) {
      try {
        await _controller.forward().orCancel;
      } catch (_) {}
    } else {
      try {
        await _controller.reverse().orCancel;
      } catch (_) {}
      if (!mounted) return;
      setState(() {
        // Rebuild without widget.children.
      });
    }
    PageStorage.of(context)?.writeState(context, _isExpanded);
  }

  Widget _buildChildren(BuildContext context, Widget child) {
    return GestureDetector(
        onTap: _handleTap,
        child: Container(
            padding: EdgeInsets.all(styles.Measurements.s),
            decoration: BoxDecoration(
              borderRadius: styles.kBorderRadiusAll,
              color: styles.Colors.bgWhite,
            ),
            child: Column(
              children: <Widget>[
                Stack(overflow: Overflow.clip, children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Align(
                            alignment:
                                Alignment(_topLeftSectionAlignment.value, 0),
                            child: widget.topLeftSection),
                      ),
                      SizedBox(
                        width: _topRightSectionWidthAnimation.value,
                      ),
                    ],
                  ),
                  Positioned(
                      right: _topRightSectionAlignment.value,
                      child: widget.topRightSection)
                ]),
                ClipRect(
                    child:
                        Align(heightFactor: _heightFactor.value, child: child))
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return AnimatedBuilder(
        animation: _controller.view,
        builder: _buildChildren,
        child: widget.content);
  }
}
