import 'package:estacionamento/repository/models/parking.dart';

import '../../utils/uuid.dart';
import 'historic.dart';

class Account {
  Account({
    required this.listParking,
  });

  List<Parking> listParking;

  factory Account.fromMap(Map<String, dynamic> json) => Account(
        listParking: json["listParking"] == null
            ? []
            : List<Parking>.from(
                json["listParking"].map((x) => Parking.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "listParking": List<dynamic>.from(listParking.map((x) => x.toMap())),
      };

  bool addParking({required String name}) {
    try {
      listParking.add(Parking(
          listParkingSpace: [],
          name: name,
          uuid: UuidGenerate.newUuid(),
          historic: Historic(
            listRegisters: [],
          )));
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }
}
