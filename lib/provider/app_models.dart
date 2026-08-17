import 'dart:io';

enum UserRole {
  buyer,
  retailer,
  wholesaler,
  serviceProvider,
  admin
}

class AppUser {
  final String id;
  final String name;
  final String phone;
  final String birthDate;
  final UserRole role;
  final String? nidImagePath;
  final bool isNidVerified;
  final bool isApproved;
  final double walletBalance;
  final String? email;
  final String? specialty;

  AppUser({
    required this.id,
    required this.name,
    required this.phone,
    required this.birthDate,
    required this.role,
    this.nidImagePath,
    this.isNidVerified = false,
    this.isApproved = false,
    this.walletBalance = 0.0,
    this.email,
    this.specialty,
  });

  AppUser copyWith({
    String? id,
    String? name,
    String? phone,
    String? birthDate,
    UserRole? role,
    String? nidImagePath,
    bool? isNidVerified,
    bool? isApproved,
    double? walletBalance,
    String? email,
    String? specialty,
  }) {
    return AppUser(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      birthDate: birthDate ?? this.birthDate,
      role: role ?? this.role,
      nidImagePath: nidImagePath ?? this.nidImagePath,
      isNidVerified: isNidVerified ?? this.isNidVerified,
      isApproved: isApproved ?? this.isApproved,
      walletBalance: walletBalance ?? this.walletBalance,
      email: email ?? this.email,
      specialty: specialty ?? this.specialty,
    );
  }
}

class BulkPriceSlab {
  final int minQty;
  final double pricePerUnit;

  BulkPriceSlab({required this.minQty, required this.pricePerUnit});
}

class Product {
  final String id;
  final String name;
  final String category;
  final String description;
  final double price;
  final List<BulkPriceSlab> bulkSlabs;
  final int minOrderQuantity;
  final List<String> imagePaths;
  final String sellerId;
  final String shopName;
  final bool isApproved;
  final double rating;
  final double discountPercent;
  final String brand;
  final int soldCount;
  final String productType;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.price,
    this.bulkSlabs = const [],
    this.minOrderQuantity = 1,
    required this.imagePaths,
    required this.sellerId,
    required this.shopName,
    this.isApproved = false,
    this.rating = 5.0,
    this.discountPercent = 0.0,
    this.brand = "Generic",
    this.soldCount = 0,
    this.productType = "RETAIL",
  });

  Product copyWith({
    String? id,
    String? name,
    String? category,
    String? description,
    double? price,
    List<BulkPriceSlab>? bulkSlabs,
    int? minOrderQuantity,
    List<String>? imagePaths,
    String? sellerId,
    String? shopName,
    bool? isApproved,
    double? rating,
    double? discountPercent,
    String? brand,
    int? soldCount,
    String? productType,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      description: description ?? this.description,
      price: price ?? this.price,
      bulkSlabs: bulkSlabs ?? this.bulkSlabs,
      minOrderQuantity: minOrderQuantity ?? this.minOrderQuantity,
      imagePaths: imagePaths ?? this.imagePaths,
      sellerId: sellerId ?? this.sellerId,
      shopName: shopName ?? this.shopName,
      isApproved: isApproved ?? this.isApproved,
      rating: rating ?? this.rating,
      discountPercent: discountPercent ?? this.discountPercent,
      brand: brand ?? this.brand,
      soldCount: soldCount ?? this.soldCount,
      productType: productType ?? this.productType,
    );
  }
}

enum BookingStatus {
  Requested,
  Accepted,
  EnRoute,
  Completed,
  Cancelled
}

class Booking {
  final String id;
  final String buyerId;
  final String buyerName;
  final String providerId;
  final String providerName;
  final String category;
  final DateTime date;
  final String timeSlot;
  final String issueDescription;
  final String? imagePath;
  final BookingStatus status;
  final double invoiceAmount;
  final bool isInvoiceRaised;

  Booking({
    required this.id,
    required this.buyerId,
    required this.buyerName,
    required this.providerId,
    required this.providerName,
    required this.category,
    required this.date,
    required this.timeSlot,
    required this.issueDescription,
    this.imagePath,
    required this.status,
    this.invoiceAmount = 0.0,
    this.isInvoiceRaised = false,
  });

  Booking copyWith({
    String? id,
    String? buyerId,
    String? buyerName,
    String? providerId,
    String? providerName,
    String? category,
    DateTime? date,
    String? timeSlot,
    String? issueDescription,
    String? imagePath,
    BookingStatus? status,
    double? invoiceAmount,
    bool? isInvoiceRaised,
  }) {
    return Booking(
      id: id ?? this.id,
      buyerId: buyerId ?? this.buyerId,
      buyerName: buyerName ?? this.buyerName,
      providerId: providerId ?? this.providerId,
      providerName: providerName ?? this.providerName,
      category: category ?? this.category,
      date: date ?? this.date,
      timeSlot: timeSlot ?? this.timeSlot,
      issueDescription: issueDescription ?? this.issueDescription,
      imagePath: imagePath ?? this.imagePath,
      status: status ?? this.status,
      invoiceAmount: invoiceAmount ?? this.invoiceAmount,
      isInvoiceRaised: isInvoiceRaised ?? this.isInvoiceRaised,
    );
  }
}

enum OrderStatus {
  PickedUp,
  InTransit,
  OutforDelivery,
  Delivered,
  Returned
}

class OrderItem {
  final Product product;
  final int quantity;

  OrderItem({required this.product, required this.quantity});
}

class OrderModel {
  final String id;
  final String buyerId;
  final String buyerName;
  final String sellerId;
  final String shopName;
  final List<OrderItem> items;
  final double totalAmount;
  final OrderStatus status;
  final bool isApprovedByAdmin;
  final DateTime date;

  OrderModel({
    required this.id,
    required this.buyerId,
    required this.buyerName,
    required this.sellerId,
    required this.shopName,
    required this.items,
    required this.totalAmount,
    required this.status,
    this.isApprovedByAdmin = false,
    required this.date,
  });

  OrderModel copyWith({
    String? id,
    String? buyerId,
    String? buyerName,
    String? sellerId,
    String? shopName,
    List<OrderItem>? items,
    double? totalAmount,
    OrderStatus? status,
    bool? isApprovedByAdmin,
    DateTime? date,
  }) {
    return OrderModel(
      id: id ?? this.id,
      buyerId: buyerId ?? this.buyerId,
      buyerName: buyerName ?? this.buyerName,
      sellerId: sellerId ?? this.sellerId,
      shopName: shopName ?? this.shopName,
      items: items ?? this.items,
      totalAmount: totalAmount ?? this.totalAmount,
      status: status ?? this.status,
      isApprovedByAdmin: isApprovedByAdmin ?? this.isApprovedByAdmin,
      date: date ?? this.date,
    );
  }
}

class ReviewModel {
  final String id;
  final String targetId; // Product ID or Shop ID or Provider ID
  final String reviewerName;
  final double stars;
  final double priceFairnessStars;
  final double behaviorStars;
  final double responseTimeStars;
  final String comment;
  final DateTime date;

  ReviewModel({
    required this.id,
    required this.targetId,
    required this.reviewerName,
    required this.stars,
    required this.priceFairnessStars,
    required this.behaviorStars,
    required this.responseTimeStars,
    required this.comment,
    required this.date,
  });
}

class WalletTransaction {
  final String id;
  final String type; // e.g. "commission", "payout", "bKash"
  final double amount;
  final bool isNegative;
  final DateTime date;
  final String details;

  WalletTransaction({
    required this.id,
    required this.type,
    required this.amount,
    required this.isNegative,
    required this.date,
    required this.details,
  });
}

class ChatMessage {
  final String id;
  final String senderId;
  final String senderName;
  final String message;
  final DateTime time;
  final String? imageUrl;

  ChatMessage({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.message,
    required this.time,
    this.imageUrl,
  });
}
