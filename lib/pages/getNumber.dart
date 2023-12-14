import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meephrom/pages/Per_menu.dart';
import "dart:ui";
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class getNumber extends StatefulWidget {
  final String getDate;
  final String roomSize;
  final String userId;

  getNumber(
      {Key? key,
      required this.getDate,
      required this.roomSize,
      required this.userId})
      : super(key: key);

  @override
  State<getNumber> createState() => _getNumberState();
}

class Reservation {
  String userId;
  String roomSize;
  String roomNum;
  String date;
  String time;

  Reservation({
    required this.userId,
    required this.roomSize,
    required this.roomNum,
    required this.date,
    required this.time,
  });
}

class _getNumberState extends State<getNumber> {
  bool timeisPressed = false,
      timeisPressed2 = false,
      timeisPressed3 = false,
      timeisPressed4 = false,
      timeisPressed5 = false,
      timeisPressed6 = false,
      timeisPressed7 = false,
      timeisPressed8 = false,
      timeisPressed9 = false,
      timeisPressed10 = false,
      timeisPressed11 = false,
      timeisPressed12 = false,
      roomisPressed = false,
      roomisPressed2 = false,
      roomisPressed3 = false,
      roomisPressed4 = false,
      roomisPressed5 = false;
  String roomNum = '';
  String timeSpace = '';

  @override
  Widget build(BuildContext context) {
    print('UserId in getNumber: ${widget.userId}');
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    String roomSize = widget.roomSize;
    String getDate = widget.getDate;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: appbar(roomSize),
        body: SingleChildScrollView(
          child: roomSelected(screenWidth, roomSize, screenHeight,
              timeisPressed, roomNum, getDate),
        ),
      ),
    );
  }

  Column roomSelected(double screenWidth, String roomSize, double screenHeight,
      bool isPressed, roomNum, getDate) {
    return Column(
      children: [
        getHeader(screenWidth),
        SizedBox(
          height: 20,
        ),
        Container(
          child: Text(
            'กรุณาเลือกห้องและเวลาในการจอง',
            style: GoogleFonts.kanit(),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 80, right: 80),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              rowOne(),
              rowTwo(
                roomSize,
                screenWidth,
                screenHeight,
              ),
              rowThrid(roomSize, screenWidth, screenHeight),
            ],
          ),
        ),
        SizedBox(
          height: screenHeight * 0.08,
        ),
        Container(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              rowTime_1(roomSize, screenWidth, screenHeight),
              rowTime_2(roomSize, screenWidth, screenHeight),
              rowTime_3(roomSize, screenWidth, screenHeight),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        okButt(screenHeight, screenWidth, roomSize, getDate, roomNum)
      ],
    );
  }

  Container okButt(screenHeight, screenWidth, roomSize, getDate, roomNum) {
    return Container(
      child: ElevatedButton(
        onPressed: () {
          if ((timeisPressed ||
                  timeisPressed2 ||
                  timeisPressed3 ||
                  timeisPressed4 ||
                  timeisPressed5 ||
                  timeisPressed6 ||
                  timeisPressed7 ||
                  timeisPressed8 ||
                  timeisPressed9 ||
                  timeisPressed10 ||
                  timeisPressed11 ||
                  timeisPressed12) &&
              (roomisPressed ||
                  roomisPressed2 ||
                  roomisPressed3 ||
                  roomisPressed4 ||
                  roomisPressed5)) {
            openDialog(context, screenHeight, screenWidth, roomSize, getDate,
                roomNum, timeSpace);
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor:
                      Colors.transparent, // ตั้งค่าสีพื้นหลังเป็น透ทน
                  content: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF103663), // สีพื้นหลังของ AlertDialog
                      borderRadius: BorderRadius.circular(10), // ขอบมน
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(16),
                              child: Text(
                                "เงื่อนไขไม่ตรงตามที่กำหนด",
                                style: GoogleFonts.kanit(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(16),
                              child: Text(
                                "กรุณาเลือกห้องและเวลาในการจอง",
                                style: GoogleFonts.kanit(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "ตกลง",
                                style: GoogleFonts.kanit(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          side: BorderSide(width: 0, color: Colors.black),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          'ตกลง',
          style: GoogleFonts.kanit(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Future<bool> insertReservation(Reservation reservation) async {
    final mongo.Db db = await mongo.Db.create(
        "mongodb+srv://Meephrom:PTxSACWX08jHQuDm@meephrom.byzuncl.mongodb.net/Meephrom?retryWrites=true&w=majority");
    await db.open();

    final reservations = db.collection('reservations');
    final myHistory = db.collection('history_Reservations');

    // แปลงอ็อบเจ็กต์ Reservation เป็น Map เพื่อทำการแทรก
    final Map<String, dynamic> data = {
      'UserId': reservation.userId,
      'roomSize': reservation.roomSize,
      'roomNum': reservation.roomNum,
      'date': reservation.date,
      'time': reservation.time,
    };

    // ตรวจสอบว่าข้อมูลซ้ำหรือไม่
    final existingData = await reservations.findOne({
      'roomNum': reservation.roomNum,
      'date': reservation.date,
      'time': reservation.time,
    });

    if (existingData == null) {
      // ถ้าไม่ซ้ำให้ทำการแทรกข้อมูล
      await reservations.insert(data);
      await myHistory.insert(data);
      return true; // แทรกข้อมูลสำเร็จ
    } else {
      // ถ้าซ้ำให้แสดง Dialog หรือแจ้งเตือนว่าไม่สามารถจองได้
      print('ไม่สามารถจองได้ เนื่องจากมีข้อมูลที่ซ้ำกัน');

      return false; // แทรกข้อมูลไม่สำเร็จ
    }
  }

  Future<void> openDialog(BuildContext context, screenHeight, screenWidth,
      roomSize, getDate, roomNum, timeSpace) async {
    String userId = widget.userId;

    Reservation reservation = Reservation(
      userId: userId,
      roomSize: roomSize,
      roomNum: roomNum,
      date: getDate,
      time: timeSpace,
    );

    await showDialog(
      context: context,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: AlertDialog(
          contentPadding: EdgeInsets.all(0),
          backgroundColor: Colors.transparent,
          content: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            height: screenHeight * 0.7,
            child: Center(
              child: Container(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF103663),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'ยืนยันการจอง',
                          style: GoogleFonts.kanit(
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Image.asset('image/room.png'),
                    Text(
                      'ห้องขนาดไซส์ ${roomSize} ${roomNum}',
                      style: GoogleFonts.kanit(),
                    ),
                    Text(
                      'วัน ${getDate}',
                      style: GoogleFonts.kanit(),
                    ),
                    Text(
                      'เวลา ${timeSpace} น.',
                      style: GoogleFonts.kanit(),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: screenWidth * 0.4,
                      child: GestureDetector(
                        onTap: () async {
                          // เรียก insertReservation และรับค่าผลลัพธ์
                          bool isReservationSuccessful =
                              await insertReservation(reservation);

                          // ตรวจสอบผลลัพธ์และแสดง Dialog หรือทำการ Navigation ตามต้องการ
                          if (isReservationSuccessful) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Per_menu(userId: userId),
                              ),
                            );
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                                  child: AlertDialog(
                                    contentPadding: EdgeInsets.zero,
                                    backgroundColor: Colors.transparent,
                                    content: Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xFF103663),
                                        borderRadius: BorderRadius.circular(
                                          15.0,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Text(
                                              'จองไม่สำเร็จ',
                                              style: GoogleFonts.kanit(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Text(
                                              'ห้องนี้เวลานี้ถูกจองไปแล้ว. \nกรุณาลองใหม่อีกครั้ง.',
                                              style: GoogleFonts.kanit(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text(
                                                  'OK',
                                                  style: GoogleFonts.kanit(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF344E88),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'ยืนยันการจอง',
                                style: GoogleFonts.kanit(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column rowTime_1(roomSize, screenWidth, screeHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            setState(() {
              timeisPressed = false;
              timeisPressed2 = false;
              timeisPressed3 = false;
              timeisPressed4 = false;
              timeisPressed5 = false;
              timeisPressed6 = false;
              timeisPressed7 = false;
              timeisPressed8 = false;
              timeisPressed9 = false;
              timeisPressed10 = false;
              timeisPressed11 = false;
              timeisPressed12 = false;
              timeisPressed = !timeisPressed;
              timeSpace = '08:30 - 09.25';
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: timeisPressed ? Colors.blue : Colors.white,
            side: BorderSide(width: 2, color: Colors.black),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Container(
            width: screenWidth * 0.2,
            height: screeHeight * 0.06,
            child: Center(
              child: Text(
                '08:30 - 09:25',
                style: GoogleFonts.kanit(
                  color: Colors.black,
                  fontSize: 13.7,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            setState(() {
              timeisPressed = false;
              timeisPressed2 = false;
              timeisPressed3 = false;
              timeisPressed4 = false;
              timeisPressed5 = false;
              timeisPressed6 = false;
              timeisPressed7 = false;
              timeisPressed8 = false;
              timeisPressed9 = false;
              timeisPressed10 = false;
              timeisPressed11 = false;
              timeisPressed12 = false;
              timeisPressed2 = !timeisPressed2;
              timeSpace = '11:30 - 12:25';
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: timeisPressed2 ? Colors.blue : Colors.white,
            side: BorderSide(width: 2, color: Colors.black),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Container(
            width: screenWidth * 0.2,
            height: screeHeight * 0.06,
            child: Center(
              child: Text(
                '11:30 - 12:25',
                style: GoogleFonts.kanit(color: Colors.black),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            setState(() {
              timeisPressed = false;
              timeisPressed2 = false;
              timeisPressed3 = false;
              timeisPressed4 = false;
              timeisPressed5 = false;
              timeisPressed6 = false;
              timeisPressed7 = false;
              timeisPressed8 = false;
              timeisPressed9 = false;
              timeisPressed10 = false;
              timeisPressed11 = false;
              timeisPressed12 = false;
              timeisPressed3 = !timeisPressed3;
              timeSpace = '14:30 - 15:25';
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: timeisPressed3 ? Colors.blue : Colors.white,
            side: BorderSide(width: 2, color: Colors.black),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Container(
            width: screenWidth * 0.2,
            height: screeHeight * 0.06,
            child: Center(
              child: Text(
                '14:30 - 15:25',
                style: GoogleFonts.kanit(
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            setState(() {
              timeisPressed = false;
              timeisPressed2 = false;
              timeisPressed3 = false;
              timeisPressed4 = false;
              timeisPressed5 = false;
              timeisPressed6 = false;
              timeisPressed7 = false;
              timeisPressed8 = false;
              timeisPressed9 = false;
              timeisPressed10 = false;
              timeisPressed11 = false;
              timeisPressed12 = false;
              timeisPressed4 = !timeisPressed4;
              timeSpace = '17:30 - 18:25';
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: timeisPressed4 ? Colors.blue : Colors.white,
            side: BorderSide(width: 2, color: Colors.black),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Container(
            width: screenWidth * 0.2,
            height: screeHeight * 0.06,
            child: Center(
              child: Text(
                '17:30 - 18:25',
                style: GoogleFonts.kanit(color: Colors.black),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Column rowTime_2(roomSize, screenWidth, screeHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            setState(() {
              timeisPressed = false;
              timeisPressed2 = false;
              timeisPressed3 = false;
              timeisPressed4 = false;
              timeisPressed5 = false;
              timeisPressed6 = false;
              timeisPressed7 = false;
              timeisPressed8 = false;
              timeisPressed9 = false;
              timeisPressed10 = false;
              timeisPressed11 = false;
              timeisPressed12 = false;
              timeisPressed5 = !timeisPressed5;
              timeSpace = '09:30 - 10:25';
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: timeisPressed5 ? Colors.blue : Colors.white,
            side: BorderSide(width: 2, color: Colors.black),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Container(
            width: screenWidth * 0.2,
            height: screeHeight * 0.06,
            child: Center(
              child: Text(
                '09:30 - 10:25',
                style: GoogleFonts.kanit(color: Colors.black),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            setState(() {
              timeisPressed = false;
              timeisPressed2 = false;
              timeisPressed3 = false;
              timeisPressed4 = false;
              timeisPressed5 = false;
              timeisPressed6 = false;
              timeisPressed7 = false;
              timeisPressed8 = false;
              timeisPressed9 = false;
              timeisPressed10 = false;
              timeisPressed11 = false;
              timeisPressed12 = false;
              timeisPressed6 = !timeisPressed6;
              timeSpace = '12:30 - 13:25';
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: timeisPressed6 ? Colors.blue : Colors.white,
            side: BorderSide(width: 2, color: Colors.black),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Container(
            width: screenWidth * 0.2,
            height: screeHeight * 0.06,
            child: Center(
              child: Text(
                '12:30 - 13:25',
                style: GoogleFonts.kanit(color: Colors.black),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            setState(() {
              timeisPressed = false;
              timeisPressed2 = false;
              timeisPressed3 = false;
              timeisPressed4 = false;
              timeisPressed5 = false;
              timeisPressed6 = false;
              timeisPressed7 = false;
              timeisPressed8 = false;
              timeisPressed9 = false;
              timeisPressed10 = false;
              timeisPressed11 = false;
              timeisPressed12 = false;
              timeisPressed7 = !timeisPressed7;
              timeSpace = '15:30 - 16:25';
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: timeisPressed7 ? Colors.blue : Colors.white,
            side: BorderSide(width: 2, color: Colors.black),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Container(
            width: screenWidth * 0.2,
            height: screeHeight * 0.06,
            child: Center(
              child: Text(
                '15:30 - 16:25',
                style: GoogleFonts.kanit(
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            setState(() {
              timeisPressed = false;
              timeisPressed2 = false;
              timeisPressed3 = false;
              timeisPressed4 = false;
              timeisPressed5 = false;
              timeisPressed6 = false;
              timeisPressed7 = false;
              timeisPressed8 = false;
              timeisPressed9 = false;
              timeisPressed10 = false;
              timeisPressed11 = false;
              timeisPressed12 = false;
              timeisPressed8 = !timeisPressed8;
              timeSpace = '18:30 - 19:25';
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: timeisPressed8 ? Colors.blue : Colors.white,
            side: BorderSide(width: 2, color: Colors.black),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Container(
            width: screenWidth * 0.2,
            height: screeHeight * 0.06,
            child: Center(
              child: Text(
                '18:30 - 19:25',
                style: GoogleFonts.kanit(color: Colors.black),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Column rowTime_3(roomSize, screenWidth, screeHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            setState(() {
              timeisPressed = false;
              timeisPressed2 = false;
              timeisPressed3 = false;
              timeisPressed4 = false;
              timeisPressed5 = false;
              timeisPressed6 = false;
              timeisPressed7 = false;
              timeisPressed8 = false;
              timeisPressed9 = false;
              timeisPressed10 = false;
              timeisPressed11 = false;
              timeisPressed12 = false;
              timeisPressed9 = !timeisPressed9;
              timeSpace = '10:30 - 11:25';
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: timeisPressed9 ? Colors.blue : Colors.white,
            side: BorderSide(width: 2, color: Colors.black),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Container(
            width: screenWidth * 0.2,
            height: screeHeight * 0.06,
            child: Center(
              child: Text(
                '10:30 - 11:25',
                style: GoogleFonts.kanit(color: Colors.black),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            setState(() {
              timeisPressed = false;
              timeisPressed2 = false;
              timeisPressed3 = false;
              timeisPressed4 = false;
              timeisPressed5 = false;
              timeisPressed6 = false;
              timeisPressed7 = false;
              timeisPressed8 = false;
              timeisPressed9 = false;
              timeisPressed10 = false;
              timeisPressed11 = false;
              timeisPressed12 = false;
              timeisPressed10 = !timeisPressed10;
              timeSpace = '13:30 - 14:25';
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: timeisPressed10 ? Colors.blue : Colors.white,
            side: BorderSide(width: 2, color: Colors.black),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Container(
            width: screenWidth * 0.2,
            height: screeHeight * 0.06,
            child: Center(
              child: Text(
                '13:30 - 14:25',
                style: GoogleFonts.kanit(color: Colors.black),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            setState(() {
              timeisPressed = false;
              timeisPressed2 = false;
              timeisPressed3 = false;
              timeisPressed4 = false;
              timeisPressed5 = false;
              timeisPressed6 = false;
              timeisPressed7 = false;
              timeisPressed8 = false;
              timeisPressed9 = false;
              timeisPressed10 = false;
              timeisPressed11 = false;
              timeisPressed12 = false;
              timeisPressed11 = !timeisPressed11;
              timeSpace = '16:30 - 17:25';
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: timeisPressed11 ? Colors.blue : Colors.white,
            side: BorderSide(width: 2, color: Colors.black),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Container(
            width: screenWidth * 0.2,
            height: screeHeight * 0.06,
            child: Center(
              child: Text(
                '16:30 - 17:25',
                style: GoogleFonts.kanit(
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            setState(() {
              timeisPressed = false;
              timeisPressed2 = false;
              timeisPressed3 = false;
              timeisPressed4 = false;
              timeisPressed5 = false;
              timeisPressed6 = false;
              timeisPressed7 = false;
              timeisPressed8 = false;
              timeisPressed9 = false;
              timeisPressed10 = false;
              timeisPressed11 = false;
              timeisPressed12 = false;
              timeisPressed12 = !timeisPressed12;
              timeSpace = '19:30 - 20:25';
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: timeisPressed12 ? Colors.blue : Colors.white,
            side: BorderSide(width: 2, color: Colors.black),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Container(
            width: screenWidth * 0.2,
            height: screeHeight * 0.06,
            child: Center(
              child: Text(
                '19:30 - 20:25',
                style: GoogleFonts.kanit(color: Colors.black),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Column rowThrid(roomSize, screenWidth, screeHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            setState(() {
              roomisPressed = false;
              roomisPressed2 = false;
              roomisPressed3 = false;
              roomisPressed4 = false;
              roomisPressed5 = false;
              roomisPressed4 = !roomisPressed4;
              roomNum = "102";
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: roomisPressed4 ? Colors.blue : Color(0xFFE6EBFA),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Container(
            width: screenWidth * 0.1,
            height: screeHeight * 0.04,
            child: Center(
              child: Text(
                '${roomSize} 102',
                style: GoogleFonts.kanit(
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            setState(() {
              roomisPressed = false;
              roomisPressed2 = false;
              roomisPressed3 = false;
              roomisPressed4 = false;
              roomisPressed5 = false;
              roomisPressed5 = !roomisPressed5;
              roomNum = "205";
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: roomisPressed5 ? Colors.blue : Color(0xFFE6EBFA),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Container(
            width: screenWidth * 0.1,
            height: screeHeight * 0.04,
            child: Center(
              child: Text(
                '${roomSize} 205',
                style: GoogleFonts.kanit(
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Column rowTwo(roomSize, screenWidth, screeHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            setState(() {
              roomisPressed = false;
              roomisPressed2 = false;
              roomisPressed3 = false;
              roomisPressed4 = false;
              roomisPressed5 = false;
              roomisPressed = !roomisPressed;
              roomNum = '101';
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: roomisPressed ? Colors.blue : Color(0xFFE6EBFA),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Container(
            width: screenWidth * 0.1,
            height: screeHeight * 0.04,
            child: Center(
              child: Text(
                '${roomSize} 101',
                style: GoogleFonts.kanit(
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            setState(() {
              roomisPressed = false;
              roomisPressed2 = false;
              roomisPressed3 = false;
              roomisPressed4 = false;
              roomisPressed5 = false;
              roomisPressed2 = !roomisPressed2;
              roomNum = '103';
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: roomisPressed2 ? Colors.blue : Color(0xFFE6EBFA),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Container(
            width: screenWidth * 0.1,
            height: screeHeight * 0.04,
            child: Center(
              child: Text(
                '${roomSize} 103',
                style: GoogleFonts.kanit(
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            setState(() {
              roomisPressed = false;
              roomisPressed2 = false;
              roomisPressed3 = false;
              roomisPressed4 = false;
              roomisPressed5 = false;
              roomisPressed3 = !roomisPressed3;
              roomNum = '301';
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: roomisPressed3 ? Colors.blue : Color(0xFFE6EBFA),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Container(
            width: screenWidth * 0.1,
            height: screeHeight * 0.04,
            child: Center(
              child: Text(
                '${roomSize} 301',
                style: GoogleFonts.kanit(
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Container rowOne() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                height: 45,
              ),
              Text(
                '\nเลือกห้อง',
                style: GoogleFonts.kanit(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Column getHeader(double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 20,
        ),
        dateBox(screenWidth),
      ],
    );
  }

  Container dateBox(double screenWidth) {
    return Container(
      child: Center(
        child: Container(
          width: screenWidth * 0.6,
          decoration: BoxDecoration(
              color: Color(0xFFD9D9D9),
              border: Border.all(
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(10)),
          child: Text(
            widget.getDate,
            style: GoogleFonts.kanit(
              fontSize: 25,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  AppBar appbar(roomSize) {
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

  MaterialStateProperty<Color> getColor(
      Color color, MaterialColor colorPressed) {
    final getColor = (Set<MaterialState> states) {
      if (states.contains(MaterialState.pressed)) {
        return colorPressed;
      } else {
        return color;
      }
    };
    return MaterialStateProperty.resolveWith(getColor);
  }
}
