import '../utils/enum_parser.dart';

enum ShiftType { MORNING_SHIFT, EVENING_SHIFT, NIGHT_SHIFT }

class ShiftModel {
  String? id;
  DateTime shift_date;
  ShiftType type;
  //assuming there's a system that assign each shift to a person
  String person_in_charge_id;

  ShiftModel({this.id, required this.person_in_charge_id, required this.type, required this.shift_date});
  Map<String, dynamic> toJson() => {'shift_date': shift_date, 'type': type.name, 'person_in_charge_id': ''};

  factory ShiftModel.fromJson(Map<String, dynamic> json) => ShiftModel(
      id: json['id'],
      person_in_charge_id: json['person_in_charge_id'],
      type: enumFromString(json['type'], ShiftType.values)!,
      shift_date: DateTime.parse(json['shift_date'].toDate().toString()));
}
