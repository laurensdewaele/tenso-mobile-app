import 'package:flutter/cupertino.dart';
import 'package:tenso_app/modules/common/card.dart';
import 'package:tenso_app/modules/common/divider.dart';
import 'package:tenso_app/modules/toast/toast_message.dart';
import 'package:tenso_app/services/toast.service.dart';
import 'package:tenso_app/styles/styles.dart' as styles;
import 'package:url_launcher/url_launcher.dart';

const int flexFirstColumn = 10;
const int flexSecondColumn = 19;

class ProtocolCard extends StatelessWidget {
  ProtocolCard(
      {@required this.iconImageAsset,
      @required this.iconBackground,
      @required this.title,
      @required this.function,
      @required this.gain,
      @required this.volume,
      @required this.requirements,
      @required this.popularizedBy,
      @required this.hangTime,
      @required this.description,
      this.moreInfo,
      this.moreInfoLink});

  final String iconImageAsset;
  final Color iconBackground;
  final String title;
  final String function;
  final String gain;
  final String volume;
  final String requirements;
  final String popularizedBy;
  final String hangTime;
  final String description;
  final String moreInfo;
  final String moreInfoLink;

  Future<void> _launch(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
    } else {
      ToastService().add(ToastMessages.failedBrowserLaunch());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      padding: const EdgeInsets.all(styles.Measurements.m),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: styles.Measurements.xxl,
              height: styles.Measurements.xxl,
              decoration: BoxDecoration(
                  color: iconBackground, borderRadius: styles.kBorderRadiusAll),
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.all(5),
                child: Image.asset(iconImageAsset),
              )),
            ),
          ),
          Divider(
            height: styles.Measurements.m,
          ),
          Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: styles.Staatliches.lBlack,
            ),
          ),
          Divider(
            height: styles.Measurements.l,
          ),
          _Row(
            title: 'Function',
            content: function,
          ),
          Divider(
            height: styles.Measurements.xs,
          ),
          _Row(
            title: 'Gain',
            content: gain,
          ),
          Divider(
            height: styles.Measurements.xs,
          ),
          _Row(
            title: 'Volume',
            content: volume,
          ),
          Divider(
            height: styles.Measurements.xs,
          ),
          _Row(
            title: 'Requirements',
            content: requirements,
          ),
          Divider(
            height: styles.Measurements.xs,
          ),
          _Row(
            title: 'Popularized by',
            content: popularizedBy,
          ),
          Divider(
            height: styles.Measurements.xs,
          ),
          _Row(
            title: 'Hang time',
            content: hangTime,
          ),
          Divider(
            height: styles.Measurements.xs,
          ),
          _Row(
            title: 'Description',
            content: description,
          ),
          Divider(
            height: styles.Measurements.xs,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: flexFirstColumn,
                child: Text(
                  'More info',
                  style: styles.Staatliches.sBlack,
                ),
              ),
              Expanded(
                flex: flexSecondColumn,
                child: GestureDetector(
                  onTap: () async {
                    await _launch(moreInfoLink);
                  },
                  child: Text(
                    moreInfo,
                    style: styles.Lato.protocolDescriptionBlue,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  _Row({@required this.title, @required this.content});

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: flexFirstColumn,
          child: Text(
            title,
            style: styles.Staatliches.sBlack,
          ),
        ),
        Expanded(
          flex: flexSecondColumn,
          child: Text(
            content,
            style: styles.Lato.protocolDescriptionBlack,
          ),
        )
      ],
    );
  }
}
