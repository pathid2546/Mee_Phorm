// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:meephrom/pages/History_Page.dart';
// import 'package:meephrom/pages/PerIn.dart';
// import 'package:meephrom/pages/RuleApp.dart';
// import 'package:meephrom/pages/SelectRoom.dart';
// import 'package:meephrom/pages/Set_Up.dart';

// class main_Manu extends StatelessWidget {
//   const main_Manu({super.key});

//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Stack(
//           children: [
//             Center(
//               child: Column(
//                 children: [
//                   Perbox(screenWidth, screenHeight, context),
//                   SizedBox(
//                     height: 60,
//                   ),
//                   ButtOne(screenWidth, screenHeight, context),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   ButtTwo(screenWidth, screenHeight, context),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   ButtThree(screenWidth, screenHeight, context),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   ButtFour(screenWidth, screenHeight, context),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget ButtFour(double screenWidth, double screenHeight, context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//             context, MaterialPageRoute(builder: (context) => Set_Up()));
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey,
//               offset: Offset(0, 3),
//               blurRadius: 5.0,
//             )
//           ],
//           color: Color.fromARGB(255, 255, 255, 255),
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(
//             color: Colors.black,
//             width: 1,
//           ),
//         ),
//         width: screenWidth * 0.9,
//         height: screenHeight * 0.1,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Padding(
//               padding: EdgeInsets.only(left: 30),
//             ),
//             Image.asset(
//               'image/setting.png',
//               width: 40,
//               height: 40,
//             ),
//             SizedBox(
//               width: 90,
//             ),
//             Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'ตั้งค่า',
//                     style: GoogleFonts.kanit(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w500,
//                       color: const Color.fromARGB(255, 0, 0, 0),
//                     ),
//                   ),
//                   Text(
//                     'กดเพื่อตั้งค่า',
//                     style: GoogleFonts.kanit(),
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget ButtThree(double screenWidth, double screenHeight, context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//             context, MaterialPageRoute(builder: (context) => RuleApp()));
//       },
//       child: Container(
//         decoration: BoxDecoration(
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey,
//                 offset: Offset(0, 3),
//                 blurRadius: 5.0,
//               )
//             ],
//             borderRadius: BorderRadius.circular(10),
//             color: Color.fromARGB(255, 255, 255, 255),
//             border: Border.all(
//               color: Colors.black,
//               width: 1,
//             )),
//         width: screenWidth * 0.9,
//         height: screenHeight * 0.1,
//         child: Center(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(left: 30),
//               ),
//               Image.asset(
//                 'image/rule.png',
//                 width: 40,
//                 height: 40,
//               ),
//               SizedBox(
//                 width: 50,
//               ),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'ระเบียบการใช้งาน',
//                     style: GoogleFonts.kanit(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w500,
//                       color: const Color.fromARGB(255, 0, 0, 0),
//                     ),
//                   ),
//                   Text(
//                     'กดเพื่อดูระเบียบการใช้งาน',
//                     style: GoogleFonts.kanit(),
//                   )
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget ButtTwo(double screenWidth, double screenHeight, context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//             context, MaterialPageRoute(builder: (context) => History_page()));
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey,
//               offset: Offset(0, 3),
//               blurRadius: 5.0,
//             )
//           ],
//           borderRadius: BorderRadius.circular(10),
//           color: Color.fromARGB(255, 255, 255, 255),
//           border: Border.all(
//             color: Colors.black,
//             width: 1,
//           ),
//         ),
//         width: screenWidth * 0.9,
//         height: screenHeight * 0.1,
//         child: Center(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(left: 30),
//               ),
//               Image.asset(
//                 'image/his.png',
//                 width: 40,
//                 height: 40,
//               ),
//               SizedBox(
//                 width: 30,
//               ),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'ประวัติการจองห้อง',
//                     style: GoogleFonts.kanit(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w500,
//                       color: const Color.fromARGB(255, 0, 0, 0),
//                     ),
//                   ),
//                   Text(
//                     'กดเพื่อดูประวัติการจองย้อนหลัง',
//                     style: GoogleFonts.kanit(),
//                   )
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget ButtOne(double screenWidth, double screenHeight, context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//             context, MaterialPageRoute(builder: (context) => selectRoom(userId: widget.userId)));
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey,
//               offset: Offset(0, 3),
//               blurRadius: 5.0,
//             )
//           ],
//           color: Color.fromARGB(255, 255, 255, 255),
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(
//             color: Colors.black,
//             width: 1,
//           ),
//         ),
//         width: screenWidth * 0.9,
//         height: screenHeight * 0.1,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Padding(
//               padding: EdgeInsets.only(left: 30),
//             ),
//             Image.asset(
//               'image/Jongroom.png',
//               width: 40,
//               height: 40,
//             ),
//             SizedBox(
//               width: 70,
//             ),
//             Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'จองห้อง',
//                     style: GoogleFonts.kanit(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w500,
//                       color: const Color.fromARGB(255, 0, 0, 0),
//                     ),
//                   ),
//                   Text(
//                     'กดเพื่อเข้าจองห้อง',
//                     style: GoogleFonts.kanit(),
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget Perbox(double screenWidth, double screenHeight, context) {
//     return Container(
//       width: screenWidth * 0.9,
//       height: screenHeight * 0.3,
//       margin: EdgeInsets.only(top: 50),
//       padding: EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         color: Color(0xFF485E82),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black,
//             offset: Offset(0, 3),
//             blurRadius: 5.0,
//           ),
//         ],
//       ),
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   child: Row(
//                     children: [
//                       Image.asset(
//                         'image/per.png',
//                       ),
//                       SizedBox(
//                         width: 20,
//                       ),
//                       Text(
//                         'Name : Surname : ',
//                         style: GoogleFonts.kanit(),
//                       ),
//                     ],
//                   ),
//                   width: screenWidth * 0.8,
//                   height: 60,
//                   decoration: BoxDecoration(
//                     borderRadius:
//                         BorderRadius.circular(20), // กำหนด borderRadius ที่นี่
//                     color: Colors.white,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 50,
//             ),
//             Align(
//               alignment: Alignment.center,
//               child: TextButton(
//                 onPressed: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => PerIn()));
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   width: 100,
//                   height: 40,
//                   child: Center(
//                     child: Text(
//                       'กรอกข้อมูล',
//                       style: GoogleFonts.kanit(
//                         color: Color(0xFF4195CC),
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
