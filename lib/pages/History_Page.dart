import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:mongo_dart/mongo_dart.dart' show Db, DbCollection;

class History_page extends StatefulWidget {
  final String userId;

  const History_page({Key? key, required this.userId}) : super(key: key);

  @override
  State<History_page> createState() => _History_pageState();
}

class _History_pageState extends State<History_page> {
  late List<Map<String, dynamic>> reservations = [];
  late String name = '';
  late String surname = '';

  @override
  void initState() {
    super.initState();
    print('Init State called');
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
      final reservationsCollection = DbCollection(db, 'history_Reservations');

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

      final List<Map<String, dynamic>> reservationList =
          await reservationsCollection
              .find(mongo.where.eq('UserId', userId))
              .toList();
      print('Reservation List: $reservationList');

      setState(() {
        reservations = reservationList;
        name = userData['Name'] ?? 'Default Name';
        surname = userData['Surname'] ?? 'Default Surname';
      });
    } catch (e) {
      print('Failed to load data from MongoDB: $e');
    } finally {
      await db.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    print('UserId in History Page: ${widget.userId}');
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: appbar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: BoxPer(screenWidth, screenHeight),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                'ประวัติการจอง',
                style: GoogleFonts.kanit(
                  fontSize: 20,
                ),
              ),
            ),
            for (var reservation in reservations)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 133, 160, 196),
                ),
                margin: EdgeInsets.only(top: 10),
                width: screenWidth * 0.9,
                height: screenHeight * 0.1,
                child: Center(
                  child: Text(
                    '${reservation['roomSize']} ${reservation['roomNum']} ${reservation['date']} ${reservation['time']}',
                    style: GoogleFonts.kanit(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Center BoxPer(double screenWidth, double screenHeight) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xff295CA5),
        ),
        margin: EdgeInsets.only(top: 10),
        width: screenWidth * 0.9,
        height: screenHeight * 0.2,
        child: Container(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  'ประวัติการจอง',
                  style: GoogleFonts.kanit(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                    width: screenWidth * 0.8,
                    height: screenHeight * 0.075,
                    child: Row(
                      children: [
                        Image.asset('image/per.png'),
                        SizedBox(
                          width: 50,
                        ),
                        Text(
                          '$name $surname',
                          style: GoogleFonts.kanit(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar appbar(context) {
    return AppBar(
      title: Text(
        'ประวัติการจอง',
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
