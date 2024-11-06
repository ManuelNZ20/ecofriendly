import '../../domain/entities/district.dart';
import '../models/district.module.dart';

class DistrictMapper {
  static District toDistrictEntity(DistrictModel district) {
    return District(
      id: district.id,
      name: district.name,
      capital: district.capital,
      idProvince: district.idProvince,
    );
  }
}
