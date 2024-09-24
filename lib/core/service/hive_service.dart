import 'package:hive/hive.dart';

Future<Box<T>> openBox<T>(String boxName) async {
  if (!Hive.isBoxOpen(boxName)) {
    return await Hive.openBox<T>(boxName);
  } else {
    return Hive.box<T>(boxName);
  }
}

void saveData<T>(List<T> data,String boxName) {
     var box = Hive.box<T>(boxName);
    box.addAll(data);
  }
