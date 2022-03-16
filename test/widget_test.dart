import 'package:estacionamento/repository/models/account.dart';
import 'package:estacionamento/repository/models/historic.dart';
import 'package:estacionamento/repository/models/register.dart';
import 'package:estacionamento/repository/models/vehicle.dart';
import 'package:estacionamento/utils/enuns/moviment.dart';
import 'package:estacionamento/utils/enuns/vehicle_type.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  Account account = Account(listParking: []);
  Historic historic = Historic(listRegisters: []);

  bool createdParking = account.addParking(name: "Estacionamento do Yuri");
  bool createdParkingSpace =
      account.listParking[0].addParkingSpace(VehicleType.small);
  bool deleteParkingSpace = account.listParking[0].removeParkingSpace(0);

  Map<VehicleType, int> mapParkingSpace = {
    VehicleType.small: 5,
    VehicleType.medium: 5,
    VehicleType.large: 5,
  };

  bool createMultiplesParkingSpace =
      account.listParking[0].addMultipleParkingSpace(mapParkingSpace);

  int totalVehicles = account.listParking[0].length;

  int totalVehiclesSmall = account.listParking[0].smallLength;
  int totalVehiclesMedium = account.listParking[0].mediumLength;
  int totalVehiclesLarge = account.listParking[0].largeLength;

  int totalVehiclesSmallAvailable = account.listParking[0].smallAvailableLength;
  int totalVehiclesMediumAvailable =
      account.listParking[0].mediumAvailableLength;
  int totalVehiclesLargeAvailable = account.listParking[0].largeAvailableLength;

  group("Criar estacionamento", () {
    test("Deve criar um novo estacionamento", () {
      expect(true, createdParking);
    });
  });

  group("Criar, remover e contar vagas", () {
    test("Deve criar uma nova vaga para veículo pequeno no estacionamento", () {
      expect(true, createdParkingSpace);
    });

    test("Deve remover uma vaga de estacionamento", () {
      expect(true, deleteParkingSpace);
    });

    test("Deve criar multiplas vagas de estacionamento", () {
      expect(true, createMultiplesParkingSpace);
    });

    test("Deve ter criado 15 vagas veiculos", () {
      expect(15, totalVehicles);
    });

    test("Deve ter criado 5 vagas veiculos pequenos", () {
      expect(5, totalVehiclesSmall);
    });

    test("Deve ter criado 5 vagas veiculos médios", () {
      expect(5, totalVehiclesMedium);
    });

    test("Deve ter criado 5 vagas veiculos grandes", () {
      expect(5, totalVehiclesLarge);
    });

    test("Deve possuir 5 vagas veiculos pequenos disponíveis", () {
      expect(5, totalVehiclesSmallAvailable);
    });

    test("Deve possuir 5 vagas veiculos médios disponíveis", () {
      expect(5, totalVehiclesMediumAvailable);
    });

    test("Deve possuir 4 vagas veiculos grandes disponíveis", () {
      expect(5, totalVehiclesLargeAvailable);
    });
  });

  group("Inserir veículos e conferir vagas", () {
      Register register1 = Register(
        moviment: Moviment.entry,
        id: "1",
        vehicle: Vehicle(vehicleType: VehicleType.small),
        entryDateTime: DateTime.now(),
      );

      Register register2 = Register(
        moviment: Moviment.entry,
        id: "2",
        vehicle: Vehicle(vehicleType: VehicleType.small),
        entryDateTime: DateTime.now(),
      );

      Register register3 = Register(
        moviment: Moviment.entry,
        id: "3",
        vehicle: Vehicle(vehicleType: VehicleType.medium),
        entryDateTime: DateTime.now(),
      );

      Register register4 = Register(
        moviment: Moviment.entry,
        id: "4",
        vehicle: Vehicle(vehicleType: VehicleType.large),
        entryDateTime: DateTime.now(),
      );

      bool addVehicle1 =
          account.listParking[0].registerEntry(register: register1);
      bool addVehicle2 =
          account.listParking[0].registerEntry(register: register2);
      bool addVehicle3 =
          account.listParking[0].registerEntry(register: register3);
      bool addVehicle4 =
          account.listParking[0].registerEntry(register: register4);

      int totalSmallAvailableAfterAdding =
          account.listParking[0].smallAvailableLength;
      int totalMediumAvailableAfterAdding =
          account.listParking[0].mediumAvailableLength;
      int totalLargeAvailableAfterAdding =
          account.listParking[0].largeAvailableLength;

      bool addedRegister1 = historic.addRegister(register1);
      bool addedRegister2 = historic.addRegister(register2);
      bool addedRegister3 = historic.addRegister(register3);
      bool addedRegister4 = historic.addRegister(register4);


      test("Deve inserir os veículos nas vagas", () {
        expect(true, addVehicle1 && addVehicle2 && addVehicle3 && addVehicle4);
      });
      test("Deve possuir 3 vagas veiculos pequenos disponíveis", () {
        expect(3, totalSmallAvailableAfterAdding);
      });
      test("Deve possuir 4 vagas veiculos médios disponíveis", () {
        expect(4, totalMediumAvailableAfterAdding);
      });
      test("Deve possuir 4 vagas veiculos grandes disponíveis", () {
        expect(4, totalLargeAvailableAfterAdding);
      });

      test("Deve adicionar o registro ao historico", () {
        expect(true, addedRegister1);
      });
      test("Deve adicionar o registro ao historico", () {
        expect(true, addedRegister2);
      });
      test("Deve adicionar o registro ao historico", () {
        expect(true, addedRegister3);
      });
      test("Deve adicionar o registro ao historico", () {
        expect(true, addedRegister4);
      });
      test("Deve possuir 4 registros no histórico", () {
        expect(4, historic.length);
      });

      bool exitVehicle1 = account.listParking[0].registerExit(register1.id);
      int totalSmallAvailableAfterExit =
          account.listParking[0].smallAvailableLength;

      test("Deve retirar o veiculo da vaga", () {
        expect(true, exitVehicle1);
      });

      test("Deve possuir 4 vagas veiculos pequenos disponíveis", () {
        expect(4, totalSmallAvailableAfterExit);
      });

    });
}
