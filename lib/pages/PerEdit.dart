import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class PerEdit extends StatefulWidget {
  final String userId;
  const PerEdit({Key? key, required this.userId}) : super(key: key);

  @override
  State<PerEdit> createState() => _PerEditState();
}

class _PerEditState extends State<PerEdit> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print('UserId in Edit Data User: ${widget.userId}');
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
                        Text(
                          'กรอกข้อมูลให้ครบทุกช่อง',
                          style: GoogleFonts.kanit(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        getName(screenWidth),
                        getSurname(screenWidth),
                        getPhone(screenWidth),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                  getButt()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showUpdateSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: AlertDialog(
                backgroundColor: Color(0xFF103663),
                contentPadding: EdgeInsets.all(16),
                title: Text(
                  'แก้ไขข้อมูลสำเร็จ',
                  style: GoogleFonts.kanit(
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.left,
                ),
                content: Text(
                  'ข้อมูลของคุณได้รับการแก้ไขเรียบร้อยแล้ว\nกรูณาเข้าสู่ระบบใหม่เพื่อตรวจสอบ',
                  style: GoogleFonts.kanit(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.left,
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                      Navigator.of(context).pop(); // Pop the screen
                    },
                    child: Text(
                      'ตกลง',
                      style: GoogleFonts.kanit(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void sendDataToMongoDB(BuildContext context, String userId, String name,
      String surname, String phone) {
    try {
      // Validate data before sending to MongoDB
      if (name.isEmpty || surname.isEmpty || phone.isEmpty) {
        // Show an error message or handle it in some way
        print('Please fill in all the required fields.');
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
                          'แก้ไขข้อมูลไม่สำเร็จ',
                          style: GoogleFonts.kanit(color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'กรุณาลองใหม่อีกครั้งกรอกข้อมูลให้ครบทุกช่อง',
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
        return;
      }

      // Assuming userId is the identifier for the document to update
      updateUserData(userId, name, surname, phone);

      // Perform other actions if needed

      print('Data sent to MongoDB successfully');
    } catch (e) {
      print('Error sending data to MongoDB: $e');
      // Handle the error as needed
    }
  }

  void updateUserData(
    String userId,
    String name,
    String surname,
    String phone,
  ) async {
    try {
      final mongo.Db db = await mongo.Db.create(
          'mongodb+srv://Meephrom:PTxSACWX08jHQuDm@meephrom.byzuncl.mongodb.net/Meephrom?retryWrites=true&w=majority');
      await db.open();

      final mongo.DbCollection collection = db.collection('user');

      // Create a query to find the document to update
      final query = mongo.where.eq('UserId', userId);

      // Create a modification to apply
      final modification = {
        r'$set': {
          "Name": name,
          "Surname": surname,
          "Phone_Number": phone,
        }
      };

      // Use the update operation
      await collection.update(query, modification);

      print('Data updated in MongoDB successfully');

      // Show the success dialog
      _showUpdateSuccessDialog(context);
    } catch (e) {
      print('Error updating data in MongoDB: $e');
      // Handle the error as needed
    }
  }

  Row getButt() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            // Retrieve text from TextField widgets
            String name = _nameController.text;
            String surname = _surnameController.text;
            String phone = _phoneController.text;

            // Validate the data if needed

            // Perform the desired action with the data (e.g., update in MongoDB)
            sendDataToMongoDB(context, widget.userId, name, surname, phone);
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
            print('Cancel');
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

  Widget getName(double screenWidth) {
    return Container(
      width: screenWidth * 0.7,
      child: TextFormField(
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        style: GoogleFonts.kanit(color: Colors.white),
        controller: _nameController,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.perm_identity,
            color: Colors.white,
          ),
          labelText: 'Name :',
          labelStyle: GoogleFonts.kanit(color: Colors.white),
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
      child: TextFormField(
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        style: GoogleFonts.kanit(color: Colors.white),
        controller: _surnameController,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.perm_identity,
            color: Colors.white,
          ),
          labelText: 'Surname :',
          labelStyle: GoogleFonts.kanit(color: Colors.white),
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
      child: TextFormField(
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.phone,
        style: GoogleFonts.kanit(color: Colors.white),
        controller: _phoneController,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.perm_identity,
            color: Colors.white,
          ),
          labelText: 'Phone :',
          labelStyle: GoogleFonts.kanit(color: Colors.white),
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
        'แก้ไขข้อมูล',
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
