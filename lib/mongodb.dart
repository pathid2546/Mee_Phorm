import 'dart:developer';

import 'package:meephrom/constant.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static connect() async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    inspect(db);
    var status = db.serverStatus();
    print(status);
    var collection = db.collection(COLLECTION_NAME);
    // await collection.insertMany([
    //   {
    //     "Username": "NP_1",
    //     "name": "Por",
    //     "Email": "Por@gmail.com",
    //   },
    //   {
    //     "Username": "NP_2",
    //     "name": "Por 2",
    //     "Email": "Por2@gmail.com",
    //   }
    // ]);
    // await collection.insert({
    //   "Name": "",
    //   "surName": "",
    //   "Phone": "",
    //   "Email": "",
    //   "pass": "",
    // });
    // print(await collection.find().toList());

    // await collection.updateMany(
    //     where.eq('Username', 'NP_1'), modify.set('name', 'Por_X'));

    // await collection.deleteMany({"Name": ""});
  }
}
