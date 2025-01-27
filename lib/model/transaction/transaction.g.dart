// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      id: json['id'],
      transactionId: json['transaction_id'],
      userId: json['user_id'],
      venueId: json['venue_id'],
      bookingId: json['booking_id'],
      total: json['total'],
      status: json['status'],
      paymentUrl: json['payment_url'],
      taxPercentage: json['tax_percentage'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
      venue: json['venue'] == null
          ? null
          : Venue.fromJson(json['venue'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'transaction_id': instance.transactionId,
      'user_id': instance.userId,
      'venue_id': instance.venueId,
      'booking_id': instance.bookingId,
      'total': instance.total,
      'status': instance.status,
      'payment_url': instance.paymentUrl,
      'tax_percentage': instance.taxPercentage,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'deleted_at': instance.deletedAt,
      'venue': instance.venue,
    };
