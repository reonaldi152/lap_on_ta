import 'dart:convert';

import 'package:flutter_lapon/model/schedule/data_schedule.dart';
import 'package:flutter_lapon/model/venue/venue.dart';
import 'package:json_annotation/json_annotation.dart';

part 'schedule.g.dart';

@JsonSerializable()
class ScheduleModel {
  ScheduleModel({this.venue, this.schedules, this.availableSchedulesCount});

  factory ScheduleModel.fromJson(Map<String, dynamic> json) => _$ScheduleModelFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleModelToJson(this);

  final Venue? venue;
  final List<DataSchedule>? schedules;
  @JsonKey(name: 'available_schedules_count')
  final dynamic availableSchedulesCount;

  @override
  String toString() => json.encode(this);

}