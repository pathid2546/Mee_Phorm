import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RuleApp extends StatelessWidget {
  const RuleApp({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: appbar(context),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 30, top: 30, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ruleOne(),
            Box(),
            ruleTwo(),
            Box(),
            ruleThree(),
            Box(),
            ruleFour(),
            Box(),
            ruleFive(),
            Box(),
            ruleSix(),
            Box(),
            floorOne(screenWidth, screenHeight),
            floorTwo(screenWidth, screenHeight),
            floorThree(screenWidth, screenHeight),
          ],
        ),
      ),
    );
  }

  Container floorOne(double screenWidth, double screenHeight) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ตัวอย่างห้องแต่ละชั้น',
            style: GoogleFonts.kanit(
              fontSize: 22,
            ),
          ),
          Box(),
          Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: screenWidth * 0.9,
                    height: screenHeight * 0.2,
                    decoration: BoxDecoration(
                      color: Color(0xFFD2FCFF),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 4,
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft * 0.9,
                      child: Image.asset(
                        'image/floor.png',
                        width: screenWidth * 0.45,
                        height: screenHeight * 0.2,
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                right: 24,
                top: screenHeight * 0.075,
                child: Container(
                  child: Text(
                    'ชั้นที่ 1   ',
                    style: GoogleFonts.kanit(
                      fontSize: 30,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Container floorTwo(double screenWidth, double screenHeight) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: screenWidth * 0.9,
                    height: screenHeight * 0.2,
                    decoration: BoxDecoration(
                      color: Color(0xFFD2FCFF),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 4,
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Align(
                      alignment: Alignment.centerRight * 0.9,
                      child: Image.asset(
                        'image/floor2.png',
                        width: screenWidth * 0.45,
                        height: screenHeight * 0.2,
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                left: 45,
                top: screenHeight * 0.075,
                child: Container(
                  child: Text(
                    'ชั้นที่ 2   ',
                    style: GoogleFonts.kanit(
                      fontSize: 30,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Container floorThree(double screenWidth, double screenHeight) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: screenWidth * 0.9,
                    height: screenHeight * 0.2,
                    decoration: BoxDecoration(
                      color: Color(0xFFD2FCFF),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 4,
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft * 0.9,
                      child: Image.asset(
                        'image/floor3.png',
                        width: screenWidth * 0.45,
                        height: screenHeight * 0.2,
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                right: 24,
                top: screenHeight * 0.075,
                child: Container(
                  child: Text(
                    'ชั้นที่ 3   ',
                    style: GoogleFonts.kanit(
                      fontSize: 30,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  SizedBox Box() {
    return SizedBox(
      height: 18,
    );
  }

  Container ruleOne() {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'สร้างบัญชีผู้ใช้',
          style: GoogleFonts.kanit(
            fontSize: 18,
            color: Colors.black,
          ),
          textAlign: TextAlign.left,
        ),
        Container(
          child: Text(
            ' แอปจองห้องจะต้องใช้บัญชีผู้ใช้จึงควรสร้างบัญชี',
            style: GoogleFonts.kanit(fontSize: 15, color: Color(0xFF0D1877)),
          ),
        ),
      ],
    ));
  }
}

Container ruleTwo() {
  return Container(
      child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'เลือกเวลาและวันที่',
        style: GoogleFonts.kanit(
          fontSize: 18,
          color: Colors.black,
        ),
        textAlign: TextAlign.left,
      ),
      Container(
        child: Text(
          ' เลือกวันและเวลาที่คุณต้องการจองห้อง',
          style: GoogleFonts.kanit(fontSize: 15, color: Color(0xFF0D1877)),
        ),
      ),
    ],
  ));
}

Container ruleThree() {
  return Container(
      child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'เลือกประเภทของห้อง',
        style: GoogleFonts.kanit(
          fontSize: 18,
          color: Colors.black,
        ),
        textAlign: TextAlign.left,
      ),
      Container(
        child: Text(
          ' ระบุประเภทของห้องที่คุณต้องการ',
          style: GoogleFonts.kanit(fontSize: 15, color: Color(0xFF0D1877)),
        ),
      ),
    ],
  ));
}

Container ruleFour() {
  return Container(
      child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'ทำการจอง',
        style: GoogleFonts.kanit(
          fontSize: 18,
          color: Colors.black,
        ),
        textAlign: TextAlign.left,
      ),
      Container(
        child: Text(
          ' -เลือกห้องประชุมตามขนาดและจำนวนคนที่รองรับ',
          style: GoogleFonts.kanit(fontSize: 15, color: Color(0xFF0D1877)),
        ),
      ),
      Container(
        child: Text(
          ' -ระบบสามารถจองห้องประชุมล่วงหน้าได้ถึง 14 วัน ',
          style: GoogleFonts.kanit(fontSize: 15, color: Color(0xFF0D1877)),
        ),
      ),
      Container(
        child: Text(
          ' -สามารถดูประวัติการจองของตนเองและแก้ไขหรือยกเลิกการจองก่อน 3 วันก่อน',
          style: GoogleFonts.kanit(fontSize: 15, color: Color(0xFF0D1877)),
        ),
      )
    ],
  ));
}

Container ruleFive() {
  return Container(
      child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'ปฏิบัติตามระเบียบ',
        style: GoogleFonts.kanit(
          fontSize: 18,
          color: Colors.black,
        ),
        textAlign: TextAlign.left,
      ),
      Container(
        child: Text(
          ' ปฏิบัติตามข้อบังคับและระเบียบของที่พักหรือสถานที่เช่น\nไม่เหมาะสำหรับการปาร์ตี้หรือสูบบุหรี่ในห้องสูบบุหรี่',
          style: GoogleFonts.kanit(fontSize: 15, color: Color(0xFF0D1877)),
        ),
      ),
    ],
  ));
}

Container ruleSix() {
  return Container(
      child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'การแจ้งเตือน',
        style: GoogleFonts.kanit(
          fontSize: 18,
          color: Colors.black,
        ),
        textAlign: TextAlign.left,
      ),
      Container(
        child: Text(
          ' ระบบจะส่งข้อความแจ้งเตือนให้ผู้ใช้เมื่อเข้าใกล้วันที่จองและเมื่อถึงเวลาการใช้งานห้อง',
          style: GoogleFonts.kanit(fontSize: 15, color: Color(0xFF0D1877)),
        ),
      ),
    ],
  ));
}

AppBar appbar(context) {
  return AppBar(
    title: Text(
      'ข้อมูลการใช้งาน',
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
