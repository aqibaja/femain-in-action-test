import 'package:cloud_firestore/cloud_firestore.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
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
          padding: EdgeInsets.only(left: 9, top: 25, right: 9),
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
              columnText('0', 'Post'),
              columnText('0', 'Followers'),
              columnText('0', 'Following'),
            ],
          ),
        )
      ],
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
