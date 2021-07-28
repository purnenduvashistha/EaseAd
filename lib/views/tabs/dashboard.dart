import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../widgets/clayContainerHighlight.dart';
import '../../widgets/submitBtn.dart';
import '../details.dart';

class DashBoardTab extends StatefulWidget {
  static String id="dashBoardTab";
  @override
  _DashBoardTabState createState() => _DashBoardTabState();
}

class _DashBoardTabState extends State<DashBoardTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            DashboardTopBar(),
            SizedBox(
              height: 20,
            ),
            Text(
              'Current Openings',
              style: kHeading1,
            ),
            SizedBox(
              height: 20,
            ),
            SchoolCard(
                imagePath: 'assets/images/gyan-niketan.jpg',
                classDetails: 'XI',
                logoPath: 'assets/images/gyan-niketan-logo.jpg',
                message:
                'Gyan Niketan invites application to class XI for the session 2021-22.',
                name: 'Gyan Niketan',
                vacancies: '108',
              rating: '9.8',),
            SchoolCard(
                imagePath: 'assets/images/dps-details.png',
                classDetails: 'IX',
                logoPath: 'assets/images/dps-logo.jpg',
                message:
                'Delhi Public School invites application to class IX for the session 2021-22.',
                name: 'Delhi Public School',
                vacancies: '63',
                rating: '8.7',),
            SchoolCard(
                imagePath: 'assets/images/mount-carmel.jpeg',
                classDetails: 'VI',
                logoPath: 'assets/images/carmel_logo.jpg',
                message:
                'Mount Carmel High School invites application to class VI for the session 2021-22.',
                name: 'Mount Carmel School',
                vacancies: '54',
                rating: '9.1',),
          ],
        ));
  }
}

class DashboardTopBar extends StatelessWidget {
  const DashboardTopBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          'Hello, Purnendu!',
          style: kHeading3,
        ),
        Spacer(),
        Stack(
          alignment: Alignment.topRight,
          children: [
            ClayContainerHighlight(
              iconData: CupertinoIcons.bell,
            ),
            CircleAvatar(
              backgroundColor: Colors.red,
              radius: 9,
              child: Text(
                '5',
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            )
          ],
        ),
        SizedBox(
          width: 10,
        ),
        ClayContainerHighlight(onTap: () {}, iconData: CupertinoIcons.search),
      ],
    );
  }
}

class SchoolCard extends StatefulWidget {
  String imagePath;
  String name;
  String logoPath;
  String vacancies;
  String classDetails;
  String message;
  String rating;


  SchoolCard(
      {required this.imagePath,
        required this.classDetails,
        required this.logoPath,
        required this.message,
        required this.name,
        required this.vacancies,
        required this.rating
        });
  @override
  _SchoolCardState createState() => _SchoolCardState();
}

class _SchoolCardState extends State<SchoolCard> {
  bool bookmarkClicked = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, SchoolDetailsPage.id);
      },
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                boxShadow: [
              BoxShadow(
                color: Colors.blueGrey.shade100,
                blurRadius: 20,
              ),
            ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Image.asset(
                  widget.imagePath,
                  fit: BoxFit.cover,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Image.asset(widget.logoPath),
                      ),
                      Text(
                        widget.name,
                        overflow: TextOverflow.ellipsis,
                        style: kHeading3,
                      ),
                      Spacer(),
                      Text(
                         widget.rating + '/10',
                        style: kHeading4.copyWith(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Divider(),
                Container(
                  padding: EdgeInsets.only(left: 12, bottom: 6,top: 12,right: 12),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.vacancies + ' vacancies',
                        style: kHeading2.copyWith(
                            color: Colors.blueGrey,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'Class ' + widget.classDetails,
                        style: kHeading2.copyWith(
                            color: Colors.blueGrey,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),

                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    widget.message,
                    style: kHeading4,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 12),
                    child: SubmitButton(
                      height: 50,
                      onTap: () {},
                      text: 'Apply',
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
