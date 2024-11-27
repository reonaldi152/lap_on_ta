// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataSchedule _$DataScheduleFromJson(Map<String, dynamic> json) => DataSchedule(
      id: json['id'],
      venue_id: json['venue_id'],
      day_of_week: json['day_of_week'],
      start_time: json['start_time'],
      end_time: json['end_time'],
      is_booking: json['is_booking'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );

Map<String, dynamic> _$DataScheduleToJson(DataSchedule instance) =>
    <String, dynamic>{
      'id': instance.id,
      'venue_id': instance.venue_id,
      'day_of_week': instance.day_of_week,
      'start_time': instance.start_time,
      'end_time': instance.end_time,
      'is_booking': instance.is_booking,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
