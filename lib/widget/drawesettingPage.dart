import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mChats/views/helpPage.dart';
import 'package:mChats/widget/aboutPage.dart';
import 'package:mChats/widget/bezierContainer.dart';
import 'package:mChats/widget/infoPage.dart';
import 'package:mChats/widget/widgetsCollention.dart';
import 'package:page_transition/page_transition.dart';

Widget settingPage(context, myName, muUrl, myEmail) {
  return Scaffold(
    backgroundColor: HexColor("#D4DBF5"),
    body: Stack(
      children: [
        Positioned(
            bottom: MediaQuery.of(context).size.height * .0,
            right: -MediaQuery.of(context).size.width * .4,
            child: BezierContainerDrawerPage1()),
        Positioned(
            bottom: MediaQuery.of(context).size.height * .5,
            left: -MediaQuery.of(context).size.width * .4,
            child: BezierContainerDrawerPage2()),
        Positioned(
          left: MediaQuery.of(context).size.width * .05,
          top: MediaQuery.of(context).size.height * .06,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(width: 10),
              AppNameTitle(context, 30.0, Color(0xffe46b10), Colors.black),
            ],
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 130),
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                  muUrl,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Column(
                    children: [
                      RichTextFor(context, myName, 36.0, FontWeight.bold),
                      RichTextFor(context, myEmail, 20.0, FontWeight.normal),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                icon: Icon(Icons.help),
                label: Text("Help"),
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: HelpPage(),
                        inheritTheme: true,
                        ctx: context),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: HexColor("#0C4879"),
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
              ),
              ElevatedButton.icon(
                icon: Icon(Icons.developer_mode),
                label: Text("Developer Info"),
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: InfoAboutAppPage(),
                        inheritTheme: true,
                        ctx: context),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
              ),
              ElevatedButton.icon(
                icon: Icon(Icons.info),
                label: Text("About"),
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: AboutPage(),
                        inheritTheme: true,
                        ctx: context),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
              ),
              ElevatedButton.icon(
                icon: Icon(Icons.logout),
                label: Text("LOG OUT"),
                onPressed: () {
                  showAlertSignOutDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.amber,
                ),
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    ),
    // color: Colors.amber,
  );
}
