// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_marketplace.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionMarketplace _$TransactionMarketplaceFromJson(
        Map<String, dynamic> json) =>
    TransactionMarketplace(
      id: json['id'],
      transactionId: json['transaction_id'],
      userId: json['user_id'],
      total: json['total'],
      status: json['status'],
      paymentUrl: json['payment_url'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
      product: json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
      user: json['user'] == null
          ? null
          : Users.fromJson(json['user'] as Map<String, dynamic>),
      productId: json['product_id'],
    );

Map<String, dynamic> _$TransactionMarketplaceToJson(
        TransactionMarketplace instance) =>
    <String, dynamic>{
      'id': instance.id,
      'transaction_id': instance.transactionId,
      'user_id': instance.userId,
      'product_id': instance.productId,
      'total': instance.total,
      'status': instance.status,
      'payment_url': instance.paymentUrl,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'deleted_at': instance.deletedAt,
      'product': instance.product,
      'user': instance.user,
    };
