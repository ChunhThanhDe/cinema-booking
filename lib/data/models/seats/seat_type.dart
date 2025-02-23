import 'package:cinema_booking/common/helpers/json_converter.dart';
import 'package:cinema_booking/core/enum/type_seat.dart';
import 'package:cinema_booking/data/models/seats/seat_row.dart';
import 'package:cinema_booking/domain/entities/seats/seat_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'seat_type.g.dart';

@JsonSerializable()
class SeatTypesModel {
  String? id;

  @JsonKey(name: "name", defaultValue: "")
  String? name;

  @StringAsDoubleConverter()
  @JsonKey(name: "price")
  double? price;

  @JsonKey(name: "seat_type", defaultValue: TypeSeat.jack)
  TypeSeat type;

  // connect with relationship 1 - n
  @JsonKey(name: "seat_rows")
  List<SeatRowModel> seatRows;

  SeatTypesModel(this.name, this.price, this.type, this.seatRows);

  factory SeatTypesModel.fromJson(Map<String, dynamic> json) =>
      _$SeatTypesModelFromJson(json);

  Map<String, dynamic> toJson() => _$SeatTypesModelToJson(this);

  @override
  String toString() {
    return 'SeatTypesModel{id: $id, name: $name, price: $price, type: $type, seatRows: ${seatRows.map((row) => row.toString()).toList()}}';
  }

  static final List<SeatTypesModel> SAMPLE_DATA = [
    SeatTypesModel('King', 120.0, TypeSeat.king, SeatRowModel.SAMPLE_KING),
    SeatTypesModel('Queen', 100.0, TypeSeat.queen, SeatRowModel.SAMPLE_QUEEN),
    SeatTypesModel('Jack', 80.0, TypeSeat.jack, SeatRowModel.SAMPLE_JACK),
  ];
}

extension TypeSeatoText on TypeSeat {
  String toText() {
    switch (this) {
      case TypeSeat.jack:
        return "Jack";
      case TypeSeat.queen:
        return "Queen";
      case TypeSeat.king:
        return "King";
    }
  }
}

extension SeatTypesModelMapper on SeatTypesModel {
  SeatTypeEntity toEntity() {
    return SeatTypeEntity(
      id: id ?? "",
      name: name ?? "",
      price: price ?? 0,
      type: type,
      seatRows: seatRows.map((row) => row.toEntity()).toList(),
    );
  }
}

extension SeatTypesModelListMapper on List<SeatTypesModel> {
  List<SeatTypeEntity> toEntities() {
    return map((model) => model.toEntity()).toList();
  }
}
