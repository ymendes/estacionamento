import 'package:estacionamento/repository/models/register.dart';

import '../../utils/enuns/vehicle_type.dart';

class ParkingSpace {
  ParkingSpace({
    required this.vehicleType,
    this.register,
  });

  VehicleType vehicleType;
  Register? register;

  factory ParkingSpace.fromMap(Map<String, dynamic> json) => ParkingSpace(
        vehicleType: json["vehicleType"] != null
            ? (json["vehicleType"] == "small"
                ? VehicleType.small
                : json["vehicleType"] == "medium"
                    ? VehicleType.medium
                    : VehicleType.large)
            : VehicleType.large,
        register: json["register"] == null
            ? null
            : Register.fromMap(json["register"]),
      );

  Map<String, dynamic> toMap() => {
        "vehicleType": vehicleType == VehicleType.small
            ? "small"
            : vehicleType == VehicleType.medium
                ? "medium"
                : "large",
        "register": register == null ? null : register!.toMap(),
      };
}
