import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class PerIn extends StatelessWidget {
  const PerIn({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: appbar(context),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Center(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xFF485E82),
                      ),
                      child: Column(
                        children: [
                          getName(screenWidth),
                          getSurname(screenWidth),
                          getPhone(screenWidth),
                          getEmail(screenWidth),
                        ],
                      ),
                    ),
                    SizedBox(height: 40),
                    getButt(context)
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Row getButt(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            onPressed: () {
              print('Success');
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
              onPrimary: Colors.white,
            ),
            child: Text(
              'ยืนยัน',
              style: GoogleFonts.kanit(
                fontSize: 25,
              ),
            )),
        SizedBox(width: 50),
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
              onPrimary: Colors.white,
            ),
            child: Text(
              'ยกเลิก',
              style: GoogleFonts.kanit(
                fontSize: 25,
              ),
            ))
      ],
    );
  }

  Widget getName(double screenWidth) {
    return Container(
      width: screenWidth * 0.7,
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.perm_identity,
            color: Colors.white,
          ),
          labelText: 'Name :',
          labelStyle: TextStyle(color: Colors.white),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.white)),
        ),
      ),
    );
  }

  Widget getSurname(double screenWidth) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screenWidth * 0.7,
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.perm_identity,
            color: Colors.white,
          ),
          labelText: 'Surname :',
          labelStyle: TextStyle(color: Colors.white),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.white)),
        ),
      ),
    );
  }

  Widget getPhone(double screenWidth) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screenWidth * 0.7,
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.perm_identity,
            color: Colors.white,
          ),
          labelText: 'Phone :',
          labelStyle: TextStyle(color: Colors.white),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.white)),
        ),
      ),
    );
  }

  Widget getEmail(double screenWidth) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screenWidth * 0.7,
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.perm_identity,
            color: Colors.white,
          ),
          labelText: 'Email :',
          labelStyle: TextStyle(color: Colors.white),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.white)),
        ),
      ),
    );
  }

  AppBar appbar(context) {
    return AppBar(
      title: Text(
        'กรอกข้อมูล',
        style: GoogleFonts.kanit(
            fontSize: 30, fontWeight: FontWeight.w600, color: Colors.white),
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
