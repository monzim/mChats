import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mChats/services/auth.dart';
import 'package:mChats/views/signin.dart';
import 'package:mChats/widget/bezierContainer.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Widget _entryField(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _createAccountLabel() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Read Privacy Policy  ',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
              // width: 8,
              ),
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      buildAboutDialogSignIn(context));
            },
            child: Text(
              'here',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }

// title here
  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'M',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 35,
            fontWeight: FontWeight.w700,
            color: Color(0xffe46b10),
          ),
          children: [
            TextSpan(
              text: 'Ch',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'ats',
              style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
            ),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: HexColor("#F2F2F2"),
        body: Container(
          height: height,
          child: Stack(
            children: <Widget>[
              Positioned(
                  top: -height * .15,
                  right: -MediaQuery.of(context).size.width * .2,
                  child: BezierContainerFour()),
              Positioned(
                  top: -height * .15,
                  right: -MediaQuery.of(context).size.width * .4,
                  child: BezierContainer()),
              Positioned(
                  bottom: -height * .15,
                  right: -MediaQuery.of(context).size.width * .4,
                  child: BezierContainerThree()),
              Positioned(
                  bottom: -height * .15,
                  left: -MediaQuery.of(context).size.width * .4,
                  child: BezierContainerTwo()),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: height * .38),
                      _title(),
                      // SizedBox(height: 150),
                      SizedBox(height: 23),
                      // _googleButton(),
                      // SizedBox(height: height * .1),

                      SignInButton(
                        Buttons.Google,
                        onPressed: () {
                          AuthMethods().signInWithGoogle(context);
                        },
                      ),

                      _createAccountLabel(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

Widget buildAboutDialog(BuildContext context) {
  return new AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
    backgroundColor: HexColor("#EEEEF0"),
    title: const Text('Privacy Policy'),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildAboutText(),
      ],
    ),
    actions: <Widget>[
      new FlatButton(
        onPressed: () {
          showAlertSignOutDialog(context);
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text("I don't agree!"),
      ),
      new FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text(
          "Okay, I agree!",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    ],
  );
}

Widget _buildAboutText() {
  TapGestureRecognizer _flutterTapRecognizer;
  TapGestureRecognizer _githubTapRecognizer;
  const TextStyle linkStyle =
      const TextStyle(color: Colors.blue, fontWeight: FontWeight.w500);
  return Expanded(
    child: SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: new RichText(
        text: new TextSpan(
          text:
              'Monzim built the MChats app as a Free app. This SERVICE is provided by Monzim at no cost and is intended for use as is. This page is used to inform visitors regarding my policies with the collection, use, and disclosure of Personal Information if anyone decided to use my Service.',
          style: const TextStyle(color: Colors.black87),
          children: <TextSpan>[
            new TextSpan(
              text:
                  '\n\n If you choose to use my Service, then you agree to the collection and use of information in relation to this policy.',
              recognizer: _flutterTapRecognizer,
              style: linkStyle,
            ),
            const TextSpan(
              text:
                  'The Personal Information that I collect is used for providing and improving the Service. I will not use or share your information with anyone except as described in this Privacy Policy.',
            ),
            new TextSpan(
              text: ' \n\nInformation Collection and Use',
              recognizer: _githubTapRecognizer,
              style: linkStyle,
            ),
            const TextSpan(
                text:
                    '\nFor a better experience, while using our Service, I may require you to provide us with certain personally identifiable information, including but not limited to name, email .The information that I request will be retained on your device and is not collected by me in any way. \nThe app does use third party services that may collect information used to identify you.'),
            new TextSpan(
              text:
                  ' \n\nList of third party service providers used by the app',
              recognizer: _githubTapRecognizer,
              style: linkStyle,
            ),
            const TextSpan(
                text:
                    '\n* Firebase \n* Google Analytics for Firebase \n* Google Play Services  '),
            new TextSpan(
              text: ' \n\n*Security ',
              recognizer: _githubTapRecognizer,
              style: linkStyle,
            ),
            const TextSpan(
                text:
                    '\nI value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and I cannot guarantee its absolute security.'),
            new TextSpan(
              text: '\n\nChanges to This Privacy Policy ',
              recognizer: _githubTapRecognizer,
              style: linkStyle,
            ),
            const TextSpan(
                text:
                    '\nI may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. I will notify you of any changes by posting the new Privacy Policy on this page.\nThis policy is effective as of 2021-01-24 '),
            new TextSpan(
              text: '\n\nContact Us',
              recognizer: _githubTapRecognizer,
              style: linkStyle,
            ),
            const TextSpan(
                text:
                    '\nIf you have any questions or suggestions about my Privacy Policy, do not hesitate to contact me at: '),
            new TextSpan(
              text: '\nmonzim.linux@gmail.com.',
              recognizer: _githubTapRecognizer,
              style: linkStyle,
            ),
            new TextSpan(
              text:
                  '\n\n****If you disagree, you will need to Sign Out of this application! ***',
              recognizer: _githubTapRecognizer,
              style: TextStyle(
                fontSize: 16,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget buildTermsAndConditionDialog(BuildContext context) {
  return new AlertDialog(
    backgroundColor: HexColor("#EEEEF0"),
    title: const Text('Terms & Conditions'),
    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildbuildTermsAndConditionText(),
      ],
    ),
    actions: <Widget>[
      new FlatButton(
        onPressed: () {
          showAlertSignOutDialog(context);
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text("I don't agree!"),
      ),
      new FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text(
          'Okay, I agree!',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    ],
  );
}

Widget _buildbuildTermsAndConditionText() {
  TapGestureRecognizer _flutterTapRecognizer;
  TapGestureRecognizer _githubTapRecognizer;
  const TextStyle linkStyle =
      const TextStyle(color: Colors.blue, fontWeight: FontWeight.w500);
  return Expanded(
    child: SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: new RichText(
        text: new TextSpan(
          text:
              'By downloading or using the app, these terms will automatically apply to you – you should make sure therefore that you read them carefully before using the app. You’re not allowed to copy, or modify the app, any part of the app, or our trademarks in any way. You’re not allowed to attempt to extract the source code of the app, and you also shouldn’t try to translate the app into other languages, or make derivative versions. The app itself, and all the trade marks, copyright, database rights and other intellectual property rights related to it, still belong to Monzim.\n\nMonzim is committed to ensuring that the app is as useful and efficient as possible. For that reason, we reserve the right to make changes to the app or to charge for its services, at any time and for any reason. We will never charge you for the app or its services without making it very clear to you exactly what you’re paying for.\n\nThe MChats app stores and processes personal data that you have provided to us, in order to provide my Service. It’s your responsibility to keep your phone and access to the app secure. We therefore recommend that you do not jailbreak or root your phone, which is the process of removing software restrictions and limitations imposed by the official operating system of your device. It could make your phone vulnerable to malware/viruses/malicious programs, compromise your phone’s security features and it could mean that the MChats app won’t work properly or at all.',
          style: const TextStyle(color: Colors.black87),
          children: <TextSpan>[
            new TextSpan(
              text:
                  ' \n\nThe app does use third party services that declare their own Terms and Conditions.',
              recognizer: _githubTapRecognizer,
              style: linkStyle,
            ),
            const TextSpan(
                text:
                    '\n\n* Firebase \n* Google Analytics for Firebase \n* Google Play Services \n'),
            const TextSpan(
                text:
                    '\nYou should be aware that there are certain things that Monzim will not take responsibility for. Certain functions of the app will require the app to have an active internet connection. The connection can be Wi-Fi, or provided by your mobile network provider, but Monzim cannot take responsibility for the app not working at full functionality if you don’t have access to Wi-Fi, and you don’t have any of your data allowance left. \n\nIf you’re using the app outside of an area with Wi-Fi, you should remember that your terms of the agreement with your mobile network provider will still apply. As a result, you may be charged by your mobile provider for the cost of data for the duration of the connection while accessing the app, or other third party charges. In using the app, you’re accepting responsibility for any such charges, including roaming data charges if you use the app outside of your home territory (i.e. region or country) without turning off data roaming. If you are not the bill payer for the device on which you’re using the app, please be aware that we assume that you have received permission from the bill payer for using the app.\n\nAlong the same lines, Monzim cannot always take responsibility for the way you use the app i.e. You need to make sure that your device stays charged – if it runs out of battery and you can’t turn it on to avail the Service, Monzim cannot accept responsibility.\n\nWith respect to Monzim’s responsibility for your use of the app, when you’re using the app, it’s important to bear in mind that although we endeavour to ensure that it is updated and correct at all times, we do rely on third parties to provide information to us so that we can make it available to you. Monzim accepts no liability for any loss, direct or indirect, you experience as a result of relying wholly on this functionality of the app.\n\nAt some point, we may wish to update the app. The app is currently available on Android – the requirements for system(and for any additional systems we decide to extend the availability of the app to) may change, and you’ll need to download the updates if you want to keep using the app. Monzim does not promise that it will always update the app so that it is relevant to you and/or works with the Android version that you have installed on your device. However, you promise to always accept updates to the application when offered to you, We may also wish to stop providing the app, and may terminate use of it at any time without giving notice of termination to you. Unless we tell you otherwise, upon any termination, (a) the rights and licenses granted to you in these terms will end; (b) you must stop using the app, and (if needed) delete it from your device.'),
            new TextSpan(
              text: '\n\nChanges to This Terms and Conditions',
              recognizer: _githubTapRecognizer,
              style: linkStyle,
            ),
            const TextSpan(
                text:
                    '\nI may update our Terms and Conditions from time to time. Thus, you are advised to review this page periodically for any changes. I will notify you of any changes by posting the new Terms and Conditions on this page. These terms and conditions are effective as of 2021-01-24'),
            new TextSpan(
              text: '\n\nContact Us',
              recognizer: _githubTapRecognizer,
              style: linkStyle,
            ),
            const TextSpan(
                text:
                    '\nIf you have any questions or suggestions about my Terms and Conditions, do not hesitate to contact me at: '),
            new TextSpan(
              text: '\nmonzim.linux@gmail.com.',
              recognizer: _githubTapRecognizer,
              style: linkStyle,
            ),
            new TextSpan(
              text:
                  '\n\n****If you disagree, you will need to Sign Out of this application! ***',
              recognizer: _githubTapRecognizer,
              style: TextStyle(
                fontSize: 16,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget buildAboutDialogSignIn(BuildContext context) {
  return new AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
    backgroundColor: HexColor("#EEEEF0"),
    title: const Text('Privacy Policy'),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildAboutSignInText(),
      ],
    ),
    actions: <Widget>[
      new FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text(
          "Okay, Got it!",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    ],
  );
}

Widget _buildAboutSignInText() {
  TapGestureRecognizer _flutterTapRecognizer;
  TapGestureRecognizer _githubTapRecognizer;
  const TextStyle linkStyle =
      const TextStyle(color: Colors.blue, fontWeight: FontWeight.w500);
  return Expanded(
    child: SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: new RichText(
        text: new TextSpan(
          text:
              'Monzim built the MChats app as a Free app. This SERVICE is provided by Monzim at no cost and is intended for use as is. This page is used to inform visitors regarding my policies with the collection, use, and disclosure of Personal Information if anyone decided to use my Service.',
          style: const TextStyle(color: Colors.black87),
          children: <TextSpan>[
            new TextSpan(
              text:
                  '\n\n If you choose to use my Service, then you agree to the collection and use of information in relation to this policy.',
              recognizer: _flutterTapRecognizer,
              style: linkStyle,
            ),
            const TextSpan(
              text:
                  'The Personal Information that I collect is used for providing and improving the Service. I will not use or share your information with anyone except as described in this Privacy Policy.',
            ),
            new TextSpan(
              text: ' \n\nInformation Collection and Use',
              recognizer: _githubTapRecognizer,
              style: linkStyle,
            ),
            const TextSpan(
                text:
                    '\nFor a better experience, while using our Service, I may require you to provide us with certain personally identifiable information, including but not limited to name, email .The information that I request will be retained on your device and is not collected by me in any way. \nThe app does use third party services that may collect information used to identify you.'),
            new TextSpan(
              text:
                  ' \n\nList of third party service providers used by the app',
              recognizer: _githubTapRecognizer,
              style: linkStyle,
            ),
            const TextSpan(
                text:
                    '\n* Firebase \n* Google Analytics for Firebase \n* Google Play Services  '),
            new TextSpan(
              text: ' \n\n*Security ',
              recognizer: _githubTapRecognizer,
              style: linkStyle,
            ),
            const TextSpan(
                text:
                    '\nI value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and I cannot guarantee its absolute security.'),
            new TextSpan(
              text: '\n\nChanges to This Privacy Policy ',
              recognizer: _githubTapRecognizer,
              style: linkStyle,
            ),
            const TextSpan(
                text:
                    '\nI may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. I will notify you of any changes by posting the new Privacy Policy on this page.\nThis policy is effective as of 2021-01-24 '),
            new TextSpan(
              text: '\n\nContact Us',
              recognizer: _githubTapRecognizer,
              style: linkStyle,
            ),
            const TextSpan(
                text:
                    '\nIf you have any questions or suggestions about my Privacy Policy, do not hesitate to contact me at: '),
            new TextSpan(
              text: '\nmonzim.linux@gmail.com.',
              recognizer: _githubTapRecognizer,
              style: linkStyle,
            ),
          ],
        ),
      ),
    ),
  );
}

showAlertSignOutDialog(BuildContext context) {
  // set up the button
  Widget okButton = RaisedButton(
    color: HexColor("#814155"),
    child: Text(
      "Yes",
    ),
    onPressed: () {
      AuthMethods().signOut();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => SignIn(),
        ),
        (route) => false,
      );
    },
  );
  Widget noButton = RaisedButton(
    color: HexColor("#F9F9F9"),
    child: Text("No"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    backgroundColor: HexColor("#D9E8F5"),
    title: Text("You are going to Sign Out!"),
    content: Text(
      "Are you sure you want to Sign Out? 🥺",
      style: TextStyle(fontSize: 18),
    ),
    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
    actions: [
      okButton,
      noButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
