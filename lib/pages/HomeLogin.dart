// ignore_for_file: use_build_context_synchronously

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meephrom/pages/Per_menu.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:meephrom/pages/reg.dart';

class HomeLog extends StatefulWidget {
  const HomeLog({Key? key}) : super(key: key);

  @override
  State<HomeLog> createState() => _HomeLogState();
}

class _HomeLogState extends State<HomeLog> {
  bool redEye = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ลงทะเบียน',
          style: GoogleFonts.kanit(
            fontSize: 30,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF1846AA),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            logoPic(screenWidth, screenHeight),
          ],
        ),
      ),
    );
  }

  Container logoPic(double screenWidth, double screenHeight) {
    return Container(
      padding: EdgeInsets.only(top: 100),
      width: screenWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: AssetImage('image/logo.png'),
            width: 100,
            height: 100,
          ),
          EmailField(screenWidth),
          PassField(screenWidth),
          SizedBox(
            height: 20,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buttLog(screenWidth, screenHeight),
                  SizedBox(
                    width: 20,
                  ),
                  buttLog2(screenWidth, screenHeight),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container PassField(double screenWidth) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: screenWidth * 0.8,
      child: TextField(
        controller: passwordController,
        obscureText: redEye,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                redEye = !redEye;
              });
            },
            icon: Icon(redEye
                ? Icons.remove_red_eye_outlined
                : Icons.remove_red_eye_sharp),
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
          prefixIcon: Icon(
            Icons.key_outlined,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
          labelText: 'Password :',
          labelStyle: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: const Color.fromARGB(255, 0, 0, 0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: const Color.fromARGB(255, 0, 0, 0)),
          ),
        ),
      ),
    );
  }

  Container EmailField(double screenWidth) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: screenWidth * 0.8,
      child: TextField(
        controller: emailController,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.perm_identity,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
          labelText: 'Email :',
          labelStyle: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: const Color.fromARGB(255, 0, 0, 0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: const Color.fromARGB(255, 0, 0, 0)),
          ),
        ),
      ),
    );
  }

  Container buttLog(double screenWidth, double screenHeight) {
    return Container(
      width: screenWidth * 0.4,
      height: screenHeight * 0.08,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0, 3),
            blurRadius: 5.0,
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          // เรียกใช้ฟังก์ชัน login ที่คุณสร้างไว้
          login();
        },
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Image(
                  width: 50,
                  height: 55,
                  image: AssetImage('image/LogIn.jpg'),
                ),
              ),
              Text(
                'เข้าสู่ระบบ',
                style: GoogleFonts.kanit(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buttLog2(double screenWidth, double screenHeight) {
    return Container(
      width: screenWidth * 0.4,
      height: screenHeight * 0.08,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0, 3),
            blurRadius: 5.0,
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          // นำทางไปยังหน้าลงทะเบียน
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => regis()));
        },
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Image(
                  width: 40,
                  height: 40,
                  image: AssetImage('image/regis.png'),
                ),
              ),
              Text(
                'ลงทะเบียน',
                style: GoogleFonts.kanit(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void login() async {
    final mongo.Db db = await mongo.Db.create(
      "mongodb+srv://Meephrom:PTxSACWX08jHQuDm@meephrom.byzuncl.mongodb.net/Meephrom?retryWrites=true&w=majority",
    );
    await db.open();

    final mongo.DbCollection collection = db.collection('user');

    final String email = emailController.text.trim();
    final String password = hashPassword(passwordController.text);

    final result = await collection.findOne({
      "Email": email,
      "Password": password,
    });

    await db.close();

    print('ผลลัพธ์การเข้าสู่ระบบ: $result');

    if (result != null) {
      print('เข้าสู่ระบบสำเร็จ');

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Per_menu(userId: result['UserId']),
        ),
      );
    } else {
      print('เข้าสู่ระบบไม่สำเร็จ');
      // Show a dialog with an error message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: AlertDialog(
              contentPadding: EdgeInsets.zero, // Remove default padding
              backgroundColor:
                  Colors.transparent, // Make the background transparent
              content: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF103663),
                  borderRadius: BorderRadius.circular(
                      15.0), // Adjust the radius as needed
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'เข้าสู่ระบบไม่สำเร็จ',
                        style: GoogleFonts.kanit(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'อีเมล หรือ รหัสผ่านไม่ถูกต้อง. \nกรุณาลองใหม่อีกครั้ง.',
                        style: GoogleFonts.kanit(color: Colors.white),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                          child: Text(
                            'OK',
                            style: GoogleFonts.kanit(color: Colors.white),
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
  }
}
