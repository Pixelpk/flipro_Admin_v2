import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';

class DbService with ChangeNotifier {
  GetStorage? _box;

  DbService() {
    _box = GetStorage();
  }

  writeAsJson({var data, required String key}) {
    try {
      if (_box != null && data != null) {
        print("WRITING JSON");
        String encodedJson = jsonEncode(data);
        print(encodedJson);
        _box!.write(key, encodedJson);
      }
    } catch (e) {
      print(e);
    }
  }

  bool hasData(String key) {
    try {
      return _box!.hasData(key);
    } catch (e) {
      return false;
      print(e);
    }
  }

  writeString(
    String key,
    String? string,
  ) {
    try {
      if (_box != null) {
        print("STORING $string");
        _box!.write(key, string);
        print(_box!.read(key));
      }
    } catch (e) {
      print(e);
    }
  }

  readString(String key) {
    try {
      if (_box != null) {
        return _box!.read(key);
        print("DB SERVICE READING ${_box!.read(key)}");
      }
    } catch (e) {
      print(e);
    }
  }

  readJson(String key) {
    try {
      if (_box != null) {
        return jsonDecode(_box!.read(key));
      }
    } catch (e) {
      print(e);
    }
  }

  deleteKeyValue(String key) {
    try {
      if (_box != null && _box!.hasData(key)) {
        return _box!.remove(key);
      }
    } catch (e) {
      print(e);
    }
  }

  truncateDb() {
    try {
      if (_box != null) {
        _box!.erase();
      }
    } catch (e) {
      print(e);
    }
  }
}
