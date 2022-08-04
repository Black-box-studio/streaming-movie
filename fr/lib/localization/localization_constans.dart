import 'package:azul_movies/provider/language_device.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String LANGUEGE_CODE = 'languageCode';
const String LANGUEGE_FLAG = 'languageFlag';
const String LANGUEGE_NAME = 'languageName';

Future<Locale> setLocales(
    {@required String languageCode,
    @required String name,
    @required String flag}) async {
  SharedPreferences _perfs = await SharedPreferences.getInstance();
  await _perfs.setString(LANGUEGE_CODE, languageCode);
  await _perfs.setString(LANGUEGE_NAME, name);
  await _perfs.setString(LANGUEGE_FLAG, flag);
  return LanguageDevice.locale(languageCode);
}

Future<Locale> getLocales() async {
  SharedPreferences _perfs = await SharedPreferences.getInstance();
  String codeLanguege = _perfs.getString(LANGUEGE_CODE) ?? 'en';
  return LanguageDevice.locale(codeLanguege);
}
