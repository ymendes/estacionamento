import 'dart:convert';

import 'package:flutter/services.dart';

import '../services/database.dart';
import 'models/account.dart';

class AccountRepository {
  static writeData(Account account) async {
    String data = jsonEncode(account.toMap());
    bool save = await DataBase.writeData(data);
    print(save);
  }

  static Future<Account> readData() async {
    String? data = await DataBase.readData();
    if (data != null) {
      Account account = Account.fromMap(jsonDecode(data));
      return account;
    } else {
      data = await rootBundle.loadString('assets/json/estacionamento.json');
      Account account = Account.fromMap(jsonDecode(data));
      return account;
    }
  }
}
