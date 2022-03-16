import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/app_colors.dart';
import '../parking/home_parking/widgets/cardVehicleData.dart';
import 'account_controller.dart';

class AccountView extends StatelessWidget {
  const AccountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return GetBuilder<AccountController>(
        init: AccountController(),
        builder: (_) {
          return Scaffold(
            backgroundColor: AppColors.primary,
            body: SingleChildScrollView(
              child: SafeArea(
                child: SizedBox(
                  height: height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Center(
                        child: Text(
                          "Bem vindo de volta!",
                          style: TextStyle(fontSize: width * 0.065),
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            "Vagas do Estacionamento",
                            style: TextStyle(fontSize: width * 0.045),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(width: width * 0.1),
                                for (int i = 0;
                                    i < _.account.listParking.length;
                                    i++) ...[
                                  Padding(
                                    padding: EdgeInsets.only(top: width * 0.05),
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        InkWell(
                                          onTap: () => _.navigateToParkingView(
                                              context, i),
                                          child: Card(
                                            child: Container(
                                              margin:
                                                  EdgeInsets.all(width * 0.01),
                                              padding:
                                                  EdgeInsets.all(width * 0.01),
                                              width: width * 0.8,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    _.account.listParking[i]
                                                        .name
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                      fontSize: width * 0.03,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  CardVehicleData(
                                                      assetImage:
                                                          "assets/images/car1_exit.png",
                                                      elevation: 0,
                                                      shadowColor: Colors.white,
                                                      color: Colors.white,
                                                      available: _
                                                          .account
                                                          .listParking[i]
                                                          .smallAvailableLength,
                                                      unavailable: _
                                                              .account
                                                              .listParking[i]
                                                              .smallLength -
                                                          _
                                                              .account
                                                              .listParking[i]
                                                              .smallAvailableLength,
                                                      total: _
                                                          .account
                                                          .listParking[i]
                                                          .smallLength),
                                                  CardVehicleData(
                                                    assetImage:
                                                        "assets/images/car2.png",
                                                    elevation: 0,
                                                    shadowColor: Colors.white,
                                                    color: Colors.white,
                                                    available: _
                                                        .account
                                                        .listParking[i]
                                                        .mediumAvailableLength,
                                                    unavailable: _
                                                            .account
                                                            .listParking[i]
                                                            .mediumLength -
                                                        _.account.listParking[i]
                                                            .mediumAvailableLength,
                                                    total: _
                                                        .account
                                                        .listParking[i]
                                                        .mediumLength,
                                                  ),
                                                  CardVehicleData(
                                                    assetImage:
                                                        "assets/images/car3.png",
                                                    elevation: 0,
                                                    shadowColor: Colors.white,
                                                    color: Colors.white,
                                                    available: _
                                                        .account
                                                        .listParking[i]
                                                        .largeAvailableLength,
                                                    unavailable: _
                                                            .account
                                                            .listParking[i]
                                                            .largeLength -
                                                        _.account.listParking[i]
                                                            .largeAvailableLength,
                                                    total: _
                                                        .account
                                                        .listParking[i]
                                                        .largeLength,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                                SizedBox(width: width * 0.1),
                              ],
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () => _.navigateToParkingView(context, 0),
                        child: const Text("IR PARA O ESTACIONAMENTO"),
                      ),
                      SizedBox(height: width * 0.05),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
