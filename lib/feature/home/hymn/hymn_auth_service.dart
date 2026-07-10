import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'hymn_models.dart';

class AuthService {
  static String userId = '';
  static String userRole = ROLE_VIEWER;

  static Future<void> init(String uid) async {
    userId = uid;
    final prefs = await SharedPreferences.getInstance();
    userRole = prefs.getString('userRole_$uid') ?? ROLE_VIEWER;
    try {
      final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      userRole = doc.data()?['role'] ?? ROLE_VIEWER;
      await prefs.setString('userRole_$uid', userRole);
    } catch(e) { 
      log("AuthService: Failed to fetch role, using cache: $userRole"); 
    }
  }
  
  static bool get isAdmin => userRole == ROLE_ADMIN || userRole == ROLE_SUPER;
}