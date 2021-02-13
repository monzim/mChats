import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mChats/helperFunctions/sharedpre_helper.dart';
import 'package:mChats/services/database.dart';
import 'package:mChats/views/chatscreen.dart';
import 'package:mChats/widget/drawesettingPage.dart';
import 'package:mChats/widget/infoPage.dart';
import 'package:page_transition/page_transition.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isSearching = false;
  Stream userStream, chatRoomsStream;
  String myName,
      myProfilePic =
          "https://images.pexels.com/photos/3612885/pexels-photo-3612885.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
      myUserName,
      myEmail;

  TextEditingController searchUserNameEditingController =
      TextEditingController();

  getMyInfoFromSharedPreferences() async {
    myName = await SharedPreferenceHelper().getDisplayName();
    myProfilePic = await SharedPreferenceHelper().getProfileUrl();
    myUserName = await SharedPreferenceHelper().getUserName();
    myEmail = await SharedPreferenceHelper().getUserEmail();
    setState(() {});
  }

  getChatRoomIdByUserName(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  onSearchButtonClick() async {
    isSearching = true;
    setState(() {});
    userStream = await DatabaseMethods()
        .getUserByUserName(searchUserNameEditingController.text);
    setState(() {});
  }

  Widget chatRoomsList() {
    return StreamBuilder(
      stream: chatRoomsStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return ChatRoomListTile(ds.id, ds["lastMessage"], myUserName);
                })
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget searchFieldUserTile({String profileUrl, name, username, email}) {
    return GestureDetector(
      onTap: () {
        // print("you fool this is me my name $myUserName and 2nd $username");
        var chatRoomId = getChatRoomIdByUserName(myUserName, username);
        Map<String, dynamic> chatRoomInfoMap = {
          "users": [myUserName, username]
        };

        DatabaseMethods().createChatRoom(chatRoomId, chatRoomInfoMap);

        //before going to charRoom
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatScreen(
                      username,
                      name,
                    )));
      },
      child: Row(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: myProfilePic.toString() == null
                  ? const Image(
                      height: 45.0,
                      width: 45.0,
                      image: AssetImage('assets/images/emoteU.png'))
                  : Image(
                      height: 45.0,
                      width: 45.0,
                      image: NetworkImage(profileUrl),
                    )),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(color: Colors.white),
              ),
              Text(
                email,
                style: TextStyle(color: Colors.white),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget searchUserList() {
    return StreamBuilder(
      stream: userStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return searchFieldUserTile(
                    profileUrl: ds.data()["imgUrl"],
                    name: ds.data()["name"],
                    email: ds.data()["email"],
                    username: ds.data()["username"],
                  );
                },
              )
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }

  getChatRooms() async {
    chatRoomsStream = await DatabaseMethods().getChatRooms();
    setState(() {});
  }

  onScreenLoaded() async {
    await getMyInfoFromSharedPreferences();
    getChatRooms();
  }

  @override
  void initState() {
    onScreenLoaded();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.short_text,
                        color: Colors.white,
                        size: 30.0,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => settingPage(
                                    context, myName, myProfilePic, myEmail)));
                      }),
                  AppNameTitle(context, 29.0, Colors.white, Colors.white),

                  //Top Header Pic
                  ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: myProfilePic.toString() == null
                          ? const Image(
                              height: 45.0,
                              width: 45.0,
                              image: AssetImage('assets/images/emoteU.png'))
                          : Image(
                              height: 45.0,
                              width: 45.0,
                              image: NetworkImage(myProfilePic),
                            )),
                ],
              ),
            ),
          ),
        ),
      ),

      // App Background Color
      backgroundColor: HexColor("#0D0D0D"),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Row(
              children: [
                isSearching
                    ? GestureDetector(
                        onTap: () {
                          isSearching = false;
                          searchUserNameEditingController.text = "";
                          setState(() {});
                          Navigator.pushAndRemoveUntil(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: Home(),
                                ctx: context),
                            (route) => true,
                          );
                        },
                        child: Padding(
                            padding: EdgeInsets.only(right: 12),
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            )),
                      )
                    : Container(),
                Expanded(
                  // search Title Edit
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 16),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        // color: Colors.amber,
                        width: 1.0,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            style: TextStyle(color: Colors.black),
                            controller: searchUserNameEditingController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "search here",
                              hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.5)),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (searchUserNameEditingController.text != "") {
                              onSearchButtonClick();
                            }
                          },
                          child: Icon(Icons.search),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            isSearching
                ? Expanded(child: searchUserList())
                : Expanded(child: chatRoomsList()),
            // FloatingActionButton(
            //   backgroundColor: HexColor("#003B74"),
            //   child: Icon(Icons.refresh),
            //   onPressed: () {
            //     Navigator.pushAndRemoveUntil(
            //       context,
            //       PageTransition(
            //           type: PageTransitionType.rotate,
            //           child: Home(),
            //           ctx: context),
            //       (route) => false,
            //     );
            //   },
            // ),
            ElevatedButton.icon(
              icon: Icon(Icons.refresh),
              label: Text("Refresh"),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade,
                      child: Home(),
                      ctx: context),
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.amber,
                onPrimary: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
            ),
            SizedBox(height: 3)
          ],
        ),
      ),
    );
  }
}

class ChatRoomListTile extends StatefulWidget {
  final String chatRoomId, lastMessage, myUserName;
  ChatRoomListTile(this.chatRoomId, this.lastMessage, this.myUserName);

  @override
  _ChatRoomListTileState createState() => _ChatRoomListTileState();
}

class _ChatRoomListTileState extends State<ChatRoomListTile> {
  String profilePicUrl =
          "https://images.pexels.com/photos/3612885/pexels-photo-3612885.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
      name = "",
      username = "";

  getThisUserInfo() async {
    username =
        widget.chatRoomId.replaceAll(widget.myUserName, "").replaceAll("_", "");
    QuerySnapshot querySnapshot = await DatabaseMethods().getUserInfo(username);
    // print("something the data we are getting ${querySnapshot.docs[0].id}");
    name = "${querySnapshot.docs[0]["name"]}";
    profilePicUrl = querySnapshot.docs[0]["imgUrl"];
    setState(() {});
  }

  @override
  void initState() {
    getThisUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.scale,
              alignment: Alignment.centerLeft,
              child: ChatScreen(
                username,
                name,
              ),
            ));
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: profilePicUrl.toString() == null
                  ? const Image(
                      height: 45.0,
                      width: 45.0,
                      image: AssetImage('assets/images/emoteU.png'))
                  : Image(
                      height: 45.0,
                      width: 45.0,
                      image: NetworkImage(profilePicUrl),
                    )),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                //   style: TextStyle(
                //     fontSize: 16,
                //     color: Colors.white,
                //   ),
                style: GoogleFonts.lato(
                  textStyle: Theme.of(context).textTheme.display1,
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 3),
              Container(
                width: 200,
                child: Text(
                  widget.lastMessage,
                  // style: TextStyle(
                  //   fontSize: 16,
                  //   color: HexColor("#E6F4F7"),
                  // ),
                  style: GoogleFonts.lato(
                    textStyle: Theme.of(context).textTheme.display1,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic,
                    color: HexColor("#E6F4F7"),
                  ),
                  overflow: TextOverflow.visible,
                  softWrap: false,
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ],
      ),
    );
  }
}
