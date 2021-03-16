import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:female_in_action/models/model_feed.dart';
import 'package:female_in_action/models/model_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  final String username;
  ProfileScreen({this.uid, this.username});
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

FirebaseFirestore firestore = FirebaseFirestore.instance;

class _ProfileScreenState extends State<ProfileScreen> {
  CollectionReference users = firestore.collection("users");
  CollectionReference feed = firestore.collection("feed");

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          // backgroundColor: Colors.pink,
          title: Text(
            widget.username,
            style: GoogleFonts.lato(fontSize: 29),
          ),
          actions: [
            Icon(
              Icons.add_box_outlined,
              size: 35,
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.menu,
              size: 35,
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
        body: Container(
            child: StreamBuilder<DocumentSnapshot>(
                stream: users.doc(widget.uid).snapshots(),
                builder: (_, snapshot) {
                  if (snapshot.hasData) {
                    EasyLoading.dismiss();
                    return listView(
                      snapshot.data.data()['nama'],
                      snapshot.data.data()['username'],
                      snapshot.data.data()['uavatarUrl'],
                      snapshot.data.data()['id'],
                      snapshot.data.data()['email'],
                      snapshot.data.data()['bio'],
                    );
                  } else {
                    EasyLoading.show(status: 'loading...');
                    return Container();
                  }
                })),
      ),
    );
  }

  Widget listView(
    String name,
    String username,
    String uAvatarUrl,
    String id,
    String email,
    String bio,
  ) {
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 13, top: 25, right: 13),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 46.1,
                backgroundColor: Colors.pink,
                child: CircleAvatar(
                  radius: 45.0,
                  backgroundImage: uAvatarUrl == null
                      ? AssetImage('assets/images/avatar.png')
                      : NetworkImage(uAvatarUrl),
                  backgroundColor: Colors.transparent,
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: feed.where('uid', isEqualTo: widget.uid).snapshots(),
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      List<ModelFeed> feed = snapshot.data.docs
                          .map((e) => ModelFeed.fromMap(e.data()))
                          .toList();
                      return columnText(feed.length.toString(), 'Post');
                    } else {
                      columnText('0', 'Post');
                      return Container();
                    }
                  }),
              columnText('0', 'Followers'),
              columnText('0', 'Following'),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 13, top: 13, right: 13),
          child: Text(
            name ?? username,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 13, right: 13),
          child: Text(
            bio ?? "",
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(13.0),
          child: Row(
            children: [
              Expanded(
                  child: ElevatedButton(
                onPressed: () {},
                child: Text("Edit Profile", style: TextStyle(fontSize: 19)),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green)),
              )),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red)),
                child: Text("Logout", style: TextStyle(fontSize: 19)),
              )),
            ],
          ),
        ),
        Container(
          height: 50,
          width: double.infinity,
          child: TabBar(
            labelColor: Colors.black,
            indicatorColor: Colors.pink,
            tabs: [
              Tab(
                icon: Icon(Icons.grid_on_outlined),
              ),
              Tab(
                icon: Icon(
                  Icons.person_pin_outlined,
                ),
              )
            ], // list of tabs
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: double.infinity,
          height: double.maxFinite,
          child: TabBarView(
            children: [
              Container(color: Colors.white24, child: allPost()),
              Container(color: Colors.white24, child: Container()) // class name
            ],
          ),
        ),
      ],
    );
  }

  Container allPost() {
    return Container(
        width: double.infinity,
        child: StreamBuilder<QuerySnapshot>(
            stream: feed.where('uid', isEqualTo: widget.uid).snapshots(),
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                EasyLoading.dismiss();
                List<ModelFeed> feed = snapshot.data.docs
                    .map((e) => ModelFeed.fromMap(e.data()))
                    .toList();
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemCount: feed.length,
                  itemBuilder: (BuildContext context, i) {
                    return itemGrid(feed[i].username, feed[i].uid,
                        feed[i].uavatarUrl, feed[i].imageUrl, feed[i].desc);
                  },
                );
              } else {
                EasyLoading.show(status: 'loading...');
                return Container();
              }
            }));
  }

  Widget itemGrid(username, uid, uavatarUrl, imageUrl, desc) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        child: Image.network(
          imageUrl,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Column columnText(String count, String type) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(fontSize: 25),
        ),
        Text(
          type,
          style: TextStyle(fontSize: 25),
        )
      ],
    );
  }
}
