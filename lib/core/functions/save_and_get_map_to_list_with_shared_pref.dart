import 'dart:convert';
import 'package:west_elbalad/core/service/shared_preferences_singleton.dart';


Future<void> saveMapToListInSharedPref({
  required String key,
  required Map<String, dynamic> newMap,
}) async {
 

  String? existingListString = SharedPref.getString(key);

  List<Map<String, dynamic>> mapList = [];

  // If there's an existing list, decode it from JSON
  if (existingListString !="" ) {
    List<dynamic> decodedList = jsonDecode(existingListString);
    mapList = decodedList.map((e) => Map<String, dynamic>.from(e)).toList();
  }

  // Add the new map to the list
  mapList.add(newMap);

  // Encode the updated list back to JSON and store it in SharedPreferences
  String updatedListString = jsonEncode(mapList);
  await SharedPref.setString(key, updatedListString);
}



Future<List<Map<String, dynamic>>> getListOfMapsFromSharedPref(String key) async {


  // Retrieve the existing list from SharedPreferences
  String? existingListString =  SharedPref.getString(key);

  // If there's no data, return an empty list
  if (existingListString == "") {
    return [];
  }

  // Decode the JSON string back to a list of maps
  List<dynamic> decodedList = jsonDecode(existingListString);
  List<Map<String, dynamic>> mapList = decodedList.map((e) => Map<String, dynamic>.from(e)).toList();

  return mapList;
}

Future<void> removeMapFromListInSharedPref({
  required String key,
  required Map<String, dynamic> mapToRemove,
}) async {
  // Retrieve the existing list from SharedPreferences
  String? existingListString = SharedPref.getString(key);

  // If there's no data, simply return
  if (existingListString == "" || existingListString.isEmpty) {
    return;
  }

  // Decode the JSON string back to a list of maps
  List<dynamic> decodedList = jsonDecode(existingListString);
  List<Map<String, dynamic>> mapList = decodedList.map((e) => Map<String, dynamic>.from(e)).toList();

  // Loop through the list and remove the first map that matches the 'id'
  for (int i = 0; i < mapList.length; i++) {
    if (mapList[i]['id'] == mapToRemove['id']) {
      mapList.removeAt(i);  // Remove the first matching map
      break;  // Exit the loop after removing the first match
    }
  }

  // Encode the updated list back to JSON and store it in SharedPreferences
  String updatedListString = jsonEncode(mapList);
  await SharedPref.setString(key, updatedListString);
}
