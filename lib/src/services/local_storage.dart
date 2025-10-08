import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LocalStorageService {
  static const String _offlineQueueKey = 'offline_queue';

  Future<void> addToQueue(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> queue = prefs.getStringList(_offlineQueueKey) ?? [];
    queue.add(json.encode(data));
    await prefs.setStringList(_offlineQueueKey, queue);
  }

  Future<List<Map<String, dynamic>>> getQueue() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> queue = prefs.getStringList(_offlineQueueKey) ?? [];
    return queue.map((item) => json.decode(item) as Map<String, dynamic>).toList();
  }

  Future<void> clearQueue() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_offlineQueueKey);
  }
}