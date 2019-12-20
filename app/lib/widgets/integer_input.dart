import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/keyboard_screen.dart';

class IntegerInput extends StatefulWidget {
  IntegerInput(
      {@required this.initialValue,
      @required this.handleValueChanged,
      @required this.shouldLoseFocusStream,
      @required this.handleErrorMessage,
      @required this.shouldFocus});

  final int initialValue;
  final ValueChanged<int> handleValueChanged;
  final Stream<bool> shouldLoseFocusStream;
  final Function(Widget) handleErrorMessage;
  final bool shouldFocus;

  @override
  _IntegerInputState createState() => _IntegerInputState();
}

class _IntegerInputState extends State<IntegerInput> {
  final _textEditingController = TextEditingController();
  final _focusNode = FocusNode();
  StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    _textEditingController.text = widget.initialValue.toString();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus != true) {
        _validateInput();
      }
    });
    _subscription = widget.shouldLoseFocusStream.listen((shouldLoseFocus) {
      _validateInput();
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  void _validateInput() {
    int value;
    try {
      value = int.parse(_textEditingController.text);
    } on FormatException catch (_) {
      _validationError();
    }

    if (value != null && value < 1) {
      _validationError();
    }

    if (value != null && value >= 1) {
      widget.handleValueChanged(value);
    }

    _focusNode.unfocus();
    final KeyboardScreenCallbackProvider keyboardScreenCallbacks =
        KeyBoardScreen.of(context);
    keyboardScreenCallbacks.resetKeyboardOffset();
  }

  void _validationError() {
    _textEditingController.text = widget.initialValue.toString();
    widget.handleErrorMessage(RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Please input a value ',
          style: styles.Typography.textInfo,
          children: [
            TextSpan(
                text: 'bigger than 0.', style: styles.Typography.textInfoBold),
          ]),
    ));
  }

  void _onTap() {
    _textEditingController.clear();
  }

  void _onPointerDown(PointerEvent event) {
    final KeyboardScreenCallbackProvider keyboardScreenCallbacks =
        KeyBoardScreen.of(context);
    keyboardScreenCallbacks.handlePointerDown(event.position);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: styles.Measurements.xl,
      child: Listener(
        onPointerDown: _onPointerDown,
        child: CupertinoTextField(
          autofocus: widget.shouldFocus,
          autocorrect: false,
          controller: _textEditingController,
          cursorColor: styles.Colors.white,
          decoration: BoxDecoration(
              color: styles.Colors.primary,
              borderRadius: styles.kBorderRadiusAll),
          focusNode: _focusNode,
          keyboardType: TextInputType.number,
          maxLength: 3,
          onTap: _onTap,
          onEditingComplete: _validateInput,
          onSubmitted: (String text) => {_validateInput},
          style: styles.Typography.inputDescriptionSquare,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
