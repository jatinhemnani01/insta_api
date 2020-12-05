import 'package:flutter/material.dart';
import 'package:flutter_insta/flutter_insta.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  FlutterInsta flutterInsta =
      FlutterInsta(); // create instance of FlutterInsta class
  TextEditingController usernameController = TextEditingController();
  TextEditingController reelController = TextEditingController();
  TabController tabController;

  String username, following, bio, website, profileimage;
  String enterName = "Know If You Are Eligible Or Not";
  int followers;
  bool pressed = false;
  bool downloading = false;
  Color bgcolor = Colors.indigo[300];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: homePage(),
      appBar: AppBar(
        backgroundColor: Color(0xffff6b6b),
        title: const Text('Check Instagram Profile'),
        centerTitle: true,
      ),
    );
  }

//get data from api
  Future printDetails(String username) async {
    await flutterInsta.getProfileData(username);
    setState(() {
      this.username = flutterInsta.username; //username
      this.followers = flutterInsta.followers; //number of followers
      this.following = flutterInsta.following; // number of following
      this.website = flutterInsta.website; // bio link
      this.bio = flutterInsta.bio; // Bio
      this.profileimage = flutterInsta.imgurl; // Profile picture URL
      eligble();
    });
  }

  eligble() {
    if (followers >= 1000) {
      setState(() {
        enterName = "Eligible";
        bgcolor = Colors.green;
      });
    } else {
      setState(() {
        enterName = "Not Eligible";
        bgcolor = Colors.red;
      });
    }
  }

  Widget homePage() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Center(
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10),
                hintText: "Enter Username",
              ),
              controller: usernameController,
            ),
            FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.red)),
              color: Color(0xffff6b6b),
              child: Text(
                "Get Profile",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                setState(() {
                  pressed = true;
                });
                printDetails(usernameController.text);
                //get Data
              },
            ),
            Container(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                enterName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                  backgroundColor: bgcolor,
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
            pressed
                ? SingleChildScrollView(
                    child: Card(
                      child: Container(
                        margin: EdgeInsets.all(15),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(0xffee5253), width: 3.0),
                                borderRadius: BorderRadius.circular(100.0),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.network(
                                  "${profileimage}",
                                  width: 120,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                            ),
                            Text(
                              "${username}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                            ),
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.greenAccent,
                                        width: 7.0),
                                  ),
                                  // color: Colors.white,
                                  padding: EdgeInsets.all(20.0),
                                  child: Text(
                                    "${followers}\nFollowers",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(20.0),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.blueAccent,
                                          width: 7.0)),
                                  child: Text(
                                    "${following}\nFollowing",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                            ),
                            Text(
                              "${bio}",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(top: 10)),
                            Text(
                              "${website}",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

//Download reel video on button clickl

}
