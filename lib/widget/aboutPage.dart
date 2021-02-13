import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mChats/views/home.dart';
import 'package:mChats/widget/bezierContainer.dart';
import 'package:mChats/widget/infoPage.dart';
import 'package:mChats/widget/widgetsCollention.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:page_transition/page_transition.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor("#F2F2F2"),
        body: Stack(
          children: [
            Positioned(
                top: MediaQuery.of(context).size.height * .02,
                right: -MediaQuery.of(context).size.width * .4,
                child: BezierContainerDrawerPageAbout()),
            Positioned(
              bottom: MediaQuery.of(context).size.height * .1,
              right: MediaQuery.of(context).size.width * .1,
              child: SizedBox(
                width: 20,
                child: ScaleAnimatedTextKit(
                  duration: Duration(milliseconds: 2000),
                  totalRepeatCount: 100,
                  text: [
                    "Safe",
                    "Free",
                    "Wear",
                    "Mask",
                    "save",
                    "life",
                  ],
                  textStyle: GoogleFonts.portLligatSans(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: HexColor("#D9D9D9"),
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * .3,
              left: MediaQuery.of(context).size.width * .05,
              child: GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          buildAboutDialog(context));
                },
                child: ClayContainer(
                  borderRadius: 30,
                  color: Color(0xFFF2F2F2),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: ClayText(
                      "Privacy Policy",
                      emboss: true,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * .2,
              left: MediaQuery.of(context).size.width * .05,
              child: GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          buildTermsAndConditionDialog(context));
                },
                child: ClayContainer(
                  borderRadius: 30,
                  color: Color(0xFFF2F2F2),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: ClayText(
                      "Terms And Condition",
                      emboss: true,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * .11,
              left: MediaQuery.of(context).size.width * .05,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: ClayContainer(
                  color: Color(0xFFF2F2F2),
                  height: 50,
                  width: 100,
                  borderRadius: 75,
                  curveType: CurveType.concave,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClayText(
                        "BACK",
                        emboss: true,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * .11,
              left: MediaQuery.of(context).size.width * .35,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    PageTransition(
                        type: PageTransitionType.rotate,
                        child: Home(),
                        ctx: context),
                    (route) => false,
                  );
                },
                child: ClayContainer(
                  color: Color(0xFFF2F2F2),
                  height: 50,
                  width: 100,
                  borderRadius: 75,
                  curveType: CurveType.concave,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClayText(
                        "HOME",
                        emboss: true,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * .01,
              left: MediaQuery.of(context).size.width * .05,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40),
                    AppNameTitle(
                        context, 40.0, Color(0xffe46b10), Colors.black),
                    SizedBox(height: 5),
                    Text(" About Us", style: TextStyle(fontSize: 20)),
                    SizedBox(height: 45),
                    SizedBox(
                      width: 200.0,
                      child: TyperAnimatedTextKit(
                        speed: Duration(milliseconds: 200),
                        totalRepeatCount: 0,
                        pause: Duration(milliseconds: 20000),
                        text: [
                          "It is not enough to do your best. Thank you so much for using my app.",
                        ],
                        textStyle: TextStyle(
                          fontSize: 30.0,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(height: 10),
                    SelectableText("monzim.study@gmail.com")
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
