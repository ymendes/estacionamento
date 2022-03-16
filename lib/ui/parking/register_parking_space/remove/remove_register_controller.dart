import 'package:estacionamento/ui/routers/Nav.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../../repository/models/register.dart';
import '../../../../../utils/enuns/moviment.dart';

class RemoveRegisterController extends GetxController {
  void exitRegister(
      {required BuildContext context,
      required Register register,
      required int index}) {
    Register _newRegister = Register(
        id: register.id,
        vehicle: register.vehicle,
        entryDateTime: register.entryDateTime,
        moviment: Moviment.exit);
    _newRegister.exitDateTime = DateTime.now();
    register.exitDateTime = DateTime.now();
    Map<String, dynamic> result = {
      "indexParkingSpace": index,
      "register": _newRegister,
    };

    Nav.back(context: context, result: result);
  }
}
