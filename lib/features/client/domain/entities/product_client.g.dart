// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_client.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetProductClientCollection on Isar {
  IsarCollection<ProductClient> get productClients => this.collection();
}

const ProductClientSchema = CollectionSchema(
  name: r'ProductClient',
  id: 9134479222439122957,
  properties: {
    r'amount': PropertySchema(
      id: 0,
      name: r'amount',
      type: IsarType.long,
    ),
    r'brand': PropertySchema(
      id: 1,
      name: r'brand',
      type: IsarType.string,
    ),
    r'createAt': PropertySchema(
      id: 2,
      name: r'createAt',
      type: IsarType.dateTime,
    ),
    r'description': PropertySchema(
      id: 3,
      name: r'description',
      type: IsarType.string,
    ),
    r'discountpercentage': PropertySchema(
      id: 4,
      name: r'discountpercentage',
      type: IsarType.double,
    ),
    r'expireProduct': PropertySchema(
      id: 5,
      name: r'expireProduct',
      type: IsarType.dateTime,
    ),
    r'id': PropertySchema(
      id: 6,
      name: r'id',
      type: IsarType.long,
    ),
    r'idCategory': PropertySchema(
      id: 7,
      name: r'idCategory',
      type: IsarType.long,
    ),
    r'idProduct': PropertySchema(
      id: 8,
      name: r'idProduct',
      type: IsarType.string,
    ),
    r'idproductdiscount': PropertySchema(
      id: 9,
      name: r'idproductdiscount',
      type: IsarType.string,
    ),
    r'img': PropertySchema(
      id: 10,
      name: r'img',
      type: IsarType.string,
    ),
    r'isFavorite': PropertySchema(
      id: 11,
      name: r'isFavorite',
      type: IsarType.bool,
    ),
    r'nameProduct': PropertySchema(
      id: 12,
      name: r'nameProduct',
      type: IsarType.string,
    ),
    r'price': PropertySchema(
      id: 13,
      name: r'price',
      type: IsarType.double,
    ),
    r'status': PropertySchema(
      id: 14,
      name: r'status',
      type: IsarType.bool,
    ),
    r'updateAt': PropertySchema(
      id: 15,
      name: r'updateAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _productClientEstimateSize,
  serialize: _productClientSerialize,
  deserialize: _productClientDeserialize,
  deserializeProp: _productClientDeserializeProp,
  idName: r'isarId',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _productClientGetId,
  getLinks: _productClientGetLinks,
  attach: _productClientAttach,
  version: '3.1.0',
);

int _productClientEstimateSize(
  ProductClient object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.brand.length * 3;
  bytesCount += 3 + object.description.length * 3;
  bytesCount += 3 + object.idProduct.length * 3;
  bytesCount += 3 + object.idproductdiscount.length * 3;
  bytesCount += 3 + object.img.length * 3;
  bytesCount += 3 + object.nameProduct.length * 3;
  return bytesCount;
}

void _productClientSerialize(
  ProductClient object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.amount);
  writer.writeString(offsets[1], object.brand);
  writer.writeDateTime(offsets[2], object.createAt);
  writer.writeString(offsets[3], object.description);
  writer.writeDouble(offsets[4], object.discountpercentage);
  writer.writeDateTime(offsets[5], object.expireProduct);
  writer.writeLong(offsets[6], object.id);
  writer.writeLong(offsets[7], object.idCategory);
  writer.writeString(offsets[8], object.idProduct);
  writer.writeString(offsets[9], object.idproductdiscount);
  writer.writeString(offsets[10], object.img);
  writer.writeBool(offsets[11], object.isFavorite);
  writer.writeString(offsets[12], object.nameProduct);
  writer.writeDouble(offsets[13], object.price);
  writer.writeBool(offsets[14], object.status);
  writer.writeDateTime(offsets[15], object.updateAt);
}

ProductClient _productClientDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ProductClient(
    amount: reader.readLong(offsets[0]),
    brand: reader.readString(offsets[1]),
    createAt: reader.readDateTime(offsets[2]),
    description: reader.readString(offsets[3]),
    discountpercentage: reader.readDouble(offsets[4]),
    expireProduct: reader.readDateTime(offsets[5]),
    id: reader.readLong(offsets[6]),
    idCategory: reader.readLong(offsets[7]),
    idProduct: reader.readString(offsets[8]),
    idproductdiscount: reader.readString(offsets[9]),
    img: reader.readString(offsets[10]),
    isFavorite: reader.readBoolOrNull(offsets[11]),
    nameProduct: reader.readString(offsets[12]),
    price: reader.readDouble(offsets[13]),
    status: reader.readBool(offsets[14]),
    updateAt: reader.readDateTime(offsets[15]),
  );
  object.isarId = id;
  return object;
}

P _productClientDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readDouble(offset)) as P;
    case 5:
      return (reader.readDateTime(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readString(offset)) as P;
    case 11:
      return (reader.readBoolOrNull(offset)) as P;
    case 12:
      return (reader.readString(offset)) as P;
    case 13:
      return (reader.readDouble(offset)) as P;
    case 14:
      return (reader.readBool(offset)) as P;
    case 15:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _productClientGetId(ProductClient object) {
  return object.isarId ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _productClientGetLinks(ProductClient object) {
  return [];
}

void _productClientAttach(
    IsarCollection<dynamic> col, Id id, ProductClient object) {
  object.isarId = id;
}

extension ProductClientQueryWhereSort
    on QueryBuilder<ProductClient, ProductClient, QWhere> {
  QueryBuilder<ProductClient, ProductClient, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ProductClientQueryWhere
    on QueryBuilder<ProductClient, ProductClient, QWhereClause> {
  QueryBuilder<ProductClient, ProductClient, QAfterWhereClause> isarIdEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterWhereClause>
      isarIdNotEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterWhereClause>
      isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterWhereClause> isarIdLessThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterWhereClause> isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIsarId,
        includeLower: includeLower,
        upper: upperIsarId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ProductClientQueryFilter
    on QueryBuilder<ProductClient, ProductClient, QFilterCondition> {
  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      amountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'amount',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      amountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'amount',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      amountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'amount',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      amountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'amount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      brandEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'brand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      brandGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'brand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      brandLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'brand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      brandBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'brand',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      brandStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'brand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      brandEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'brand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      brandContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'brand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      brandMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'brand',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      brandIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'brand',
        value: '',
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      brandIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'brand',
        value: '',
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      createAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      createAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      createAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      createAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      descriptionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      descriptionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      descriptionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      descriptionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      descriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      descriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      discountpercentageEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'discountpercentage',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      discountpercentageGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'discountpercentage',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      discountpercentageLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'discountpercentage',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      discountpercentageBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'discountpercentage',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      expireProductEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'expireProduct',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      expireProductGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'expireProduct',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      expireProductLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'expireProduct',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      expireProductBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'expireProduct',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition> idEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      idGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition> idLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition> idBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      idCategoryEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'idCategory',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      idCategoryGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'idCategory',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      idCategoryLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'idCategory',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      idCategoryBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'idCategory',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      idProductEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'idProduct',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      idProductGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'idProduct',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      idProductLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'idProduct',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      idProductBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'idProduct',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      idProductStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'idProduct',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      idProductEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'idProduct',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      idProductContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'idProduct',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      idProductMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'idProduct',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      idProductIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'idProduct',
        value: '',
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      idProductIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'idProduct',
        value: '',
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      idproductdiscountEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'idproductdiscount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      idproductdiscountGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'idproductdiscount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      idproductdiscountLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'idproductdiscount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      idproductdiscountBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'idproductdiscount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      idproductdiscountStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'idproductdiscount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      idproductdiscountEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'idproductdiscount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      idproductdiscountContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'idproductdiscount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      idproductdiscountMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'idproductdiscount',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      idproductdiscountIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'idproductdiscount',
        value: '',
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      idproductdiscountIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'idproductdiscount',
        value: '',
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition> imgEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'img',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      imgGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'img',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition> imgLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'img',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition> imgBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'img',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      imgStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'img',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition> imgEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'img',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition> imgContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'img',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition> imgMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'img',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      imgIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'img',
        value: '',
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      imgIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'img',
        value: '',
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      isFavoriteIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isFavorite',
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      isFavoriteIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isFavorite',
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      isFavoriteEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isFavorite',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      isarIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isarId',
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      isarIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isarId',
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      isarIdEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      isarIdGreaterThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      isarIdLessThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      isarIdBetween(
    Id? lower,
    Id? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isarId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      nameProductEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nameProduct',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      nameProductGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nameProduct',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      nameProductLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nameProduct',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      nameProductBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nameProduct',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      nameProductStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nameProduct',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      nameProductEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nameProduct',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      nameProductContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nameProduct',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      nameProductMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nameProduct',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      nameProductIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nameProduct',
        value: '',
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      nameProductIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nameProduct',
        value: '',
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      priceEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'price',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      priceGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'price',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      priceLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'price',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      priceBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'price',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      statusEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      updateAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updateAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      updateAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updateAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      updateAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updateAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterFilterCondition>
      updateAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updateAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ProductClientQueryObject
    on QueryBuilder<ProductClient, ProductClient, QFilterCondition> {}

extension ProductClientQueryLinks
    on QueryBuilder<ProductClient, ProductClient, QFilterCondition> {}

extension ProductClientQuerySortBy
    on QueryBuilder<ProductClient, ProductClient, QSortBy> {
  QueryBuilder<ProductClient, ProductClient, QAfterSortBy> sortByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy> sortByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy> sortByBrand() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'brand', Sort.asc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy> sortByBrandDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'brand', Sort.desc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy> sortByCreateAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createAt', Sort.asc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy>
      sortByCreateAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createAt', Sort.desc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy> sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy>
      sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy>
      sortByDiscountpercentage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'discountpercentage', Sort.asc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy>
      sortByDiscountpercentageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'discountpercentage', Sort.desc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy>
      sortByExpireProduct() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expireProduct', Sort.asc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy>
      sortByExpireProductDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expireProduct', Sort.desc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy> sortByIdCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idCategory', Sort.asc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy>
      sortByIdCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idCategory', Sort.desc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy> sortByIdProduct() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idProduct', Sort.asc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy>
      sortByIdProductDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idProduct', Sort.desc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy>
      sortByIdproductdiscount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idproductdiscount', Sort.asc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy>
      sortByIdproductdiscountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idproductdiscount', Sort.desc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy> sortByImg() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'img', Sort.asc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy> sortByImgDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'img', Sort.desc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy> sortByIsFavorite() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.asc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy>
      sortByIsFavoriteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.desc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy> sortByNameProduct() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameProduct', Sort.asc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy>
      sortByNameProductDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameProduct', Sort.desc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy> sortByPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.asc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy> sortByPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.desc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy> sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy> sortByUpdateAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updateAt', Sort.asc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy>
      sortByUpdateAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updateAt', Sort.desc);
    });
  }
}

extension ProductClientQuerySortThenBy
    on QueryBuilder<ProductClient, ProductClient, QSortThenBy> {
  QueryBuilder<ProductClient, ProductClient, QAfterSortBy> thenByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy> thenByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy> thenByBrand() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'brand', Sort.asc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy> thenByBrandDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'brand', Sort.desc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy> thenByCreateAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createAt', Sort.asc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy>
      thenByCreateAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createAt', Sort.desc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy> thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy>
      thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy>
      thenByDiscountpercentage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'discountpercentage', Sort.asc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy>
      thenByDiscountpercentageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'discountpercentage', Sort.desc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy>
      thenByExpireProduct() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expireProduct', Sort.asc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy>
      thenByExpireProductDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expireProduct', Sort.desc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy> thenByIdCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idCategory', Sort.asc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy>
      thenByIdCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idCategory', Sort.desc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy> thenByIdProduct() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idProduct', Sort.asc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy>
      thenByIdProductDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idProduct', Sort.desc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy>
      thenByIdproductdiscount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idproductdiscount', Sort.asc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy>
      thenByIdproductdiscountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idproductdiscount', Sort.desc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy> thenByImg() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'img', Sort.asc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy> thenByImgDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'img', Sort.desc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy> thenByIsFavorite() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.asc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy>
      thenByIsFavoriteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.desc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy> thenByNameProduct() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameProduct', Sort.asc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy>
      thenByNameProductDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameProduct', Sort.desc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy> thenByPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.asc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy> thenByPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.desc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy> thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy> thenByUpdateAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updateAt', Sort.asc);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QAfterSortBy>
      thenByUpdateAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updateAt', Sort.desc);
    });
  }
}

extension ProductClientQueryWhereDistinct
    on QueryBuilder<ProductClient, ProductClient, QDistinct> {
  QueryBuilder<ProductClient, ProductClient, QDistinct> distinctByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'amount');
    });
  }

  QueryBuilder<ProductClient, ProductClient, QDistinct> distinctByBrand(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'brand', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QDistinct> distinctByCreateAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createAt');
    });
  }

  QueryBuilder<ProductClient, ProductClient, QDistinct> distinctByDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QDistinct>
      distinctByDiscountpercentage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'discountpercentage');
    });
  }

  QueryBuilder<ProductClient, ProductClient, QDistinct>
      distinctByExpireProduct() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'expireProduct');
    });
  }

  QueryBuilder<ProductClient, ProductClient, QDistinct> distinctById() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id');
    });
  }

  QueryBuilder<ProductClient, ProductClient, QDistinct> distinctByIdCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'idCategory');
    });
  }

  QueryBuilder<ProductClient, ProductClient, QDistinct> distinctByIdProduct(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'idProduct', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QDistinct>
      distinctByIdproductdiscount({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'idproductdiscount',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QDistinct> distinctByImg(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'img', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QDistinct> distinctByIsFavorite() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isFavorite');
    });
  }

  QueryBuilder<ProductClient, ProductClient, QDistinct> distinctByNameProduct(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nameProduct', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ProductClient, ProductClient, QDistinct> distinctByPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'price');
    });
  }

  QueryBuilder<ProductClient, ProductClient, QDistinct> distinctByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status');
    });
  }

  QueryBuilder<ProductClient, ProductClient, QDistinct> distinctByUpdateAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updateAt');
    });
  }
}

extension ProductClientQueryProperty
    on QueryBuilder<ProductClient, ProductClient, QQueryProperty> {
  QueryBuilder<ProductClient, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<ProductClient, int, QQueryOperations> amountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'amount');
    });
  }

  QueryBuilder<ProductClient, String, QQueryOperations> brandProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'brand');
    });
  }

  QueryBuilder<ProductClient, DateTime, QQueryOperations> createAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createAt');
    });
  }

  QueryBuilder<ProductClient, String, QQueryOperations> descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<ProductClient, double, QQueryOperations>
      discountpercentageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'discountpercentage');
    });
  }

  QueryBuilder<ProductClient, DateTime, QQueryOperations>
      expireProductProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'expireProduct');
    });
  }

  QueryBuilder<ProductClient, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ProductClient, int, QQueryOperations> idCategoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'idCategory');
    });
  }

  QueryBuilder<ProductClient, String, QQueryOperations> idProductProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'idProduct');
    });
  }

  QueryBuilder<ProductClient, String, QQueryOperations>
      idproductdiscountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'idproductdiscount');
    });
  }

  QueryBuilder<ProductClient, String, QQueryOperations> imgProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'img');
    });
  }

  QueryBuilder<ProductClient, bool?, QQueryOperations> isFavoriteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isFavorite');
    });
  }

  QueryBuilder<ProductClient, String, QQueryOperations> nameProductProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nameProduct');
    });
  }

  QueryBuilder<ProductClient, double, QQueryOperations> priceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'price');
    });
  }

  QueryBuilder<ProductClient, bool, QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<ProductClient, DateTime, QQueryOperations> updateAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updateAt');
    });
  }
}
