import 'dart:ui';

import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expansion_widget/expansion_widget.dart';

import '../../constants.dart';
import '../../services/auth.dart';
import '../../widgets/clayContainerHighlight.dart';
import '../login.dart';
import '../tabs/../profile.dart';
import 'dart:math' as math;

import 'package:clipboard/clipboard.dart';
import 'package:fluttertoast/fluttertoast.dart';




class UserTab extends StatefulWidget {
  static String id="UserTab";
  @override
  _UserTabState createState() => _UserTabState();
}

class _UserTabState extends State<UserTab> {
  bool _isSignedOut = false;
  @override
  Widget build(BuildContext context) {
    /**
     * TODO:
     * fetch user details
     */
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            ClayContainerHighlight(
              isSpreadAllowed: true,
              iconData: CupertinoIcons.pencil,
              onTap: () {
                Navigator.pushNamed(context, ProfilePage.id);
                setState(() {});
              },
            ),
            SizedBox(
              width: 20,
            ),
            getSignOutButton()
          ]),
          Container(
            padding: EdgeInsets.only(top: 30, left: 90, right: 90),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Image.asset(
                "assets/images/dp.png",
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          //user info
          InformationTile(
              content: Column(
                children: [
                  CopiableContacts(
                      icondata: CupertinoIcons.phone,
                      content: '123456789'),
                  CopiableContacts(
                      icondata: CupertinoIcons.videocam, content: '2osjJF7Guw'),
                  CopiableContacts(
                      icondata: CupertinoIcons.envelope,
                      content: 'gyanniketan@gmail.com'),
                ],
              ),
              title: 'Contact Details',
              isExpanded: true),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: FrostedGlassUserInfo(
                  color: Colors.orangeAccent,
                  title: 'Payment',
                  subtitle: 'Not Paid',
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: FrostedGlassUserInfo(
                  color: Colors.greenAccent,
                  title: 'Application',
                  subtitle: 'Filled',
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            leading: Icon(CupertinoIcons.map),
            tileColor: Colors.white,
            title: Text('Address'),
            subtitle: Text(
              'Rajendra Nagar, Patna',
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }

  Widget getSignOutButton() {
    return ClayContainer(
        color: Colors.red,
        parentColor: Color(0xffF2F7FC),
        depth: 2,
        width: 40,
        height: 40,
        borderRadius: 15,
        child: InkWell(
            onTap: () async {
              final _auth = Provider.of<Auth>(context, listen: false);
              setState(() {
                _isSignedOut = true;
              });
              var result = await _auth.signOut(context: context);
              setState(() {
                _isSignedOut = false;
              });
              if (result) {
                Navigator.popAndPushNamed(context, LoginPage.id);
              }
            },
            child: Center(
                child: Icon(CupertinoIcons.square_arrow_right,
                    color: Colors.white))));
  }
}

class FrostedGlassUserInfo extends StatelessWidget {
  Color color;
  String title;
  IconData iconData;
  bool showActionButton;
  String subtitle;
  FrostedGlassUserInfo(
      {Key? key,
        required this.color,
        required this.subtitle,
        required this.title,
        this.iconData = CupertinoIcons.arrow_up,
        this.showActionButton = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClayContainer(
      parentColor: Colors.white10,
      height: 100,
      borderRadius: 20,
      color: color,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        clipBehavior: Clip.hardEdge,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: showActionButton
                ? EdgeInsets.only(left: 15, right: 20)
                : EdgeInsets.all(8),
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey.shade200.withOpacity(0.5)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // showActionButton
              //     ? MainAxisAlignment.spaceAround
              //     : MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: kHeading3.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w900),
                    ),
                    subtitle == ''
                        ? Container()
                        : SizedBox(
                      height: 10,
                    ),
                    subtitle == ''
                        ? Container()
                        : Text(
                      subtitle,
                      overflow: TextOverflow.ellipsis,
                      style: kHeading4,
                    )
                  ],
                ),
                showActionButton ? Spacer() : Container(),
                showActionButton
                    ? ClayContainerHighlight(
                    isSpreadAllowed: false, iconData: iconData)
                    : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UserInfoRow extends StatelessWidget {
  String title;
  String subtitle;
  UserInfoRow({required this.subtitle, required this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: ListTile(
        dense: true,
        tileColor: Colors.white,
        title: Text(
          title,
          style: kHeading3,
        ),
        trailing: Text(
          subtitle,
          overflow: TextOverflow.ellipsis,
          style: kHeading4,
        ),
      ),
    );
  }
}


class InformationTile extends StatelessWidget {
  String title;
  bool isExpanded = false;
  Widget content;
  InformationTile(
      {required this.content, required this.title, required this.isExpanded});

  @override
  Widget build(BuildContext context) {
    return ExpansionWidget(
        initiallyExpanded: isExpanded,
        titleBuilder:
            (double animationValue, _, bool isExpaned, toogleFunction) {
          return InkWell(
              onTap: () => toogleFunction(animated: true),
              child: ClayContainer(
                spread: 0,
                color: Colors.white,
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: Text(title)),
                      Transform.rotate(
                        angle: math.pi * animationValue / 2,
                        child: Icon(CupertinoIcons.arrow_right, size: 20),
                        alignment: Alignment.center,
                      )
                    ],
                  ),
                ),
              ));
        },
        content: Container(
          width: double.infinity,
          color: Colors.grey.shade100,
          padding: EdgeInsets.all(20),
          child: content,
        ));
  }
}


class CopiableContacts extends StatelessWidget {
  String content;
  IconData icondata;

  CopiableContacts({required this.content, required this.icondata});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Icon(
            icondata,
            size: 16,
          ),
        ),
        Expanded(
          flex: 3,
          child: RichText(
            text: TextSpan(text: content, style: kHeading4),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(width: 50),
        Expanded(
          flex: 1,
          child: IconButton(
            icon: Icon(
              CupertinoIcons.doc_on_doc,
              size: 18,
            ),
            onPressed: () {
              print('tapped');
              FlutterClipboard.copy(content).then((value) => {
                Fluttertoast.showToast(
                    msg: "Copied!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.white,
                    textColor: Colors.black,
                    fontSize: 12.0)
              });
            },
          ),
        ),
      ],
    );
  }
}