import 'package:get/get.dart';
import '../../../repository/account_repository.dart';
import '../../../repository/models/account.dart';
import '../app_controller.dart';
import '../parking/home_parking/home_parking_view.dart';
import '../routers/Nav.dart';

class AccountController extends GetxController {
  static AccountController get to => Get.find();
  Account account = AppController.to.account;

  Future<void> navigateToParkingView(context, index) async {
    await Nav.to(HomeParkingView(parking: account.listParking[index]), context);
    update();
  }

  Future<void> saveAccount() async {
    await AccountRepository.writeData(account);
  }

  @override
  void onInit() async {
    super.onInit();
    account = await AccountRepository.readData();
    update();
  }
}
