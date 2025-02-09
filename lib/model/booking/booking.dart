import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'booking.g.dart';

@JsonSerializable()
class Booking {
  Booking({this.id, this.userId, this.venueId, this.bookingDate, this.startTime, this.endTime, this.taxPercentage, this.totalPayment, this.bookingId, this.createdAt, this.updatedAt, this.deletedAt});

  factory Booking.fromJson(Map<String, dynamic> json) => _$BookingFromJson(json);

  Map<String, dynamic> toJson() => _$BookingToJson(this);

  final dynamic id;
  @JsonKey(name: 'user_id')
  final dynamic userId;
  @JsonKey(name: 'venue_id')
  final dynamic venueId;
  @JsonKey(name: 'booking_date')
  final dynamic bookingDate;
  @JsonKey(name: 'start_time')
  final dynamic startTime;
  @JsonKey(name: 'end_time')
  final dynamic endTime;
  @JsonKey(name: 'tax_percentage')
  final dynamic taxPercentage;
  @JsonKey(name: 'total_payment')
  final dynamic totalPayment;
  @JsonKey(name: 'booking_id')
  final dynamic bookingId;
  @JsonKey(name: 'created_at')
  final dynamic createdAt;
  @JsonKey(name: 'updated_at')
  final dynamic updatedAt;
  @JsonKey(name: 'deleted_at')
  final dynamic deletedAt;

  @override
  String toString() => json.encode(this);
}
