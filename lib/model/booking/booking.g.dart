// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Booking _$BookingFromJson(Map<String, dynamic> json) => Booking(
      id: json['id'],
      userId: json['user_id'],
      venueId: json['venue_id'],
      bookingDate: json['booking_date'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      taxPercentage: json['tax_percentage'],
      totalPayment: json['total_payment'],
      bookingId: json['booking_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
    );

Map<String, dynamic> _$BookingToJson(Booking instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'venue_id': instance.venueId,
      'booking_date': instance.bookingDate,
      'start_time': instance.startTime,
      'end_time': instance.endTime,
      'tax_percentage': instance.taxPercentage,
      'total_payment': instance.totalPayment,
      'booking_id': instance.bookingId,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'deleted_at': instance.deletedAt,
    };
