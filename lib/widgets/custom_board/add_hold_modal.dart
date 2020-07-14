import 'package:flutter/cupertino.dart';
import 'package:tenso_app/styles/styles.dart' as styles;
import 'package:tenso_app/widgets/modal_popup.dart';

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
      content: GestureDetector(
        onTap: handleTap,
        child: Container(
          width: double.infinity,
          child: Text(
            'add hold',
            style: styles.Staatliches.xlBlack,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
