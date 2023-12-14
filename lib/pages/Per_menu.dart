import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meephrom/pages/History_Page.dart';
import 'package:meephrom/pages/RuleApp.dart';
import 'package:meephrom/pages/SelectRoom.dart';
import 'package:meephrom/pages/Set_Up.dart';
import 'dart:ui';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:mongo_dart/mongo_dart.dart' show Db, DbCollection;

class Per_menu extends StatefulWidget {
  final String userId;

  const Per_menu({Key? key, required this.userId}) : super(key: key);

  @override
  State<Per_menu> createState() => _Per_menuState();
}

class _Per_menuState extends State<Per_menu> {
  late String name = '';
  late String surname = '';
  late String phoneNumber = '';
  late String email = '';
  late String roomSize = '';
  late String roomNum = '';
  late String reservationDate = '';
  late String reservationTime = '';

  @override
  void initState() {
    super.initState();
    print('Init State called');
    // โหลดข้อมูลจาก MongoDB ที่นี่
    loadDataFromMongoDB(widget.userId);
  }

  Future<void> loadDataFromMongoDB(String userId) async {
    print('Loading data for UserId: $userId');
    final db = await Db.create(
        'mongodb+srv://Meephrom:PTxSACWX08jHQuDm@meephrom.byzuncl.mongodb.net/Meephrom?retryWrites=true&w=majority');

    try {
      await db.open();
      print('Connected to MongoDB');

      final collection = DbCollection(db, 'user');
      final reservationsCollection = DbCollection(db, 'reservations');

      // Print the userId to verify it's correct
      print('User ID: $userId');

      final Map<String, dynamic>? mongoData =
          await collection.findOne(mongo.where.eq('UserId', userId));
      print('Mongo Data: $mongoData');

      final Map<String, dynamic> userData = mongoData ??
          {
            'Name': 'Default Name',
            'Surname': 'Default Surname',
            'Phone_Number': 'Default Phone Number',
            'Email': 'Default Email',
          };

      final Map<String, dynamic> userReservationData =
          userData?['ReservationData'] ??
              {
                'roomSize': 'Default Room Size',
                'roomNum': 'Default Room Num',
                'date': 'Default Date',
                'time': 'Default Time',
              };

      final Map<String, dynamic>? reservationData = await reservationsCollection
          .findOne(mongo.where.eq('UserId', userId));
      print('Reservation Data: $reservationData');

      setState(() {
        name = userData['Name'] ?? 'Default Name';
        surname = userData['Surname'] ?? 'Default Surname';
        phoneNumber = userData['Phone_Number'] ?? 'Default Phone Number';
        email = userData['Email'] ?? 'Default Email';
        roomSize = reservationData?['roomSize'] ?? '';
        roomNum = reservationData?['roomNum'] ?? 'ยังไม่ได้ทำการจองห้อง';
        reservationDate = reservationData?['date'] ?? 'ยังไม่ได้ทำการจองห้อง';
        reservationTime = reservationData?['time'] ?? 'ยังไม่ได้ทำการจองห้อง';
      });
    } catch (e) {
      print('Failed to load data from MongoDB: $e');
    } finally {
      await db.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    print('UserId in Per_menu: ${widget.userId}');
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Center(
              child: Column(
                children: [
                  Perbox(screenWidth, screenHeight),
                  Butt_Can(screenWidth, screenHeight, context),
                  SizedBox(
                    height: 60,
                  ),
                  ButtOne(screenWidth, screenHeight, context),
                  SizedBox(
                    height: 20,
                  ),
                  ButtTwo(screenWidth, screenHeight, context),
                  SizedBox(
                    height: 20,
                  ),
                  ButtThree(screenWidth, screenHeight, context),
                  SizedBox(
                    height: 20,
                  ),
                  ButtFour(screenWidth, screenHeight, context),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget Butt_Can(double screenWidth, double screenHeight, context) {
    return GestureDetector(
      onTap: () {
        openDialog(context, screenHeight, screenWidth);
      },
      child: Container(
        margin: EdgeInsets.only(left: 170, top: 10),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 3),
              blurRadius: 5.0,
            )
          ],
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
        ),
        width: screenWidth * 0.4,
        height: screenHeight * 0.05,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'แก้ไขและยกเลิกการจอง',
                    style: GoogleFonts.kanit(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 203, 0, 0),
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

  Future<void> openDialog(
      BuildContext context, screenHeight, screenWidth) async {
    await showDialog(
      context: context,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3), // ทำให้พื้นหลังเบลอ
        child: AlertDialog(
          contentPadding: EdgeInsets.all(0),
          backgroundColor: Colors.transparent, // Set to transparent

          content: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            height: screenHeight * 0.3,
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
                          'ยกเลิกการจอง',
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
                    Text(
                      'ห้องขนาดไซส์ : $roomSize $roomNum',
                      style: GoogleFonts.kanit(),
                    ),
                    Text(
                      'วัน : $reservationDate',
                      style: GoogleFonts.kanit(),
                    ),
                    Text(
                      'เวลา : $reservationTime',
                      style: GoogleFonts.kanit(),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: screenWidth * 0.4,
                      child: GestureDetector(
                        onTap: () async {
                          // เรียกใช้ฟังก์ชัน cancelReservation เพื่อลบข้อมูลการจอง
                          await cancelReservation(widget.userId);
                          // ปิด Dialog
                          Navigator.pop(context);
                          // โหลดข้อมูลใหม่หลังจากยกเลิกการจอง
                          await loadDataFromMongoDB(widget.userId);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              Text(
                                'ยกเลิกการจอง',
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

  Future<void> cancelReservation(String userId) async {
    final db = await Db.create(
        'mongodb+srv://Meephrom:PTxSACWX08jHQuDm@meephrom.byzuncl.mongodb.net/Meephrom?retryWrites=true&w=majority');

    try {
      await db.open();
      print('Connected to MongoDB for cancellation');

      final reservationsCollection = DbCollection(db, 'reservations');

      // ลบข้อมูลการจองห้องที่เกี่ยวข้องกับ userId
      await reservationsCollection.remove(mongo.where.eq('UserId', userId));

      print('Reservation canceled for UserId: $userId');
    } catch (e) {
      print('Failed to cancel reservation: $e');
    } finally {
      await db.close();
    }
  }

  Widget ButtFour(double screenWidth, double screenHeight, context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Set_Up(userId: widget.userId)));
      },
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 3),
              blurRadius: 5.0,
            )
          ],
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
        ),
        width: screenWidth * 0.9,
        height: screenHeight * 0.1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 30),
            ),
            Image.asset(
              'image/setting.png',
              width: 40,
              height: 40,
            ),
            SizedBox(
              width: 90,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ตั้งค่า',
                    style: GoogleFonts.kanit(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  Text(
                    'กดเพื่อตั้งค่า',
                    style: GoogleFonts.kanit(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget ButtThree(double screenWidth, double screenHeight, context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => RuleApp()));
      },
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0, 3),
                blurRadius: 5.0,
              )
            ],
            borderRadius: BorderRadius.circular(10),
            color: Color.fromARGB(255, 255, 255, 255),
            border: Border.all(
              color: Colors.black,
              width: 1,
            )),
        width: screenWidth * 0.9,
        height: screenHeight * 0.1,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 30),
              ),
              Image.asset(
                'image/rule.png',
                width: 40,
                height: 40,
              ),
              SizedBox(
                width: 50,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ระเบียบการใช้งาน',
                    style: GoogleFonts.kanit(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  Text(
                    'กดเพื่อดูระเบียบการใช้งาน',
                    style: GoogleFonts.kanit(),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget ButtTwo(double screenWidth, double screenHeight, context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => History_page(userId: widget.userId)));
      },
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 3),
              blurRadius: 5.0,
            )
          ],
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(255, 255, 255, 255),
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
        ),
        width: screenWidth * 0.9,
        height: screenHeight * 0.1,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 30),
              ),
              Image.asset(
                'image/his.png',
                width: 40,
                height: 40,
              ),
              SizedBox(
                width: 30,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ประวัติการจองห้อง',
                    style: GoogleFonts.kanit(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  Text(
                    'กดเพื่อดูประวัติการจองย้อนหลัง',
                    style: GoogleFonts.kanit(),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget ButtOne(double screenWidth, double screenHeight, context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => selectRoom(userId: widget.userId)));
      },
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 3),
              blurRadius: 5.0,
            )
          ],
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
        ),
        width: screenWidth * 0.9,
        height: screenHeight * 0.1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 30),
            ),
            Image.asset(
              'image/Jongroom.png',
              width: 40,
              height: 40,
            ),
            SizedBox(
              width: 70,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'จองห้อง',
                    style: GoogleFonts.kanit(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  Text(
                    'กดเพื่อเข้าจองห้อง',
                    style: GoogleFonts.kanit(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget Perbox(double screenWidth, double screenHeight) {
    return Container(
      width: screenWidth * 0.9,
      height: screenHeight * 0.25,
      margin: EdgeInsets.only(top: 50),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xFF485E82),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: Offset(0, 3),
            blurRadius: 5.0,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Row(
                  children: [
                    Image.asset(
                      'image/per.png',
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      '$name $surname ',
                      style: GoogleFonts.kanit(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                width: screenWidth * 0.8,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(20), // กำหนด borderRadius ที่นี่
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'เบอร์โทร : $phoneNumber',
            style: GoogleFonts.kanit(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 15,
            ),
          ),
          Text(
            'อีเมล์ : $email',
            style: GoogleFonts.kanit(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 15,
            ),
          )
        ],
      ),
    );
  }
}
