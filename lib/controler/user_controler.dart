import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:quiz_test/model/user_model.dart';

abstract class UserControler{
   static final GetStorage _box=GetStorage();
   static const String _Box='user';
   static List<User> user=<User>[];
   static List<User> userr=<User>[];
  static  List storageList = [];
 static late   String level;

 static Future<void> inilitze()async{
      await GetStorage.init();
   }

   static Future<void> addUserr(User useritem) async{

   storageList.add(useritem);
   //var jsonEncode=jsonEncode(useritem.);
   await _box.write(_Box, storageList);
   print('List User ==== $storageList');

   }
    static List getUser()=>_box.hasData(_Box) ?_box.read(_Box):[];
    // saveDate(){
    //   List<User> list=user.map((e) {
    //     return jsonDecode(e.map())
    //   }).toList();
    // }

   static Future<void> restoreTasks() async{
    storageList = await _box.read(_Box); // initializing list from storage
    String nameKey, levelKey,scoreKey;

// looping through the storage list to parse out Task objects from maps
    for (int i = 0; i < storageList.length; i++) {
      final map = storageList[i];
      // index for retreival keys accounting for index starting at 0
      final index = i+1;

      nameKey = 'name$index';
      levelKey = 'level$index';
      scoreKey = 'score$index';


      // recreating Task objects from storage

      final task = User(name: map[nameKey], level: map[levelKey],score: map[scoreKey]);

      userr.add(task);

      print('length list = ${user.length}');// adding Tasks back to your normal Task list
    }
  }

  static Future<void> addUser(User userItem)async{
    user.add(userItem);
    final storageMap = {}; // temporary map that gets added to storage
    final index = user.length; // for unique map keys
    final nameKey = 'name$index';
    final levelKey = 'level$index';
    final scoreKey = 'score$index';

// adding task properties to temporary map

    storageMap[nameKey] = userItem.name;
    storageMap[levelKey] = userItem.level;
    storageMap[scoreKey] = userItem.score;

    storageList.add(storageMap); // adding temp map to storageList

   await _box.write(_Box, storageList);
    print(' storageList list length ${storageList}');
    print(' user list length ${user}');
  }

  static String getLevel(){

     user.forEach((element) {
       level= element.level;
     });

     return level;
   }
 static  Future<void> updatUser(int score)async{

    // var x=restorUser();
     user.forEach((element) {
       element.score=score;
     });
     await  _box.write('addUser', jsonEncode(user));
     print('list after update again ${user}');

   }

  static Future<void> LoadData() async {
     final list = await _box.read(_Box);
     if(list != null){
     //  restoreTasks();
       userr = list.map((e) => User.fromJson(jsonDecode(e.toString()))).toList();
       print('user =====${userr}');
     }
   }
   // void saveData() {
   //   List<String> nmyList = user.map((e) {
   //     print(e.map());
   //     return jsonEncode(e.map());
   //   }).toList();
   //   _box.write(_Box, nmyList);
   //
   // }


}