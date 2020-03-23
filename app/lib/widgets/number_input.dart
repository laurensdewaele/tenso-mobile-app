import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';

import 'package:app/services/keyboard.dart';
import 'package:app/services/toast.dart';
import 'package:app/styles/styles.dart' as styles;

class NumberInput extends StatefulWidget {
  NumberInput({
    this.initialIntValue,
    this.initialDoubleValue,
    this.shouldFocus = false,
    this.enabled = true,
    this.handleDoubleValueChanged,
    this.handleIntValueChanged,
    this.primaryColor = styles.Colors.primary,
  });

  final bool enabled;
  final ValueChanged<int> handleIntValueChanged;
  final ValueChanged<double> handleDoubleValueChanged;
  final int initialIntValue;
  final double initialDoubleValue;
  final Color primaryColor;
  final bool shouldFocus;

  @override
  _NumberInputState createState() => _NumberInputState();
}

class _NumberInputState extends State<NumberInput> {
  final _textEditingController = TextEditingController();
  final _focusNode = FocusNode();

  String _initialValue;
  bool _isDouble;

  StreamSubscription _subscription;
  KeyboardService _keyboardService;
  ToastService _toastService;

  @override
  void initState() {
    super.initState();
    _isDouble = widget.initialDoubleValue != null;
    _initialValue = widget.initialDoubleValue?.toString() ??
        widget.initialIntValue?.toString();
    _textEditingController.text = _initialValue;
    _focusNode.addListener(() {
      if (_focusNode.hasFocus != true) {
        _onComplete();
      } else {
        _textEditingController.clear();
      }
    });

    _keyboardService = Provider.of<KeyboardService>(context, listen: false);
    _subscription = _keyboardService.shouldLoseFocusStream.listen((_) {
      _onComplete();
    });

    _toastService = Provider.of<ToastService>(context, listen: false);
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  void _onChanged(String s) {
    if (s.trim() == '' || s == null) {
      _emptyError();
      return;
    }

    dynamic value;
    try {
      value = _isDouble ? double.parse(s.trim()) : int.parse(s.trim());
    } on FormatException catch (_) {
      _validationError();
      return;
    }

    _isDouble
        ? widget.handleDoubleValueChanged(value)
        : widget.handleIntValueChanged(value);
  }

  void _emptyError() {
    final Widget errorMessage = RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'The input can ',
          style: styles.Lato.sBlack,
          children: [
            TextSpan(text: 'not be empty.', style: styles.Lato.sBlackBold),
          ]),
    );
    _toastService.add(errorMessage);
  }

  void _validationError() {
    final Widget errorMessage = RichText(
      textAlign: TextAlign.center,
      text:
          TextSpan(text: 'The input is ', style: styles.Lato.sBlack, children: [
        TextSpan(text: 'not a number.', style: styles.Lato.sBlackBold),
      ]),
    );
    _toastService.add(errorMessage);
  }

  void _onComplete() {
    _focusNode.unfocus();
    _keyboardService.resetKeyboardOffset();
  }

  void _onTap() {
    _textEditingController.clear();
  }

  void _onPointerDown(PointerEvent event) {
    _keyboardService.handlePointerDown(event.position);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _isDouble ? styles.Measurements.xxl : styles.Measurements.xl,
      child: Listener(
        onPointerDown: _onPointerDown,
        child: CupertinoTextField(
          autofocus: widget.shouldFocus,
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
          maxLength: _isDouble ? 4 : 3,
          onChanged: _onChanged,
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
