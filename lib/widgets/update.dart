import 'package:flutter/cupertino.dart';
import 'package:tenso_app/data/versioning.data.dart';
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/styles/styles.dart' as styles;
import 'package:tenso_app/widgets/button.dart';
import 'package:tenso_app/widgets/divider.dart';

class Update extends StatelessWidget {
  Update({Key key, this.setDisplayChangelogFalse}) : super(key: key);

  final VoidCallback setDisplayChangelogFalse;

  @override
  Widget build(BuildContext context) {
    final Version _latestVersion = latestVersioning.versions[0];
    return WillPopScope(
      onWillPop: () async {
        setDisplayChangelogFalse();
        return true;
      },
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text(
                'update',
                style: styles.Staatliches.xlBlack,
              ),
            ),
            Divider(height: styles.Measurements.l),
            Text(
              _latestVersion.changelog,
              textAlign: TextAlign.center,
              style: styles.Lato.xsBlack,
            ),
            Divider(height: styles.Measurements.l),
            Button(
                small: true,
                displayBackground: false,
                text: 'Ok',
                handleTap: () {
                  setDisplayChangelogFalse();
                  Navigator.of(context).pop();
                })
          ]),
    );
  }
}
