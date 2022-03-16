import 'package:get/get.dart';

import '../../../../repository/models/register.dart';
import '../../routers/Nav.dart';

class ListParkingSpacesController extends GetxController {
  selectParkingSpace(context,
      {required int index, required Register register}) {
    Map<String, dynamic> result = {
      "indexParkingSpace": index,
      "register": register,
    };

    Nav.back(context: context, result: result);
  }
}
