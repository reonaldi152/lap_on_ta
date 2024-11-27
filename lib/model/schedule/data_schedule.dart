import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'data_schedule.g.dart';

@JsonSerializable()
class DataSchedule {
  DataSchedule({this.id, this.venue_id, this.day_of_week, this.start_time, this.end_time, this.is_booking, this.createdAt, this.updatedAt});

  factory DataSchedule.fromJson(Map<String, dynamic> json) => _$DataScheduleFromJson(json);

  Map<String, dynamic> toJson() => _$DataScheduleToJson(this);

  final dynamic id;
  final dynamic venue_id;
  final dynamic day_of_week;
  final dynamic start_time;
  final dynamic end_time;
  final dynamic is_booking;
  @JsonKey(name: 'created_at')
  final dynamic createdAt;
  @JsonKey(name: 'updated_at')
  final dynamic updatedAt;

  @override
  String toString() => json.encode(this);

}