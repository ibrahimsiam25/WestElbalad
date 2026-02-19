import 'package:supabase_flutter/supabase_flutter.dart';

/// Use this to access Supabase client anywhere in the app:
///   SupabaseService.client.from('table').select()
///   SupabaseService.auth.signInWithPassword(...)
///   SupabaseService.storage.from('bucket').upload(...)
class SupabaseService {
  SupabaseService._();

  static SupabaseClient get client => Supabase.instance.client;

  static GoTrueClient get auth => Supabase.instance.client.auth;

  static SupabaseStorageClient get storage => Supabase.instance.client.storage;
}
