import 'package:flutter/material.dart';

import '../../repository/models/historic.dart';
import '../../repository/models/parking_space.dart';
import '../../utils/app_colors.dart';
import '../parking/add_parking_space/add_parking_space_view.dart';
import '../parking/historic/historic_view.dart';
import '../parking/list_parking_spaces/all/list_all_parking_space.dart';
import '../routers/Nav.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu(
      {Key? key,
      required this.onCreateParkingSpaces,
      required this.listParkingSpace,
      required this.whenReordering,
      required this.historic})
      : super(key: key);

  final Function(List<ParkingSpace>) onCreateParkingSpaces;
  final List<ParkingSpace> listParkingSpace;
  final Function whenReordering;
  final Historic historic;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(width * 0.025),
              width: width,
              color: Colors.green,
              child: const Center(child: Text("Menu")),
            ),
            ListTile(
                title: const Text("Criar vagas"),
                trailing: Icon(
                  Icons.add_circle_rounded,
                  color: AppColors.buttonColor,
                ),
                onTap: () async {
                  var data = await Nav.to(const AddParkingSpaceView(), context);
                  if (data != null) {
                    onCreateParkingSpaces(data);
                  } else {
                    onCreateParkingSpaces([]);
                  }
                  Nav.back(context: context);
                }),
            ListTile(
              title: const Text("Listar vagas"),
              trailing: Icon(
                Icons.list,
                color: AppColors.buttonColor,
              ),
              onTap: () async {
                var data = await Nav.to(
                    ListAllParkingSpacesView(
                      listParkingSpace: listParkingSpace,
                    ),
                    context);
                if (data != null) {
                  whenReordering();
                } else {
                  // onCreateParkingSpaces([]);
                }
                Nav.back(context: context);
              },
            ),
            ListTile(
              title: const Text("Histórico"),
              trailing: Icon(
                Icons.history,
                color: AppColors.buttonColor,
              ),
              onTap: () async {
                var data = await Nav.to(
                    HistoricView(
                      historic: historic,
                    ),
                    context);
                if (data != null) {
                  whenReordering();
                } else {}
                Nav.back(context: context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
