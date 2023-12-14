import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meephrom/pages/Room.dart';

class selectRoom extends StatefulWidget {
  final String userId;

  const selectRoom({Key? key, required this.userId}) : super(key: key);

  @override
  State<selectRoom> createState() => _selectRoomState();
}

class _selectRoomState extends State<selectRoom> {
  @override
  Widget build(BuildContext context) {
    print('UserId in SelectRoom: ${widget.userId}');
    double screenWidth = MediaQuery.of(context).size.width;
    double screeHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: appbar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          children: [
            RoomSizeS(screenWidth, screeHeight, context),
            SizeBee(),
            RoomSizeM(screenWidth, screeHeight, context),
            SizeBee(),
            RoomSizeL(screenWidth, screeHeight, context),
          ],
        ),
      ),
    );
  }

  SizedBox SizeBee() {
    return const SizedBox(
      height: 20,
    );
  }

  Widget RoomSizeL(double screenWidth, double screeHeight, context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Room(roomSize: 'L', userId: widget.userId)),
          );
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                width: 2,
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(20)),
          width: screenWidth * 0.9,
          height: screeHeight * 0.2,
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 30,
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF1000C7),
                    ),
                    child: Center(
                      child: Text(
                        'L',
                        style: GoogleFonts.kanit(
                          fontSize: 70,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ห้องขนาด L',
                        style: GoogleFonts.kanit(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'ไม่เกิน 25 คน',
                        style: GoogleFonts.kanit(
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Center RoomSizeM(double screenWidth, double screeHeight, context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Room(roomSize: 'M', userId: widget.userId),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                width: 2,
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(20)),
          width: screenWidth * 0.9,
          height: screeHeight * 0.2,
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 30,
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF1000C7),
                    ),
                    child: Center(
                      child: Text(
                        'M',
                        style: GoogleFonts.kanit(
                          fontSize: 70,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ห้องขนาด M',
                        style: GoogleFonts.kanit(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'ไม่เกิน 15 คน',
                        style: GoogleFonts.kanit(
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Center RoomSizeS(double screenWidth, double screeHeight, context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Room(roomSize: 'S', userId: widget.userId)),
          );
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                width: 2,
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(20)),
          width: screenWidth * 0.9,
          height: screeHeight * 0.2,
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 30,
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF1000C7),
                    ),
                    child: Center(
                      child: Text(
                        'S',
                        style: GoogleFonts.kanit(
                          fontSize: 70,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ห้องขนาด S',
                        style: GoogleFonts.kanit(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'ไม่เกิน 8 คน',
                        style: GoogleFonts.kanit(
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  AppBar appbar() {
    return AppBar(
      title: Text(
        'เลือกขนาดห้อง',
        style: GoogleFonts.kanit(
          fontSize: 30,
          fontWeight: FontWeight.w300,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      backgroundColor: const Color(0xFF1846AA),
      elevation: 0.0,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          margin: const EdgeInsets.all(10),
          alignment: Alignment.center,
          child: SvgPicture.asset(
            'assets/icons/arrow.svg',
            height: 25,
            width: 25,
          ),
          decoration: BoxDecoration(
              color: const Color(0xFF042B7E),
              borderRadius: BorderRadius.circular(5)),
        ),
      ),
    );
  }
}
