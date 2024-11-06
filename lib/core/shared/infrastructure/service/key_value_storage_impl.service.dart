import 'package:shared_preferences/shared_preferences.dart';
import 'key_value_storage.service.dart';

class KeyValueStorageImpl extends KeyValueStorageService {
  Future<SharedPreferences> getSharedPrefs() async {
    return await SharedPreferences.getInstance();
  }

  @override
  Future<T?> getValue<T>(String key) async {
    final prefs = await getSharedPrefs();
    if (T == int) {
      return prefs.getInt(key) as T?;
    } else if (T == String) {
      return prefs.getString(key) as T?;
    } else if (T == bool) {
      return prefs.getBool(key) as T?;
    } else {
      throw UnimplementedError('GET not implemented for type $T');
    }
  }

  @override
  Future<bool> removeKey(String key) async {
    final prefs = await getSharedPrefs();
    return await prefs.remove(key);
  }

  @override
  Future<void> setKeyValue<T>(String key, T value) async {
    final prefs = await getSharedPrefs();
    if (T == int) {
      prefs.setInt(key, value as int);
    } else if (T == String) {
      prefs.setString(key, value as String);
    } else if (T == bool) {
      prefs.setBool(key, value as bool);
    } else {
      throw UnimplementedError('Set not implemented for type $T');
    }
  }
}
