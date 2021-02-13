import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mChats/widget/bezierContainer.dart';

class InfoAboutAppPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#D4DBF5"),
      body: Stack(
        children: [
          Positioned(
              bottom: MediaQuery.of(context).size.height * .0,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainerDrawerPage3()),
          Positioned(
              bottom: MediaQuery.of(context).size.height * .5,
              left: -MediaQuery.of(context).size.width * .4,
              child: BezierContainerDrawerPage4()),
          Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
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
                            style: TextStyle(
                                color: Color(0xffe46b10), fontSize: 30),
                          ),
                        ]),
                  ),
                  SizedBox(height: 15),
                  SizedBox(
                    // width: 200.0,
                    height: 50,
                    child: TyperAnimatedTextKit(
                      speed: Duration(milliseconds: 200),
                      totalRepeatCount: 0,
                      pause: Duration(milliseconds: 20000),
                      text: [
                        "Thank you for using \nmy App 😊",
                      ],
                      textStyle: GoogleFonts.portLligatSans(
                        textStyle: Theme.of(context).textTheme.display1,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    width: 200.0,
                    height: 200.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        "https://pbs.twimg.com/profile_images/1349722974677467139/Sm4DrmsI_400x400.jpg",
                        fit: BoxFit.fill,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes
                                  : null,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  RichTextFor(
                      context, "Azraf Al Monzim", 35.0, FontWeight.w800),
                  SizedBox(height: 15),
                  Container(
                    height: 40,
                    width: 210,
                    child: RaisedButton(
                      color: Colors.blueGrey[400],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22.0),
                      ),
                      onPressed: () {},
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/github-sign.png",
                            height: 50,
                          ),
                          SizedBox(width: 5),
                          SelectableText('github.com/monzim'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 40,
                    width: 200,
                    child: RaisedButton(
                      color: Colors.pink[300],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22.0),
                      ),
                      onPressed: () {},
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/instagram.png",
                            height: 50,
                          ),
                          SizedBox(width: 5),
                          SelectableText('azraf_al_monzim'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 40,
                    width: 200,
                    child: RaisedButton(
                      color: Colors.lightBlue[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22.0),
                      ),
                      onPressed: () {},
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/facebook.png",
                            height: 50,
                          ),
                          SizedBox(width: 5),
                          SelectableText('azrafal.monzim'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
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
          ),
        ],
      ),
    );
  }
}

// ignore: non_constant_identifier_names
RichTextFor(context, textName, fontsize, fontWeight) {
  return RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
      text: textName,
      style: GoogleFonts.portLligatSans(
        textStyle: Theme.of(context).textTheme.display1,
        fontSize: fontsize,
        fontWeight: fontWeight,
        color: Colors.black,
      ),
    ),
  );
}

// ignore: non_constant_identifier_names
AppNameTitle(context, mainFontsize, color1, color2) {
  return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'M',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: mainFontsize,
            fontWeight: FontWeight.w700,
            color: color1,
          ),
          children: [
            TextSpan(
              text: 'Ch',
              style: TextStyle(color: color2, fontSize: mainFontsize - 5),
            ),
            TextSpan(
              text: 'ats',
              style: TextStyle(color: color1, fontSize: mainFontsize - 5),
            ),
          ]));
}
