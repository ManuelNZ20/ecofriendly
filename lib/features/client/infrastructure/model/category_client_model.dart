class CategoryClientModel {
  final String idCategory;
  final String name;
  final bool status;
  final String img;

  CategoryClientModel({
    required this.idCategory,
    required this.name,
    required this.status,
    required this.img,
  });

  factory CategoryClientModel.fromJson(Map<String, dynamic> json) =>
      CategoryClientModel(
        idCategory: json['idCategory'].toString(),
        name: json['name'] ?? '',
        status: json['status'] ?? false,
        img: json['img'] ?? '',
      );
}
