import 'package:flutter/cupertino.dart' hide Icon;
import 'package:tenso_app/styles/styles.dart' as styles;
import 'package:tenso_app/widgets/icon_button.dart';
import 'package:tenso_app/widgets/icons.dart' as icons;

class ExpandedSection extends StatefulWidget {
  ExpandedSection(
      {Key key, @required this.title, @required this.children, this.handleOpen})
      : super(key: key);

  final String title;
  final List<Widget> children;
  final VoidCallback handleOpen;

  @override
  _ExpandedSectionState createState() => _ExpandedSectionState();
}

class _ExpandedSectionState extends State<ExpandedSection>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0.0, end: 0.5);

  AnimationController _controller;
  Animation<double> _iconTurns;
  Animation<double> _heightFactor;

  bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = false;

    _controller =
        AnimationController(duration: Duration(milliseconds: 100), vsync: this);

    _heightFactor = _controller.drive(_easeInTween);
    _iconTurns = _controller.drive(_halfTween.chain(_easeInTween));
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward().then<void>((_) {
          if (widget.handleOpen != null) widget.handleOpen();
        });
      } else {
        _controller.reverse().then<void>((void value) {
          if (!mounted) return;
          setState(() {
            // Rebuild without widget.children.
          });
        });
      }
    });
  }

  Widget _buildChildren(BuildContext context, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          onTap: _handleTap,
          child: Container(
            decoration: BoxDecoration(color: styles.Colors.translucent),
            child: Row(
              children: [
                Text(
                  widget.title,
                  style: styles.Staatliches.xlBlack,
                ),
                RotationTransition(
                  turns: _iconTurns,
                  child: IconButton(
                      handleTap: _handleTap, icon: icons.downCaretBlackL),
                )
              ],
            ),
          ),
        ),
        ClipRect(
          child: Align(
            alignment: Alignment.topLeft,
            heightFactor: _heightFactor.value,
            child: child,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChildren,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widget.children),
    );
  }
}
