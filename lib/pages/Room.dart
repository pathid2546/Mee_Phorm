import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:meephrom/pages/getNumber.dart';

class Room extends StatefulWidget {
  final String roomSize;
  final String userId;

  Room({Key? key, required this.roomSize, required this.userId})
      : super(key: key);

  @override
  State<Room> createState() => _RoomState();
}

class _RoomState extends State<Room> {
  DateTime now = DateTime.now();
  DateTime miniDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  @override
  Widget build(BuildContext context) {
    print('UserId in Room: ${widget.userId}');
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    String roomSize = widget.roomSize;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: appbar(context, roomSize),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(33),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              textOne(),
              getBox(),
              selectDate(context, screenWidth, screenHeight),
              getBox2(),
              getButt(screenWidth, screenHeight, roomSize)
            ],
          ),
        ),
      ),
    );
  }

  Column getButt(double screenWidth, double screenHeight, roomSize) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                String formattedDate = DateFormat('d E MMM yyyy').format(now);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => getNumber(
                        getDate: formattedDate,
                        roomSize: roomSize,
                        userId: widget.userId,
                      ),
                    ));
              },
              child: Container(
                width: screenWidth * 0.2,
                height: screenHeight * 0.045,
                decoration: BoxDecoration(
                  color: Color(0xFF7CC376),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(3, 3),
                      blurRadius: 1.0,
                      spreadRadius: 0.0,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'ยืนยัน',
                    style: GoogleFonts.kanit(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  SizedBox getBox2() {
    return SizedBox(
      height: 15,
    );
  }

  SizedBox getBox() {
    return SizedBox(
      height: 10,
    );
  }

  GestureDetector selectDate(
    BuildContext context,
    double screenWidth,
    double screenHeight,
  ) {
    return GestureDetector(
      onTap: () {
        _showDatePicker(context);
      },
      child: Container(
        width: screenWidth * 0.9,
        height: screenHeight * 0.03,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey, // สีของเงา
              offset: Offset(3, 3), // การเคลื่อนที่ของเงาในแนวแกน X, Y
              blurRadius: 1.0, // ความกว้างของเงา
              spreadRadius: 0.0, // การกระจายของเงา
            ),
          ],
        ),
        child: Text(
          '${now.month}-${now.day}-${now.year}',
          style: GoogleFonts.kanit(),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Container textOne() {
    return Container(
      child: Text(
        'เลือกวันที่',
        style: GoogleFonts.kanit(
          fontSize: 20,
        ),
        textAlign: TextAlign.start,
      ),
    );
  }

  void _showDatePicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext builderContext) {
        DateTime initialDateTime = now;
        DateTime maxDate = now.add(Duration(days: 15));

        return Container(
          height: 300.0,
          child: CupertinoDatePicker(
            minimumDate: miniDate,
            maximumDate: maxDate,
            initialDateTime: initialDateTime,
            onDateTimeChanged: (DateTime newDateTime) {
              setState(() {
                now = newDateTime;
              });
              print(newDateTime);
            },
            use24hFormat: true,
            mode: CupertinoDatePickerMode.date,
          ),
        );
      },
    );
  }

  AppBar appbar(context, roomSize) {
    return AppBar(
      title: Text(
        'ห้องขนาด ${roomSize}',
        style: GoogleFonts.kanit(
          fontSize: 30,
          fontWeight: FontWeight.w300,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      backgroundColor: Color(0xFF1846AA),
      elevation: 0.0,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          margin: EdgeInsets.all(10),
          alignment: Alignment.center,
          child: SvgPicture.asset(
            'assets/icons/arrow.svg',
            height: 25,
            width: 25,
          ),
          decoration: BoxDecoration(
              color: Color(0xFF042B7E), borderRadius: BorderRadius.circular(5)),
        ),
      ),
    );
  }
}
