import 'package:flutter/cupertino.dart';
import 'package:tenso_app/data/versioning.data.dart';
import 'package:tenso_app/modules/common/card.dart';
import 'package:tenso_app/modules/common/divider.dart';
import 'package:tenso_app/modules/common/expanded_section.dart';
import 'package:tenso_app/modules/common/screen.dart';
import 'package:tenso_app/modules/common/section_forward_nav.dart';
import 'package:tenso_app/modules/common/top_navigation.dart';
import 'package:tenso_app/modules/toast/toast_message.dart';
import 'package:tenso_app/modules/toast/toast_provider.dart';
import 'package:tenso_app/routes/routes.dart';
import 'package:tenso_app/services/toast.service.dart';
import 'package:tenso_app/styles/styles.dart' as styles;
import 'package:url_launcher/url_launcher.dart';

const Map<String, String> _links = {
  'warm up video': 'https://www.youtube.com/watch?v=jpWugfr-seA',
  'proper form video': 'https://www.youtube.com/watch?v=_deu23LD_RY',
  'dave mcleod hangboard for beginners':
      'https://www.youtube.com/watch?v=Z5HZTN4MR-o',
  'dave mcleod how to hangboard': 'https://www.youtube.com/watch?v=VeKE5VH5-qg',
  'podcast':
      "https://www.powercompanyclimbing.com/blog/2019/1/10/episode-118-the-best-hangboard-protocol-with-eva-lopez",
  'reddit':
      "https://www.reddit.com/r/climbharder/wiki/index#wiki_articles_-_fingerboarding"
};

class InfoScreen extends StatelessWidget {
  InfoScreen({Key key}) : super(key: key);

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
    return ToastProvider(
      child: Screen(
        handleBackNavigation: () {
          Navigator.of(context).pop();
        },
        child: ListView(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          children: <Widget>[
            TopNavigation(
              handleBackNavigation: () {
                Navigator.of(context).pop();
              },
              title: 'Info',
            ),
            Divider(height: styles.Measurements.xxl),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: styles.Measurements.xs),
              child: Card(
                padding: const EdgeInsets.only(
                  left: styles.Measurements.m,
                  right: styles.Measurements.m,
                  top: 4,
                  bottom: styles.Measurements.l,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Divider(
                      height: styles.Measurements.xs,
                    ),
                    ExpandedSection(
                      title: 'About',
                      children: <Widget>[
                        Text(
                          'This app was built as a tool to help you progress your finger strength. Finger strength progression requires a lot of time. Therefore, logging your practice and being able to visualize your progression is invaluable.',
                          style: styles.Lato.xsBlack,
                        ),
                        Text(
                          '\nThe app is built for allowing you to enter any kind of workout variable. Be it specific mixed grips, custom edge sizes, body weight, you name it. We\'ll do our best so you can log everything your heart desires.',
                          style: styles.Lato.xsBlack,
                        ),
                        Text(
                          '\nThis app will not provide you with a myriad of different workouts or protocols, only the most basic ones to get you started. A workout has to be tailored to the individual, and it\'s impossible for us to know all the variables it takes to design a balanced workout for that specific individual. Be it age, climbing age, sleep, stress, weight, the list goes on... Therefore, the best way forward is to help us get the individual started by themselves.',
                          style: styles.Lato.xsBlack,
                        ),
                      ],
                    ),
                    ExpandedSection(
                      title: 'New to hangboarding',
                      children: <Widget>[
                        Text(
                          'As mentioned in the previous section, if you\'re new, we believe the best way forward for you is to simply start hanging, not by looking for the perfect workout plan. The perfect plan doesn\'t exist. It\'s never going to be tailored specifically for you. You need to have a workout that you\'re comfortable with and that is not too hard and not too easy. Only you can know! No one else!',
                          style: styles.Lato.xsBlack,
                        ),
                        Text(
                          '\nIf you\'re new, the best way is the easiest way and you\'re lucky, because no matter what kind of training you do, you\'ll improve anyway!',
                          style: styles.Lato.xsBlack,
                        ),
                        Text(
                          '\nTrust yourself and jump right in. We recommend you begin with the density hang workout. Simply hang on for as long as you can. Remember to warm up properly and hang with proper form. See the link section for a video on warming up and applying proper form. After a hang, rest for as long as it takes to reproduce the same max effort (usually 3 - 5min). On a rest phase, you can tap to pause, and log the amount of time you were able to hang on.',
                          style: styles.Lato.xsBlack,
                        ),
                        Text(
                          '\nFor your next workout on a later date, look back at your previous workout to see what you were able to hang, and edit the workout accordingly.',
                          style: styles.Lato.xsBlack,
                        ),
                        Text(
                          '\nIf you can easily hang on for 30 seconds on a specific grip and hold type, try a smaller edge.',
                          style: styles.Lato.xsBlack,
                        ),
                        Text(
                          '\nThat\'s all there is to know for now. A little bit goes a long way. Ease into the training. Start by doing it once a week. Remember that finger strength adaptations require a lot of time, so you\'ll have to cultivate some patience. Don\'t rush things, or risk getting injured. You\'re in it for the long haul here.',
                          style: styles.Lato.xsBlack,
                        ),
                        Text(
                          '\nIf you notice you\'re starting to plateau and you\'ve been doing a protocol for at least 6 weeks, try a different one.',
                          style: styles.Lato.xsBlack,
                        ),
                      ],
                    ),
                    SectionForwardNav(
                        title: 'Protocols',
                        handleNavigation: () {
                          Navigator.of(context)
                              .pushNamed(Routes.protocolsScreen);
                        }),
                    ExpandedSection(
                      title: 'Useful links',
                      children: <Widget>[
                        Text(
                          'Warm up video',
                          style: styles.Staatliches.mBlack,
                        ),
                        GestureDetector(
                          onTap: () async {
                            await _launch(_links['warm up video']);
                          },
                          child: Text(
                            _links['warm up video'],
                            style: styles.Lato.xsBlue,
                          ),
                        ),
                        Text(
                          '\nProper form video',
                          style: styles.Staatliches.mBlack,
                        ),
                        GestureDetector(
                          onTap: () async {
                            await _launch(_links['proper form video']);
                          },
                          child: Text(
                            _links['proper form video'],
                            style: styles.Lato.xsBlue,
                          ),
                        ),
                        Text(
                          '\nDave McLeod hangboard for beginners',
                          style: styles.Staatliches.mBlack,
                        ),
                        GestureDetector(
                          onTap: () async {
                            await _launch(
                                _links['dave mcleod hangboard for beginners']);
                          },
                          child: Text(
                            _links['dave mcleod hangboard for beginners'],
                            style: styles.Lato.xsBlue,
                          ),
                        ),
                        Text(
                          '\nDave McLeod how to hangboard',
                          style: styles.Staatliches.mBlack,
                        ),
                        GestureDetector(
                          onTap: () async {
                            await _launch(
                                _links['dave mcleod how to hangboard']);
                          },
                          child: Text(
                            _links['dave mcleod how to hangboard'],
                            style: styles.Lato.xsBlue,
                          ),
                        ),
                        Text(
                          '\nPodcast with Eva Lopez',
                          style: styles.Staatliches.mBlack,
                        ),
                        GestureDetector(
                          onTap: () async {
                            await _launch(_links['podcast']);
                          },
                          child: Text(
                            _links['podcast'],
                            style: styles.Lato.xsBlue,
                          ),
                        ),
                        Text(
                          '\nReddit climbharder wiki',
                          style: styles.Staatliches.mBlack,
                        ),
                        GestureDetector(
                          onTap: () async {
                            await _launch(_links['reddit']);
                          },
                          child: Text(
                            _links['reddit'],
                            style: styles.Lato.xsBlue,
                          ),
                        ),
                      ],
                    ),
                    ExpandedSection(
                      title: 'Version',
                      children: <Widget>[
                        Row(
                          children: [
                            Text(
                              latestVersion.no,
                              textAlign: TextAlign.start,
                              style: styles.Lato.xsBlack,
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Divider(height: styles.Measurements.xxl)
          ],
        ),
      ),
    );
  }
}
