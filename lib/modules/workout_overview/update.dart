import 'package:flutter/cupertino.dart';
import 'package:tenso_app/data/versioning.data.dart';
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/modules/common/divider.dart';
import 'package:tenso_app/modules/common/icons.dart';
import 'package:tenso_app/modules/common/ok_button.dart';
import 'package:tenso_app/state/versioning.state.dart';
import 'package:tenso_app/styles/styles.dart' as styles;

class Update extends StatelessWidget {
  Update({Key key, this.setDisplayChangelogFalse}) : super(key: key);

  final VoidCallback setDisplayChangelogFalse;

  @override
  Widget build(BuildContext context) {
    final Version _persistedVersion = VersioningState().persistedVersion;
    final List<Version> _versionsInBetween = latestVersioning.versions
        .where((Version version) =>
            version.incrementalNo > _persistedVersion.incrementalNo)
        .toList();
    final List<String> changelogs = _versionsInBetween
        .map((Version version) => version.changelog)
        .expand((changelog) => changelog)
        .toList();

    return WillPopScope(
      onWillPop: () async {
        setDisplayChangelogFalse();
        return true;
      },
      child: ListView(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        children: [
          Column(
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
                ...changelogs.map((String changelog) => Column(
                      children: [
                        Row(
                          children: [
                            dotBlackS,
                            Divider(
                              width: styles.Measurements.s,
                            ),
                            Flexible(
                              child: Text(
                                changelog,
                                style: styles.Lato.xsBlack,
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          height: styles.Measurements.s,
                        )
                      ],
                    )),
                Divider(height: styles.Measurements.s),
                OKButton(handleTap: () {
                  setDisplayChangelogFalse();
                  Navigator.of(context).pop();
                }),
              ])
        ],
      ),
    );
  }
}
