import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meephrom/pages/HomeLogin.dart';
import 'package:meephrom/pages/PerEdit.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class Set_Up extends StatefulWidget {
  final String userId;
  const Set_Up({Key? key, required this.userId}) : super(key: key);

  @override
  State<Set_Up> createState() => _Set_UpState();
}

class _Set_UpState extends State<Set_Up> {
  bool switchValue_1 = true;
  bool switchValue_2 = true;
  @override
  Widget build(BuildContext context) {
    print('UserId in Set Up Page: ${widget.userId}');
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: appbar(),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(30),
            width: screenWidth,
            height: screenheight * 0.85,
            color: const Color.fromARGB(255, 255, 255, 255),
            child: Column(
              children: [
                SizedBox(
                  height: 35,
                ),
                NotiButt(),
                mailNoti(),
                editButt(context),
                logOutButt(),
              ],
            ),
          ),
        ));
  }

  Container logOutButt() {
    return Container(
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.logout_outlined,
            size: 40,
          ),
          Text(
            'ออกจากระบบ',
            style: GoogleFonts.kanit(
              fontSize: 20,
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
              ),
            ),
            child: Text(
              'Log Out',
              style: GoogleFonts.kanit(),
            ),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeLog()),
                (Route<dynamic> route) =>
                    false, // Remove all routes from the stack
              );
            },
          )
        ],
      ),
    );
  }

  Container editButt(BuildContext context) {
    return Container(
      height: 65,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.edit_note_outlined,
            size: 40,
          ),
          Text(
            'แก้ไขข้อมูล',
            style: GoogleFonts.kanit(
              fontSize: 20,
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Color(0xff4D6FBC)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
              ),
            ),
            child: Text(
              '   แก้ไข   ',
              style: GoogleFonts.kanit(),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PerEdit(userId: widget.userId)));
            },
          )
        ],
      ),
    );
  }

  Container mailNoti() {
    return Container(
      height: 65,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.email_outlined,
            size: 40,
          ),
          Text(
            'การเเจ้งเตือนใน E-mail',
            style: GoogleFonts.kanit(
              fontSize: 20,
            ),
          ),
          Switch(
            value: switchValue_2,
            onChanged: (value) {
              setState(() {
                switchValue_2 = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Container NotiButt() {
    return Container(
      height: 65,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.notifications_outlined,
            size: 40,
          ),
          Text(
            'การเเจ้งเตือนแอปพลิเคชั่น',
            style: GoogleFonts.kanit(
              fontSize: 20,
            ),
          ),
          Switch(
            value: switchValue_1,
            onChanged: (value) {
              setState(() {
                switchValue_1 = value;
              });
            },
          ),
        ],
      ),
    );
  }

  AppBar appbar() {
    return AppBar(
      title: Text(
        'การตั้งค่า',
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
