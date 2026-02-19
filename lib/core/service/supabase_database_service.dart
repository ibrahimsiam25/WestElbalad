import 'dart:developer';
import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../errors/excptions.dart';
import 'data_service.dart';

class SupabaseDatabaseService implements DatabaseService {
  final SupabaseClient _client = Supabase.instance.client;

  // Supabase Storage bucket name (public)
  static const String _bucket = 'images';

  // Map Firestore collection names → Supabase table names
  String _table(String collection) {
    switch (collection) {
      case 'usedPhones':
        return 'used_phones';
      default:
        return collection;
    }
  }

  // Primary key column per table
  // users → 'uId'  (matches UserModel.toMap() key)
  // everything else → 'id'
  String _pkField(String table) => table == 'users' ? 'uId' : 'id';

  // ─────────────────────── CRUD ───────────────────────

  @override
  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
    String? documentId,
  }) async {
    try {
      final table = _table(path);
      // Data maps already contain the PK field (uId / id) from model.toMap()
      await _client.from(table).upsert(data);
    } catch (e) {
      log('SupabaseDB.addData error: $e');
      throw CustomException(message: 'حدث خطأ أثناء حفظ البيانات.');
    }
  }

  @override
  Future<Map<String, dynamic>> getData({
    required String path,
    required String docuementId,
  }) async {
    try {
      final table = _table(path);
      final pk = _pkField(table);
      final response =
          await _client.from(table).select().eq(pk, docuementId).single();
      return Map<String, dynamic>.from(response);
    } catch (e) {
      log('SupabaseDB.getData error: $e');
      throw CustomException(message: 'حدث خطأ أثناء جلب البيانات.');
    }
  }

  @override
  Future<List<Map<String, dynamic>>> fetchAllDocuments(
      String collectionName) async {
    try {
      final table = _table(collectionName);
      final response = await _client.from(table).select() as List<dynamic>;
      return response.map((e) => Map<String, dynamic>.from(e)).toList();
    } catch (e) {
      log('SupabaseDB.fetchAllDocuments error: $e');
      throw CustomException(message: 'حدث خطأ أثناء جلب البيانات.');
    }
  }

  @override
  Future<bool> checkIfDataExists({
    required String path,
    required String docuementId,
  }) async {
    try {
      final table = _table(path);
      final pk = _pkField(table);
      final response = await _client
          .from(table)
          .select(pk)
          .eq(pk, docuementId)
          .maybeSingle();
      return response != null;
    } catch (e) {
      log('SupabaseDB.checkIfDataExists error: $e');
      return false;
    }
  }

  @override
  Future<void> updateFieldValue({
    required String collectionName,
    required String docId,
    required String fieldName,
    required dynamic newValue,
  }) async {
    try {
      final table = _table(collectionName);
      final pk = _pkField(table);
      await _client.from(table).update({fieldName: newValue}).eq(pk, docId);
    } catch (e) {
      log('SupabaseDB.updateFieldValue error: $e');
      throw CustomException(message: 'حدث خطأ أثناء تحديث البيانات.');
    }
  }

  @override
  Future<void> deleteDocument({
    required String collectionName,
    required String documentId,
  }) async {
    try {
      final table = _table(collectionName);
      final pk = _pkField(table);
      await _client.from(table).delete().eq(pk, documentId);
    } catch (e) {
      log('SupabaseDB.deleteDocument error: $e');
      throw CustomException(message: 'حدث خطأ أثناء حذف البيانات.');
    }
  }

  // ──────────── Sub-collection (profile image only) ────────────

  /// Profile image was a Firestore sub-collection.
  /// In Supabase it's stored as `profile_image_url` column in `users`.
  @override
  Future<void> addDataInSubCollection({
    required String collection,
    required String docId,
    required String subCollection,
    required String subDocId,
    required Map<String, dynamic> data,
  }) async {
    try {
      if (collection == 'users' && subCollection == 'profileImage') {
        await _client
            .from('users')
            .update({'profile_image_url': data['imageUrl']}).eq('uId', docId);
      } else {
        throw CustomException(message: 'عملية Sub-collection غير مدعومة.');
      }
    } catch (e) {
      if (e is CustomException) rethrow;
      log('SupabaseDB.addDataInSubCollection error: $e');
      throw CustomException(message: 'حدث خطأ أثناء حفظ البيانات.');
    }
  }

  @override
  Future<Map<String, dynamic>> getDataFromSubCollection({
    required String collection,
    required String docId,
    required String subCollection,
    required String subDocId,
  }) async {
    try {
      if (collection == 'users' && subCollection == 'profileImage') {
        final response = await _client
            .from('users')
            .select('profile_image_url')
            .eq('uId', docId)
            .maybeSingle();
        return {'imageUrl': response?['profile_image_url'] ?? ''};
      } else {
        throw CustomException(message: 'عملية Sub-collection غير مدعومة.');
      }
    } catch (e) {
      if (e is CustomException) rethrow;
      log('SupabaseDB.getDataFromSubCollection error: $e');
      throw CustomException(message: 'حدث خطأ أثناء جلب البيانات.');
    }
  }

  // ─────────────────────── Storage ───────────────────────

  @override
  Future<String> uploadImage({
    required File image,
    required String path,
  }) async {
    try {
      final bytes = await image.readAsBytes();
      await _client.storage.from(_bucket).uploadBinary(
            path,
            bytes,
            fileOptions: FileOptions(
              contentType: _mimeType(path),
              upsert: true,
            ),
          );
      return _client.storage.from(_bucket).getPublicUrl(path);
    } catch (e) {
      log('SupabaseDB.uploadImage error: $e');
      throw CustomException(message: 'حدث خطأ أثناء رفع الصورة.');
    }
  }

  @override
  Future<void> deleteImageFromStorage(String imagePath) async {
    try {
      await _client.storage.from(_bucket).remove([imagePath]);
    } catch (e) {
      log('SupabaseDB.deleteImageFromStorage error: $e');
      throw CustomException(message: 'تعذر حذف الصورة.');
    }
  }

  @override
  Future<bool> checkIfImageExists(String imagePath) async {
    try {
      final dir = imagePath.contains('/')
          ? imagePath.substring(0, imagePath.lastIndexOf('/'))
          : '';
      final fileName = imagePath.contains('/')
          ? imagePath.substring(imagePath.lastIndexOf('/') + 1)
          : imagePath;
      final files = await _client.storage.from(_bucket).list(path: dir);
      return files.any((f) => f.name == fileName);
    } catch (e) {
      log('SupabaseDB.checkIfImageExists error: $e');
      return false;
    }
  }

  // ─────────────────────── Helpers ───────────────────────

  String _mimeType(String path) {
    final ext = path.split('.').last.toLowerCase();
    switch (ext) {
      case 'png':
        return 'image/png';
      case 'webp':
        return 'image/webp';
      default:
        return 'image/jpeg';
    }
  }
}
