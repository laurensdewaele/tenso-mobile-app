import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/keyboard_screen.dart';

class TextInput extends StatefulWidget {
  TextInput(
      {@required this.initialValue,
      @required this.handleValueChanged,
      @required this.shouldLoseFocusStream,
      @required this.handleErrorMessage,
      @required this.shouldFocus});

  final String initialValue;
  final ValueChanged<String> handleValueChanged;
  final Stream<bool> shouldLoseFocusStream;
  final Function(Widget) handleErrorMessage;
  final bool shouldFocus;

  @override
  _TextInputState createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
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
    if (_textEditingController.text == '' ||
        _textEditingController.text == null) {
      _validationError();
    }
    _focusNode.unfocus();
    final KeyboardScreenCallbackProvider keyboardScreenCallbacks =
        KeyBoardScreen.of(context);
    keyboardScreenCallbacks.resetKeyboardOffset();
  }

  void _validationError() {
    _textEditingController.text = widget.initialValue.toString();
    widget.handleErrorMessage(
      Text('Name must be filled in.', style: styles.Typography.textInfo),
    );
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
      width: double.infinity,
      child: Listener(
        onPointerDown: _onPointerDown,
        child: CupertinoTextField(
          autofocus: widget.shouldFocus,
          autocorrect: false,
          controller: _textEditingController,
          cursorColor: styles.Colors.black,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: styles.Colors.primary, width: 3),
            ),
          ),
          focusNode: _focusNode,
          keyboardType: TextInputType.text,
//          maxLength: 100,
          onTap: _onTap,
          onEditingComplete: _validateInput,
          onSubmitted: (String text) => {_validateInput},
          style: styles.Typography.text,
          textAlign: TextAlign.start,
        ),
      ),
    );
  }
}
