import 'package:uuid/uuid.dart';

String generateUniqueId() {
  final uuid = Uuid();
  return uuid.v4(); 
}