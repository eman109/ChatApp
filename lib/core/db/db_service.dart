import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

abstract class DbService {
  dynamic get client;
  Future<User?> signUp(String email, String password);
  Future<User?> signIn(String email, String password);
  Future<void> signOut();
  Future<void> insert(String table, Map<String, dynamic> data);
  Future<List<Map<String, dynamic>>> fetchByFilterNeq(
    String table,
    String column,
    String value,
  );
  Future<Map<String, dynamic>> fetchBySingle(
    String table,
    String column,
    String value,
  );
  Future<void> update(
    String table,
    String column,
    String value,
    Map<String, dynamic> data,
  );
  Future<String> uploadFile(
    String storage,
    String path,
    File file,
    FileOptions fileOptions,
  );
  Future<String> retrievePublicUrl(String bucket, String path);

}
