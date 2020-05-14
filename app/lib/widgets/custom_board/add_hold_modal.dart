import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/modal_popup.dart';
import 'package:flutter/cupertino.dart';

class AddHoldModal extends StatelessWidget {
  AddHoldModal({
    Key key,
    @required this.open,
    @required this.handleTap,
  }) : super(key: key);

  final bool open;
  final VoidCallback handleTap;

  @override
  Widget build(BuildContext context) {
    return AppModal(
      open: open,
      handleTap: handleTap,
      content: Container(
        width: double.infinity,
        child: Text(
          'add hold',
          style: styles.Staatliches.xlBlack,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
