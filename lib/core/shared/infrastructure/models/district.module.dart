class DistrictModel {
  final String id;
  final String name;
  final bool capital;
  final String idProvince;

  DistrictModel({
    required this.id,
    required this.name,
    required this.capital,
    required this.idProvince,
  });
  factory DistrictModel.fromJson(Map<String, dynamic> json) => DistrictModel(
        id: json['id'] ?? '',
        name: json['name_districts'] ?? '',
        capital: json['capital'] ?? false,
        idProvince: json['id_provinces'] ?? '',
      );
}
