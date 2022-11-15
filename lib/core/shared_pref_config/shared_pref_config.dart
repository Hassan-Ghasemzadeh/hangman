import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> saveData(String key, String value) async {
  final shared = GetIt.I.get<SharedPreferences>();
  return shared.setString(key, value);
}

Future<bool> removeData(String key) async {
  final shared = GetIt.I.get<SharedPreferences>();

  return shared.remove(
    key,
  );
}

Future<bool> clearSharedPreferencesData() async {
  final shared = GetIt.I.get<SharedPreferences>();
  return shared.clear();
}

String getData(String key) {
  final shared = GetIt.I.get<SharedPreferences>();
  String? value = shared.getString(key);
  if (value != null) {
    return value;
  } else {
    return '';
  }
}
