import 'package:estacionamento/repository/models/extensions/app_date_time.dart';
import 'package:estacionamento/ui/parking/home_parking/widgets/button_moves_register.dart';
import 'package:estacionamento/ui/parking/home_parking/widgets/cardVehicleData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../repository/models/parking.dart';
import '../../../../utils/enuns/moviment.dart';
import '../../../../utils/enuns/vehicle_type.dart';
import '../../routers/Nav.dart';
import '../../widgets/divider_text.dart';
import '../../widgets/drawer.dart';
import 'home_parking_controller.dart';

class HomeParkingView extends StatelessWidget {
  const HomeParkingView({Key? key, required this.parking}) : super(key: key);

  final Parking parking;

  @override
  Widget build(BuildContext context) {
    var _controller = Get.put(HomeParkingController(parking));
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      endDrawer: GetBuilder<HomeParkingController>(
          id: "drawer",
          builder: (_) {
            return DrawerMenu(
              onCreateParkingSpaces: (list) => _.saveNewParkinSpace(list),
              listParkingSpace: _.parking.listParkingSpace,
              whenReordering: () => _.updateList(),
              historic: _.parking.historic,
            );
          }),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: width * 0.05),
            Text(parking.name),
          ],
        ),
        leading: InkWell(
          onTap: () => Nav.back(context: context),
          child: const Icon(Icons.keyboard_arrow_left_sharp),
        ),
      ),
      body: GetBuilder<HomeParkingController>(
          id: "home",
          builder: (_home) {
            return Padding(
              padding: EdgeInsets.only(
                left: width * 0.01,
                right: width * 0.01,
              ),
              child: Column(
                children: [
                  GetBuilder<HomeParkingController>(
                      id: "count",
                      builder: (_) {
                        return Container(
                          width: width,
                          child: Wrap(
                            children: [
                              SizedBox(
                                width: width * 0.3,
                                child: CardVehicleData(
                                  assetImage: "assets/images/car1_exit.png",
                                  available: _.parking.smallAvailableLength,
                                  unavailable: _.parking.smallLength -
                                      _.parking.smallAvailableLength,
                                  total: _.parking.smallLength,
                                ),
                              ),
                              SizedBox(
                                width: width * 0.3,
                                child: CardVehicleData(
                                  assetImage: "assets/images/car2.png",
                                  available: _.parking.mediumAvailableLength,
                                  unavailable: _.parking.mediumLength -
                                      _.parking.mediumAvailableLength,
                                  total: _.parking.mediumLength,
                                ),
                              ),
                              SizedBox(
                                width: width * 0.3,
                                child: CardVehicleData(
                                  assetImage: "assets/images/car3.png",
                                  available: _.parking.largeAvailableLength,
                                  unavailable: _.parking.largeLength -
                                      _.parking.largeAvailableLength,
                                  total: _.parking.largeLength,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                  const DividerText(textTitle: "Inserir registro"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ButtonMoveRegister(
                        onTap: () async {
                          _controller.exitRegisterParkingSpace(context);
                        },
                        assetImage: "assets/images/car4_exit.png",
                        title: "Saída",
                      ),
                      ButtonMoveRegister(
                        onTap: () async {
                          _controller.newRegisterParkingSpace(context);
                        },
                        assetImage: "assets/images/car4_in.png",
                        title: "Entrada",
                      ),
                    ],
                  ),
                  SizedBox(height: width * 0.05),
                  const DividerText(textTitle: "Últimas movimentações"),
                  Expanded(
                    child: GetBuilder<HomeParkingController>(
                      id: "list",
                      builder: (_) {
                        return ListView.separated(
                          separatorBuilder: (BuildContext context, int i) =>
                              const Divider(),
                          reverse: false,
                          itemCount: _.parking.historic.listRegisters.length,
                          itemBuilder: (BuildContext context, int a) {
                            int i =
                                (_.parking.historic.listRegisters.length - 1) -
                                    a;
                            return Row(
                              children: [
                                // Text((i + 1).toString()),
                                SizedBox(width: width * 0.025),
                                Column(
                                  children: [
                                    Image.asset(
                                      _.parking.historic.listRegisters[i]
                                                  .vehicle.vehicleType ==
                                              VehicleType.small
                                          ? "assets/images/car1_in.png"
                                          : _.parking.historic.listRegisters[i]
                                                      .vehicle.vehicleType ==
                                                  VehicleType.medium
                                              ? "assets/images/car2_in.png"
                                              : "assets/images/car3_in.png",
                                      width: width * 0.12,
                                    ),
                                    Text(
                                      _.parking.historic.listRegisters[i]
                                                  .moviment ==
                                              Moviment.entry
                                          ? "Entrada"
                                          : "Saída",
                                      style: TextStyle(
                                        fontSize: width * 0.03,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: width * 0.025),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          "Placa: ",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        Text(
                                          _.parking.historic.listRegisters[i]
                                                  .vehicle.model ??
                                              "",
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          "Placa: ",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        Text(
                                          _.parking.historic.listRegisters[i]
                                                  .vehicle.licensePlate
                                                  ?.toUpperCase() ??
                                              "",
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Visibility(
                                      visible: _.parking.historic
                                                  .listRegisters[i].moviment ==
                                              Moviment.entry
                                          ? true
                                          : false,
                                      child: Row(
                                        children: [
                                          const Text(
                                            "Entrada: ",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          Text(
                                            _.parking.historic.listRegisters[i]
                                                .entryDateTime
                                                .toFormat_dd_MM_yyyy_hh_mm(),
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Visibility(
                                      visible: _.parking.historic
                                                  .listRegisters[i].moviment ==
                                              Moviment.exit
                                          ? true
                                          : false,
                                      child: Row(
                                        children: [
                                          const Text(
                                            "Saída: ",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          Text(
                                            _.parking.historic.listRegisters[i]
                                                    .exitDateTime
                                                    ?.toFormat_dd_MM_yyyy_hh_mm() ??
                                                "",
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
