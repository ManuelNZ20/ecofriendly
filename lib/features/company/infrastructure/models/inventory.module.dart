import '../../domain/domain.dart';

class InventoryModel {
  final int id;
  final String name;
  final String description;
  final String idCompany;
  final String dateRegister;

  InventoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.idCompany,
    required this.dateRegister,
  });

  factory InventoryModel.fromJson(Map<String, dynamic> json) => InventoryModel(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        description: json['description'] ?? '',
        idCompany: json['id_company'] ?? '',
        dateRegister: json['create_at'] ?? '',
      );

  Inventory toInventoryEntity() => Inventory(
        id: id,
        name: name,
        description: description,
        idCompany: idCompany,
        dateRegister: dateRegister,
      );
}
