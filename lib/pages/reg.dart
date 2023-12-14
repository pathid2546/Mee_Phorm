import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meephrom/pages/HomeLogin.dart';
import 'dart:ui';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:mongo_dart/mongo_dart.dart' show ObjectId;
import 'package:crypto/crypto.dart';

const MONGO_URL =
    "mongodb+srv://Meephrom:PTxSACWX08jHQuDm@meephrom.byzuncl.mongodb.net/Meephrom?retryWrites=true&w=majority";

class User {
  String name;
  String surName;
  String phone;
  String email;
  String pass;

  User({
    required this.name,
    required this.surName,
    required this.phone,
    required this.email,
    required this.pass,
  });
}

String hashPassword(String password) {
  // ใช้ SHA-256 เป็นอัลกอริทึมในการ Hash Password
  var bytes = utf8.encode(password);
  var digest = sha256.convert(bytes);
  return digest.toString();
}

class regis extends StatefulWidget {
  const regis({Key? key}) : super(key: key);

  @override
  State<regis> createState() => _regisState();
}

class _regisState extends State<regis> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  User user = User(name: '', surName: '', phone: '', email: '', pass: '');
  bool redEye = true;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: appbar(context),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Center(
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
                      PassField(screenWidth),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                getButt(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<int> getLatestUserCount() async {
    try {
      final mongo.Db db = await mongo.Db.create(
          "mongodb+srv://Meephrom:PTxSACWX08jHQuDm@meephrom.byzuncl.mongodb.net/Meephrom?retryWrites=true&w=majority");
      await db.open();

      final mongo.DbCollection collection = db.collection('user');

      final Map<String, dynamic>? lastUser = await collection
          .find(mongo.where.sortBy('UserId', descending: true))
          .first;

      final int latestUserCount =
          lastUser != null ? int.parse(lastUser['UserId'].substring(4)) : 0;

      await db.close();

      return latestUserCount;
    } catch (e) {
      print('Error getting latest user count: $e');
      return 0;
    }
  }

  String generateFormattedUserId(int userCount) {
    final ObjectId objectId = ObjectId();
    final String objectIdSubstring = objectId.toHexString().substring(0, 6);

    userCount++;
    final String userNumber = (userCount % 999 + 1).toString().padLeft(3, '0');

    return 'User$userNumber';
  }

  Future<void> sendDataToMongoDB(BuildContext context, User user) async {
    try {
      final mongo.Db db = await mongo.Db.create(MONGO_URL);
      await db.open();

      final mongo.DbCollection collection = db.collection('user');

      // Check if the email already exists
      final existingUser =
          await collection.findOne(mongo.where.eq('Email', user.email));

      if (existingUser != null) {
        // Email already exists, show an error or handle it as needed
        print('Email already exists');
        showAlertDialog(
          context,
          'ไม่สำเร็จ',
          'Email มีอยู่ในระบบแล้ว',
        );
      } else {
        // Email doesn't exist, proceed with user registration
        final int latestUserCount = await getLatestUserCount();

        final String formattedUserId = generateFormattedUserId(latestUserCount);

        await collection.insert({
          "UserId": formattedUserId,
          "Name": user.name,
          "Surname": user.surName,
          "Phone_Number": user.phone,
          "Email": user.email,
          "Password": hashPassword(user.pass),
        });

        print('Data sent to MongoDB successfully');

        // Navigate to Login page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeLog(),
          ),
        );
      }

      await db.close();
    } catch (e) {
      print('Error sending data to MongoDB: $e');
      // Handle the error as needed
    }
  }

  Row getButt() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState?.validate() ?? false) {
              // ทำงานเมื่อฟอร์มถูกต้อง
              print('success');
              // Send data to MongoDB with the context
              await sendDataToMongoDB(context, user);

              // Navigate to LogIn page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeLog(),
                ),
              );
            } else {
              await showAlertDialog(
                context,
                'ข้อมูลไม่ครบ',
                'กรุณากรอกข้อมูลให้ครบทุกช่อง',
              );
            }
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
          ),
        ),
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
          ),
        ),
      ],
    );
  }

  Widget PassField(double screenWidth) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screenWidth * 0.7,
      child: TextFormField(
        onChanged: (value) => user.pass = value.trim(),
        style: GoogleFonts.kanit(color: Colors.white),
        obscureText: redEye,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                redEye = !redEye;
              });
            },
            icon: Icon(
              redEye
                  ? Icons.remove_red_eye_outlined
                  : Icons.remove_red_eye_sharp,
            ),
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          prefixIcon: Icon(
            Icons.key,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          labelText: 'Password:',
          labelStyle: GoogleFonts.kanit(color: Colors.white),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
          ),
          errorStyle: GoogleFonts.kanit(color: Colors.yellow, fontSize: 15),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.yellow),
          ),
        ),
        validator: (value) {
          if (value?.isEmpty ?? true) {
            return 'กรุณากรอกรหัสผ่าน';
          } else if (value!.length < 8) {
            return 'รหัสผ่านต้องมีอย่างน้อย 8 ตัว';
          } else if (!RegExp(r'(?=.*[a-zA-Z])(?=.*[0-9])').hasMatch(value)) {
            return 'รหัสผ่านต้องประกอบด้วยตัวอักษรและตัวเลข';
          }
          return null;
        },
      ),
    );
  }

  Widget getName(double screenWidth) {
    return Container(
      width: screenWidth * 0.7,
      child: TextFormField(
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        onChanged: (value) => user.name = value.trim(),
        style: GoogleFonts.kanit(color: Colors.white),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.perm_identity,
            color: Colors.white,
          ),
          hintStyle: TextStyle(color: Colors.white),
          labelText: 'Name:',
          labelStyle: GoogleFonts.kanit(color: Colors.white),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.white),
          ),
          errorStyle: GoogleFonts.kanit(color: Colors.yellow, fontSize: 15),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.yellow),
          ),
        ),
        validator: (value) {
          if (value?.isEmpty ?? true) {
            return 'กรุณากรอกชื่อ';
          } else if (!RegExp(r'^[a-zA-Z\u0E00-\u0E7F]+$').hasMatch(value!)) {
            return 'ชื่อต้องประกอบด้วยตัวอักษรเท่านั้น';
          }
          return null;
        },
      ),
    );
  }

  Widget getSurname(double screenWidth) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screenWidth * 0.7,
      child: TextFormField(
        onChanged: (value) => user.surName = value.trim(),
        style: GoogleFonts.kanit(color: Colors.white),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.perm_identity,
            color: Colors.white,
          ),
          labelText: 'Surname:',
          labelStyle: GoogleFonts.kanit(color: Colors.white),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.white),
          ),
          errorStyle: GoogleFonts.kanit(color: Colors.yellow, fontSize: 15),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.yellow),
          ),
        ),
        validator: (value) {
          if (value?.isEmpty ?? true) {
            return 'กรุณากรอกนามสกุล';
          } else if (!RegExp(r'^[a-zA-Z\u0E00-\u0E7F]+$').hasMatch(value!)) {
            return 'นามสกุลต้องประกอบด้วยตัวอักษรเท่านั้น';
          }
          return null;
        },
      ),
    );
  }

  Widget getPhone(double screenWidth) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screenWidth * 0.7,
      child: TextFormField(
        onChanged: (value) => user.phone = value.trim(),
        style: GoogleFonts.kanit(color: Colors.white),
        keyboardType:
            TextInputType.phone, // Set keyboard type to handle numeric input
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly
        ], // Allow only digits
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.phone,
            color: Colors.white,
          ),
          labelText: 'Phone:',
          labelStyle: GoogleFonts.kanit(color: Colors.white),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.white),
          ),
          errorStyle: GoogleFonts.kanit(color: Colors.yellow, fontSize: 15),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.yellow),
          ),
        ),
        validator: (value) {
          if (value?.isEmpty ?? true) {
            return 'กรุณากรอกเบอร์โทรศัพท์';
          } else if (value!.length != 10) {
            return 'เบอร์โทรศัพท์ต้องมี 10 หลัก';
          }
          return null;
        },
      ),
    );
  }

  Widget getEmail(double screenWidth) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screenWidth * 0.7,
      child: TextFormField(
        onChanged: (value) => user.email = value.trim(),
        style: GoogleFonts.kanit(color: Colors.white),
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.email_outlined,
            color: Colors.white,
          ),
          labelText: 'Email :',
          labelStyle: GoogleFonts.kanit(color: Colors.white),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.white),
          ),
          errorStyle: GoogleFonts.kanit(color: Colors.yellow, fontSize: 15),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.yellow),
          ),
        ),
        validator: (value) {
          if (value?.isEmpty ?? true) {
            return 'กรุณากรอกอีเมล';
          }
          // เพิ่มเงื่อนไขในการตรวจสอบรูปแบบของอีเมล์
          if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
              .hasMatch(value!)) {
            return 'รูปแบบอีเมลไม่ถูกต้อง';
          }
          return null;
        },
      ),
    );
  }

  AppBar appbar(context) {
    return AppBar(
      title: Text(
        'กรอกข้อมูล',
        style: GoogleFonts.kanit(
          fontSize: 30,
          fontWeight: FontWeight.w600,
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
            color: Color(0xFF042B7E),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: AlertDialog(
            backgroundColor: Color(0xFF103663),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0), // กำหนดขอบมน
            ),
            title: Text(
              title,
              style: GoogleFonts.kanit(
                color: Colors.white,
              ),
            ),
            content: Text(
              content,
              style: GoogleFonts.kanit(
                color: Colors.white,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // ปิด Dialog
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
        );
      },
    );
  }
}
