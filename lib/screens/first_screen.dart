import 'package:flutter/material.dart';
import 'package:glug_app/screens/home_screen.dart';
import 'package:glug_app/screens/notice_screen.dart';

import 'attendance_tracker_screen.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final _ctrl = PageController();
  int _currentPage = 0;
  List<Map<String, dynamic>> data = [
    {
      "title": "Our\nClub\nActivities",
      "body": "Wanna know what we're all about? Come, explore the Source!",
      "image": "images/glug_logo.jpeg",
      "color": Colors.blue[900],
      "route": HomeScreen(),
    },
    {
      "title": "Track\nYour\nAttendance",
      "body": "Feel free to skip a class cause you're never falling behind!",
      "image": "images/glug_logo.jpeg",
      "color": Colors.deepOrange[700],
      "route": AttendanceTrackerScreen(),
    },
    {
      "title": "Browse\nInstitute\nNotices",
      "body": "Now you'll never miss an important update from the institute!",
      "image": "images/glug_logo.jpeg",
      "color": Colors.green[900],
      "route": NoticeScreen(),
    },
  ];
  // final ValueNotifier<double> _notifier = ValueNotifier<double>(0);

  @override
  void initState() {
    super.initState();
    _ctrl.addListener(() {
      int next = _ctrl.page.round();

      if (_currentPage != next) {
        setState(() {
          _currentPage = next;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  _buildPage(context, i) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.width * 0.02),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data[i]["title"],
              style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.w900,
              ),
            ),

            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctxt) => data[i]["route"]));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                height: screenHeight * 0.55,
                width: screenWidth * 0.88,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      data[i]["body"],
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: screenWidth * 0.6,
                      width: screenWidth * 0.6,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage(data[i]["image"]),
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: data[i]["color"],
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildDots() {
    int items = 3;

    List<Widget> dots = [];

    for (int i = 0; i < items; i++) {
      double s = i == _currentPage ? 10.0 : 8.0;
      Color c = i == _currentPage
          ? (Theme.of(context).primaryColor == Colors.black
              ? Colors.white
              : Colors.black)
          : Colors.grey;
      dots.add(
        AnimatedContainer(
          duration: Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          margin: EdgeInsets.symmetric(horizontal: 2.5),
          height: s,
          width: s,
          decoration: BoxDecoration(
            color: c,
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      );
    }

    return dots;
  }

  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;

  bool isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        transform: Matrix4.translationValues(xOffset, yOffset, 0)
          ..scale(scaleFactor)
          ..rotateY(isDrawerOpen ? -0.5 : 0),
        duration: Duration(milliseconds: 250),
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0.0)),
        child: Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: isDrawerOpen
                          ? IconButton(
                              icon: Icon(Icons.arrow_back_ios),
                              iconSize: 35.0,
                              color: (Theme.of(context).primaryColor ==
                                      Colors.black
                                  ? Colors.white
                                  : Colors.black),
                              onPressed: () {
                                setState(() {
                                  xOffset = 0;
                                  yOffset = 0;
                                  scaleFactor = 1;
                                  isDrawerOpen = false;
                                });
                              },
                            )
                          : IconButton(
                              icon: Icon(Icons.sort),
                              iconSize: 35.0,
                              color: (Theme.of(context).primaryColor ==
                                      Colors.black
                                  ? Colors.white
                                  : Colors.black),
                              onPressed: () {
                                setState(() {
                                  xOffset = 220;
                                  yOffset = 150;
                                  scaleFactor = 0.6;
                                  isDrawerOpen = true;
                                });
                              }),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: IconButton(
                        icon: Icon(Icons.notifications),
                        iconSize: 30.0,
                        color: (Theme.of(context).primaryColor == Colors.black
                            ? Colors.white
                            : Colors.black),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.01,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildDots(),
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    controller: _ctrl,
                    itemCount: 3,
                    itemBuilder: (ctxt, index) {
                      return _buildPage(context, index);
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
