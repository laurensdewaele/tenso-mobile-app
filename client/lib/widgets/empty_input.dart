import 'dart:async';

import 'package:app/services/keyboard.service.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:flutter/cupertino.dart';

// For inputs without an initial value
class EmptyInput extends StatefulWidget {
  EmptyInput({
    @required this.handleValueChanged,
    this.primaryColor = styles.Colors.primary,
  });

  final ValueChanged<String> handleValueChanged;
  final Color primaryColor;

  @override
  _EmptyInputState createState() => _EmptyInputState();
}

class _EmptyInputState extends State<EmptyInput> {
  final _textEditingController = TextEditingController();
  final _focusNode = FocusNode();

  StreamSubscription _sub;
  KeyboardService _keyboardService;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus != true) {
        _onComplete();
      } else {
        _textEditingController.clear();
      }
    });
    _keyboardService = KeyboardService();

    _sub = _keyboardService.shouldLoseFocus$.listen((_) {
      _onComplete();
    });
  }

  @override
  void dispose() {
    _sub.cancel();
    _textEditingController.dispose();
    super.dispose();
  }

  void _onComplete() {
    _focusNode.unfocus();
    _keyboardService.resetKeyboardOffset();
  }

  void _onTap() {
    _textEditingController.clear();
    widget.handleValueChanged('');
  }

  void _onPointerDown(PointerEvent event) {
    _keyboardService.handlePointerDown(event.position);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: styles.Measurements.xxl,
      child: Listener(
        onPointerDown: _onPointerDown,
        child: CupertinoTextField(
          onChanged: widget.handleValueChanged,
          autofocus: false,
          autocorrect: false,
          controller: _textEditingController,
          cursorColor: styles.Colors.white,
          decoration: BoxDecoration(
              color: widget.primaryColor,
              borderRadius: styles.kBorderRadiusAll),
          focusNode: _focusNode,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          maxLength: 6,
          onTap: _onTap,
          onEditingComplete: _onComplete,
          onSubmitted: (String text) => {_onComplete()},
          style: styles.Staatliches.sWhite,
          textAlign: TextAlign.center,
          enabled: true,
        ),
      ),
    );
  }
}
