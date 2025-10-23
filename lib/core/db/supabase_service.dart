import 'dart:io';

import 'package:chat/core/db/db_service.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/src/options.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService implements DbService {
  @override
  SupabaseClient get client => Supabase.instance.client;
  @override
  Future<User?> signIn(String email, String password) async {
    try {
      final response = await client.auth.signInWithPassword(
        password: password,
        email: email,
      );
      return response.user;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await client.auth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<User?> signUp(String email, String password) async {
    try {
      final response = await client.auth.signUp(
        password: password,
        email: email,
      );
      return response.user;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> insert(String table, Map<String, dynamic> data) async {
    try {
      await client.from(table).insert(data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> fetchByFilterNeq(
    String table,
    String column,
    String value,
  ) async {
    try {
      final response = await client.from(table).select().neq(column, value);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> fetchBySingle(
    String table,
    String column,
    String value,
  ) async {
    try {
      final response =
          await client.from(table).select().eq(column, value).single();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> update(
    String table,
    String column,
    String value,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await client.from(table).update(data).eq(column, value);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> uploadFile(
    String storage,
    String path,
    File file,
    FileOptions fileOptions,
  ) async {
    try {
      final response = await client.storage
          .from(storage)
          .upload(path, file, fileOptions: fileOptions);
      return response; //return the path stored in database
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> retrievePublicUrl(String bucket, String path) async {
    try {
      final response = client.storage.from(bucket).getPublicUrl(path);
      return response;
    } catch (e) {
      rethrow;
    }
  }

}

