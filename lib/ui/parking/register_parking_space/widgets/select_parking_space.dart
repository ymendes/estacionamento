import 'package:flutter/material.dart';
import '../../../../../repository/models/parking_space.dart';
import '../../../../../utils/enuns/vehicle_type.dart';
import '../../../routers/Nav.dart';
import '../../../widgets/divider_text.dart';

class SelectParkingSpace extends StatelessWidget {
  const SelectParkingSpace(
      {Key? key,
      required this.onTapSpace,
      required this.listParkingSpace,
      this.vehicleType})
      : super(key: key);
  final Function(int index) onTapSpace;
  final List<ParkingSpace> listParkingSpace;
  final VehicleType? vehicleType;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        children: [
          DividerText(textTitle: "Selecione uma vaga disponível"),
          for (int i = 0; i < listParkingSpace.length; i++) ...[
            if (listParkingSpace[i].vehicleType == vehicleType ||
                vehicleType == null) ...[
              if (listParkingSpace[i].register == null) ...[
                InkWell(
                  onTap: () {
                    onTapSpace(i);
                    Nav.back(context: context);
                  },
                  child: Column(
                    children: [
                      Container(
                        width: width,
                        color: Colors.white,
                        height: 2,
                      ),
                      Container(
                        width: width,
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Container(
                                  width: width * 0.1,
                                  padding: EdgeInsets.all(5),
                                  child: Center(
                                    child: Text(
                                      "${i + 1}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Container(
                                color: Colors.grey.shade400,
                                child: Center(
                                  child: RotatedBox(
                                    quarterTurns: 3,
                                    child: Image.asset(
                                      listParkingSpace[i].vehicleType ==
                                              VehicleType.small
                                          ? "assets/images/top_small.png"
                                          : listParkingSpace[i].vehicleType ==
                                                  VehicleType.medium
                                              ? "assets/images/top_medium.png"
                                              : "assets/images/top_big.png",
                                      width: width * 0.2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ],
        ],
      ),
    );
  }
}
