import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:tenso_app/services/keyboard.service.dart';
import 'package:tenso_app/styles/styles.dart' as styles;

// Do not forget to specify <T>
// The Widget builder depends on it
class NumberInput<T> extends StatefulWidget {
  NumberInput(
      {@required this.handleValueChanged,
      this.primaryColor = styles.Colors.primary,
      this.initialValue,
      this.enabled = true});

  final ValueChanged<String> handleValueChanged;
  final Color primaryColor;
  final T initialValue;
  final bool enabled;

  @override
  _NumberInputState createState() => _NumberInputState();
}

class _NumberInputState extends State<NumberInput> {
  final _textEditingController = TextEditingController();
  final _focusNode = FocusNode();

  StreamSubscription _shouldLoseFocusSub;
  StreamSubscription _resetInitialValueSub;
  KeyboardService _keyboardService;

  @override
  void initState() {
    super.initState();
    _textEditingController.text = widget.initialValue.toString();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus == true) {
        _textEditingController.clear();
      }
    });
    _keyboardService = KeyboardService();
    _shouldLoseFocusSub = _keyboardService.shouldLoseFocus$.listen((_) {
      _focusNode.unfocus();
    });
    _resetInitialValueSub = _keyboardService.resetInitialValue$.listen((_) {
      _textEditingController.text = widget.initialValue;
    });
  }

  @override
  void dispose() {
    _shouldLoseFocusSub.cancel();
    _resetInitialValueSub.cancel();
    _textEditingController.dispose();
    super.dispose();
  }

  void _onComplete() {
    _focusNode.unfocus();
    _keyboardService.handleInputComplete();
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
    final bool _isDouble =
        widget.initialValue.runtimeType == double ? true : false;
    return Container(
      width: _isDouble ? styles.Measurements.xxl : styles.Measurements.xl,
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
          keyboardType: _isDouble
              ? TextInputType.numberWithOptions(decimal: true)
              : TextInputType.number,
          maxLength: _isDouble ? 6 : 3,
          onTap: _onTap,
          onEditingComplete: _onComplete,
          onSubmitted: (String text) => {_onComplete()},
          style: styles.Staatliches.sWhite,
          textAlign: TextAlign.center,
          enabled: widget.enabled,
        ),
      ),
    );
  }
}
