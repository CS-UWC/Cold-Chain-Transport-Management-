import 'package:flutter/material.dart';

class Order extends ChangeNotifier {
  final String userId;
  final String? orderId;
  final String? companyName;
  final String? productType;
  final String? productName;
  final String? tempRange;
  final String? pickupLocation;
  final String? dropoffLocation;
  final String? customersName;
  final String? customersNumber;
  final String? status;
  final String? driverId;
  final String? createdAt;
  final String? updatedAt;
  final String? userUserId;
  final String? driverDriverId;
  // Add other order details as needed

  Order({required this.userId, required this.orderId, required this.companyName, required this.productType, required this.productName, required this.tempRange, required this.pickupLocation, required this.dropoffLocation, required this.customersName, required this.customersNumber, required this.status, required this.driverId, required this.createdAt, required this.updatedAt, this.userUserId, this.driverDriverId});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      userId: json['userId'],
      orderId: json['orderId'],
      companyName: json['companyName'],
      productType: json['productType'],
      productName: json['productName'],
      tempRange: json['tempRange'],
      pickupLocation: json['pickupLocation'],
      dropoffLocation: json['dropoffLocation'],
      customersName: json['customersName'],
      customersNumber: json['customersNumber'],
      status: json['status'],
      driverId: json['driverId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      userUserId: json['userUserId'],
      driverDriverId: json['driverDriverId'],
       // Map other fields here
    );
  }
  @override
  String toString() {
    return 'Order(userId: $userId, orderId: $orderId, companyName: $companyName, productType: $productType, productName: $productName, tempRange: $tempRange, pickupLocation: $pickupLocation, dropoffLocation: $dropoffLocation, customersName: $customersName, customersNumber: $customersNumber, status: $status, driverId: $driverId, createdAt: $createdAt, updatedAt: $updatedAt, userUserId: $userUserId, driverDriverId: $driverDriverId)';
  }
}
