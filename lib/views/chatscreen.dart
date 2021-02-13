import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mChats/helperFunctions/sharedpre_helper.dart';
import 'package:mChats/services/database.dart';
import 'package:random_string/random_string.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatefulWidget {
  final String chatWithUserName, name;
  ChatScreen(this.chatWithUserName, this.name);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Stream messageStream;
  String chatRoomId, messageId = "";
  String myName, myProfilePic, myUserName, myEmail;
  TextEditingController messageTextEditingController = TextEditingController();

  getMyInfoFromSharedPreferences() async {
    myName = await SharedPreferenceHelper().getDisplayName();
    myProfilePic = await SharedPreferenceHelper().getProfileUrl();
    myUserName = await SharedPreferenceHelper().getUserName();
    myEmail = await SharedPreferenceHelper().getUserEmail();

    chatRoomId = getChatRoomIdByUserName(widget.chatWithUserName, myUserName);
  }

  getChatRoomIdByUserName(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  addMessage(bool sentClicked) {
    if (messageTextEditingController.text != "") {
      String message = messageTextEditingController.text;

      var lastMessageTs = DateTime.now();
      Map<String, dynamic> messageInfoMap = {
        "message": message,
        "sendBy": myUserName,
        "ts": lastMessageTs,
        "imgUrl": myProfilePic
      };

      //messgerId
      if (messageId == "") {
        messageId = randomAlphaNumeric(12);
      }

      DatabaseMethods()
          .addMessage(chatRoomId, messageId, messageInfoMap)
          .then((value) {
        Map<String, dynamic> lastMessageInfoMap = {
          "lastMessage": message,
          "lastSendTs": lastMessageTs,
          "lastMessageSendBy": myUserName
        };

        DatabaseMethods().updateLastMessageSend(chatRoomId, lastMessageInfoMap);

        if (sentClicked) {
          //remove the message of TextFiled
          messageTextEditingController.text = "";

          //make message id blank to get regenerated on next message send
          messageId = "";
        }
      });
    }
  }

  Widget chatMessageTitle(String message, bool sendByMe) {
    return Row(
      mainAxisAlignment:
          sendByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
            maxWidth: MediaQuery.of(context).size.width * 0.6,
          ),
          // width: MediaQuery.of(context).size.w,
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              bottomRight: sendByMe ? Radius.circular(0) : Radius.circular(24),
              topRight: Radius.circular(24),
              bottomLeft: sendByMe ? Radius.circular(24) : Radius.circular(0),
            ),
            color: sendByMe
                ? Colors.black.withOpacity(0.7)
                : Colors.black.withOpacity(0.7),

            //border for Chats
            border: Border.all(
              color: sendByMe ? Colors.blue : Colors.red,
              width: 1.0,
              style: BorderStyle.solid,
            ),
          ),

          child: SelectableText(
            message,
            style: TextStyle(
              color: Colors.white,
              // fontSize: 16.5,
            ),
            // style: GoogleFonts.portLligatSans(
            //   textStyle: Theme.of(context).textTheme.display1,
            //   fontSize: 14.9,
            //   fontWeight: FontWeight.normal,
            //   color: Colors.white,
            // ),
          ),
        ),
      ],
    );
  }

  Widget chatMessages() {
    return StreamBuilder(
        stream: messageStream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  padding: EdgeInsets.only(bottom: 70, top: 16),
                  itemCount: snapshot.data.docs.length,
                  reverse: true,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return chatMessageTitle(
                        ds["message"], myUserName == ds["sendBy"]);
                  })
              : Center(child: CircularProgressIndicator());
        });
  }

  getAndSetMessages() async {
    messageStream = await DatabaseMethods().getChatRoomMessages(chatRoomId);
    setState(() {});
  }

  doThisOnLaunch() async {
    await getMyInfoFromSharedPreferences();
    getAndSetMessages();
  }

  @override
  void initState() {
    doThisOnLaunch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: HexColor("#3D6AF2"),
        title: Text(
          widget.name,
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 23.5,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),

      backgroundColor: Colors.black,
      // message BOX
      body: Container(
        child: Stack(
          children: [
            chatMessages(),
            Container(
              // alignment: Alignment.bottomCenter,
              alignment: Alignment.bottomLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * .9,
                      maxWidth: MediaQuery.of(context).size.width * .8,
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    padding: EdgeInsets.only(left: 8.0, right: 4.0),
                    decoration: BoxDecoration(
                      //color
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                      border: Border.all(
                        color: HexColor("#04BF8A"),
                        width: 1.5,
                        style: BorderStyle.solid,
                      ),
                    ),

                    // TextInput Field
                    child: Row(
                      children: [
                        Expanded(
                            child: TextField(
                          // maxLength: 1000,
                          minLines: 1,
                          maxLines: 4,
                          style: GoogleFonts.portLligatSans(
                            textStyle: Theme.of(context).textTheme.display1,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),

                          controller: messageTextEditingController,
                          onChanged: (value) {
                            addMessage(false);
                          },
                          decoration: InputDecoration(
                            hintText: "type a message",
                            // hintStyle: TextStyle(
                            //   fontWeight: FontWeight.w500,
                            //   color: Colors.white.withOpacity(0.5),
                            // ),
                            hintStyle: GoogleFonts.portLligatSans(
                              textStyle: Theme.of(context).textTheme.display1,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.white.withOpacity(0.5),
                            ),
                            border: InputBorder.none,
                          ),
                        )),
                      ],
                    ),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      addMessage(true);
                    },
                    backgroundColor: Colors.black.withOpacity(0.0),
                    splashColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      // child: Transform.rotate(
                      //   angle: 100,
                      //   child: Icon(
                      //     Icons.send,
                      //     color: Colors.red,
                      //     size: 40,
                      //   ),
                      // ),
                      child: Image.asset('assets/images/send0.png'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
