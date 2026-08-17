import 'dart:io';
import 'package:flutter/material.dart';
import 'app_models.dart';

class MarketplaceProvider extends ChangeNotifier {
  // Current user configuration
  AppUser? _currentUser;
  AppUser? get currentUser => _currentUser;

  // Active role selected in the UI
  UserRole _selectedRole = UserRole.buyer;
  UserRole get selectedRole => _selectedRole;

  // Registered users (simulated DB)
  final List<AppUser> _users = [
    AppUser(
      id: "admin_1",
      name: "Super Admin",
      phone: "01700000000",
      birthDate: "1990-01-01",
      role: UserRole.admin,
      isNidVerified: true,
      isApproved: true,
      walletBalance: 0.0,
      email: "admin@gmail.com",
    ),
    AppUser(
      id: "wholesaler_1",
      name: "Grand Wholesale Ltd.",
      phone: "01811111111",
      birthDate: "1985-05-15",
      role: UserRole.wholesaler,
      nidImagePath: "assets/images/dummy_nid.png",
      isNidVerified: true,
      isApproved: true,
      walletBalance: -150.0,
      email: "wholesaler@gmail.com",
    ),
    AppUser(
      id: "retailer_1",
      name: "Eco Retail Mart",
      phone: "01922222222",
      birthDate: "1992-08-20",
      role: UserRole.retailer,
      nidImagePath: "assets/images/dummy_nid.png",
      isNidVerified: true,
      isApproved: true,
      walletBalance: -50.0,
      email: "retailer@gmail.com",
    ),
    AppUser(
      id: "tech_1",
      name: "Rahim Electrician",
      phone: "01533333333",
      birthDate: "1988-12-10",
      role: UserRole.serviceProvider,
      nidImagePath: "assets/images/dummy_nid.png",
      isNidVerified: true,
      isApproved: true,
      walletBalance: -20.0,
      email: "tech@gmail.com",
      specialty: "Electrician",
    ),
    AppUser(
      id: "mech_1",
      name: "Kashem Mechanic",
      phone: "01533333334",
      birthDate: "1985-02-14",
      role: UserRole.serviceProvider,
      nidImagePath: "assets/images/dummy_nid.png",
      isNidVerified: true,
      isApproved: true,
      walletBalance: 0.0,
      email: "mech@gmail.com",
      specialty: "Mechanic",
    ),
    AppUser(
      id: "plumb_1",
      name: "Jamal Plumber",
      phone: "01533333335",
      birthDate: "1990-11-20",
      role: UserRole.serviceProvider,
      nidImagePath: "assets/images/dummy_nid.png",
      isNidVerified: true,
      isApproved: true,
      walletBalance: 0.0,
      email: "plumb@gmail.com",
      specialty: "Plumber",
    ),
    AppUser(
      id: "buyer_1",
      name: "Anisur Rahman",
      phone: "01644444444",
      birthDate: "1998-03-05",
      role: UserRole.buyer,
      isNidVerified: false,
      isApproved: true,
      walletBalance: 0.0,
      email: "buyer@gmail.com",
    ),
  ];

  List<AppUser> get allUsers => _users;

  // Categories & Subcategories
  List<String> _categories = ["Service Provider", "Electronics", "Fashion", "Home Appliances", "AC Repair", "Plumbing", "Electrician"];
  List<String> get categories => _categories;

  Map<String, List<String>> _subcategories = {
    "Service Provider": ["Electrician", "Mechanic", "Plumber", "AC Repair", "Cleaning"],
    "Electronics": ["Mobiles", "Laptops", "Accessories"],
    "Fashion": ["Men's Wear", "Women's Wear", "Footwear"],
    "Home Appliances": ["Microwaves", "Blenders", "Washing Machines"],
    "AC Repair": ["AC Installation", "AC Servicing", "AC Gas Refill"],
    "Plumbing": ["Pipe Leakage", "Tap Installation", "Drainage"],
    "Electrician": ["Fan Repair", "House Wiring", "Short Circuit Repair"],
  };
  Map<String, List<String>> get subcategories => _subcategories;

  // Category Commission Rates (Stored in percentage, default 10%)
  Map<String, double> _categoryCommissions = {
    "Electronics": 8.0,
    "Fashion": 12.0,
    "Home Appliances": 10.0,
    "AC Repair": 15.0,
    "Plumbing": 15.0,
    "Electrician": 15.0,
  };
  Map<String, double> get categoryCommissions => _categoryCommissions;

  // Products List
  List<Product> _products = [
    Product(
      id: "prod_1",
      name: "Wireless Neckband Pro",
      category: "Electronics",
      description: "High-quality wireless bass neckband with 24 hours playback.",
      price: 1200.0,
      sellerId: "retailer_1",
      shopName: "Eco Retail Mart",
      imagePaths: [],
      isApproved: true,
      discountPercent: 10,
    ),
    Product(
      id: "prod_2",
      name: "Premium Cotton T-Shirt",
      category: "Fashion",
      description: "100% combed cotton comfortable casual wear.",
      price: 450.0,
      sellerId: "retailer_1",
      shopName: "Eco Retail Mart",
      imagePaths: [],
      isApproved: true,
    ),
    Product(
      id: "prod_3",
      name: "Bulk AC Condenser Units",
      category: "Home Appliances",
      description: "Heavy duty copper condenser units for AC manufacturing.",
      price: 8000.0,
      sellerId: "wholesaler_1",
      shopName: "Grand Wholesale Ltd.",
      imagePaths: [],
      isApproved: true,
      minOrderQuantity: 10,
      bulkSlabs: [
        BulkPriceSlab(minQty: 10, pricePerUnit: 8000.0),
        BulkPriceSlab(minQty: 50, pricePerUnit: 7500.0),
        BulkPriceSlab(minQty: 100, pricePerUnit: 7000.0),
      ],
    ),
  ];
  List<Product> get products => _products;

  // Bookings List
  List<Booking> _bookings = [
    Booking(
      id: "book_1",
      buyerId: "buyer_1",
      buyerName: "Anisur Rahman",
      providerId: "tech_1",
      providerName: "Rahim Electrician",
      category: "Electrician",
      date: DateTime.now().add(const Duration(days: 1)),
      timeSlot: "10:00 AM - 12:00 PM",
      issueDescription: "Ceiling fan has stopped spinning and hums.",
      status: BookingStatus.Requested,
    )
  ];
  List<Booking> get bookings => _bookings;

  // Orders List
  List<OrderModel> _orders = [
    OrderModel(
      id: "ORD-982736",
      buyerId: "buyer_1",
      buyerName: "Anisur Rahman",
      sellerId: "retailer_1",
      shopName: "Eco Retail Mart",
      items: [],
      totalAmount: 1200.0,
      status: OrderStatus.PickedUp,
      isApprovedByAdmin: false,
      date: DateTime.now().subtract(const Duration(hours: 3)),
    )
  ];
  List<OrderModel> get orders => _orders;

  // Reviews & Ratings List
  List<ReviewModel> _reviews = [
    ReviewModel(
      id: "rev_1",
      targetId: "prod_1",
      reviewerName: "Sohan Sheikh",
      stars: 4.8,
      priceFairnessStars: 5.0,
      behaviorStars: 4.5,
      responseTimeStars: 4.8,
      comment: "Excellent product, sound signature is amazing for the price.",
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
    ReviewModel(
      id: "rev_2",
      targetId: "tech_1",
      reviewerName: "Rashedul Islam",
      stars: 5.0,
      priceFairnessStars: 5.0,
      behaviorStars: 5.0,
      responseTimeStars: 5.0,
      comment: "Quick service and polite behavior.",
      date: DateTime.now().subtract(const Duration(days: 5)),
    ),
  ];
  List<ReviewModel> get reviews => _reviews;

  // Wallet Logs / Transactions
  Map<String, List<WalletTransaction>> _walletLogs = {
    "wholesaler_1": [
      WalletTransaction(
        id: "tx_101",
        type: "commission",
        amount: 800.0,
        isNegative: true,
        date: DateTime.now().subtract(const Duration(days: 2)),
        details: "Commission deduction for Bulk AC Condensers (Order ORD-1122)",
      ),
      WalletTransaction(
        id: "tx_102",
        type: "bKash",
        amount: 1000.0,
        isNegative: false,
        date: DateTime.now().subtract(const Duration(days: 1)),
        details: "Wallet auto-credit via bKash payment to admin",
      ),
    ],
    "retailer_1": [
      WalletTransaction(
        id: "tx_201",
        type: "commission",
        amount: 120.0,
        isNegative: true,
        date: DateTime.now().subtract(const Duration(days: 3)),
        details: "Commission deduction for Wireless Neckband Pro (Order ORD-982736)",
      ),
    ],
    "tech_1": [
      WalletTransaction(
        id: "tx_301",
        type: "commission",
        amount: 75.0,
        isNegative: true,
        date: DateTime.now().subtract(const Duration(days: 4)),
        details: "Commission deduction for AC Repair Invoice",
      ),
    ],
  };

  List<WalletTransaction> getWalletTransactions(String userId) {
    return _walletLogs[userId] ?? [];
  }

  // Live Location Tracker Simulation (Stores provider coordinates)
  Map<String, Map<String, double>> _technicianLocations = {
    "tech_1": {"lat": 23.8103, "lng": 90.4125},
  };
  Map<String, double>? getTechnicianLocation(String providerId) => _technicianLocations[providerId];

  // In-App Chat Simulation
  Map<String, List<ChatMessage>> _chats = {
    "tech_1_buyer_1": [
      ChatMessage(
        id: "msg_1",
        senderId: "tech_1",
        senderName: "Rahim Electrician",
        message: "Hello, I am on my way to your location.",
        time: DateTime.now().subtract(const Duration(minutes: 10)),
      ),
    ],
    "retailer_1_buyer_1": [
      ChatMessage(
        id: "msg_2",
        senderId: "retailer_1",
        senderName: "Eco Retail Mart",
        message: "Thank you for shopping with us! Your order is being prepared.",
        time: DateTime.now().subtract(const Duration(hours: 1)),
      ),
      ChatMessage(
        id: "msg_3",
        senderId: "buyer_1",
        senderName: "Anisur Rahman",
        message: "When will it be shipped?",
        time: DateTime.now().subtract(const Duration(minutes: 45)),
      ),
      ChatMessage(
        id: "msg_4",
        senderId: "retailer_1",
        senderName: "Eco Retail Mart",
        message: "It will be shipped by this evening.",
        time: DateTime.now().subtract(const Duration(minutes: 30)),
      ),
    ],
    "wholesaler_1_buyer_1": [
      ChatMessage(
        id: "msg_5",
        senderId: "wholesaler_1",
        senderName: "Grand Wholesale Ltd.",
        message: "Hello! We have sent over the quotation for bulk items.",
        time: DateTime.now().subtract(const Duration(days: 1)),
      ),
    ],
  };

  Map<String, List<ChatMessage>> get chats => _chats;

  List<ChatMessage> getChatHistory(String providerId, String buyerId) {
    String key = "${providerId}_$buyerId";
    return _chats[key] ?? [];
  }

  void sendChatMessage(String providerId, String buyerId, String message, String senderId, String senderName, [String? imageUrl]) {
    String key = "${providerId}_$buyerId";
    if (!_chats.containsKey(key)) {
      _chats[key] = [];
    }
    _chats[key]!.add(
      ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        senderId: senderId,
        senderName: senderName,
        message: message,
        time: DateTime.now(),
        imageUrl: imageUrl,
      ),
    );
    notifyListeners();
  }

  // Shopping Cart
  late final List<OrderItem> _cart = [
    OrderItem(product: _products.first, quantity: 1),
  ];
  List<OrderItem> get cart => _cart;

  void addToCart(Product product, int quantity) {
    int idx = _cart.indexWhere((item) => item.product.id == product.id);
    if (idx != -1) {
      _cart[idx] = OrderItem(product: product, quantity: _cart[idx].quantity + quantity);
    } else {
      _cart.add(OrderItem(product: product, quantity: quantity));
    }
    notifyListeners();
  }

  void removeFromCart(String productId) {
    _cart.removeWhere((item) => item.product.id == productId);
    notifyListeners();
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  // --- Auth logic ---
  void setSelectedRole(UserRole role) {
    _selectedRole = role;
    notifyListeners();
  }

  bool login(String phone) {
    try {
      _currentUser = _users.firstWhere((u) => u.phone == phone && u.role == _selectedRole);
      notifyListeners();
      return true;
    } catch (_) {
      return false;
    }
  }

  void loginWithGoogle() {
    String email = "buyer@gmail.com";
    try {
      _currentUser = _users.firstWhere((u) => u.email == email && u.role == UserRole.buyer);
    } catch (_) {
      final newUser = AppUser(
        id: "buyer_1",
        name: "Anisur Rahman",
        phone: "01644444444",
        birthDate: "1998-03-05",
        role: UserRole.buyer,
        isNidVerified: true,
        isApproved: true,
        email: email,
      );
      _users.add(newUser);
      _currentUser = newUser;
    }
    notifyListeners();
  }

  void registerUser({
    required String name,
    required String phone,
    required String email,
    required String birthDate,
    required UserRole role,
    String? nidImagePath,
  }) {
    final newUser = AppUser(
      id: "usr_${DateTime.now().millisecondsSinceEpoch}",
      name: name,
      phone: phone,
      email: email,
      birthDate: birthDate,
      role: role,
      nidImagePath: nidImagePath,
      isNidVerified: role == UserRole.buyer ? true : false,
      isApproved: role == UserRole.buyer ? true : false,
    );
    _users.add(newUser);
    _currentUser = newUser;
    notifyListeners();
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }

  // --- Admin features ---
  void verifyNid(String userId, bool verify) {
    int idx = _users.indexWhere((u) => u.id == userId);
    if (idx != -1) {
      _users[idx] = _users[idx].copyWith(isNidVerified: verify, isApproved: verify);
      notifyListeners();
    }
  }

  void updateCommissionRate(String category, double rate) {
    _categoryCommissions[category] = rate;
    notifyListeners();
  }

  void addCategory(String category) {
    if (!_categories.contains(category)) {
      _categories.add(category);
      _subcategories[category] = [];
      _categoryCommissions[category] = 10.0;
      notifyListeners();
    }
  }

  void deleteCategory(String category) {
    _categories.remove(category);
    _subcategories.remove(category);
    _categoryCommissions.remove(category);
    notifyListeners();
  }

  void approveProduct(String productId, bool approve) {
    int idx = _products.indexWhere((p) => p.id == productId);
    if (idx != -1) {
      _products[idx] = _products[idx].copyWith(isApproved: approve);
      notifyListeners();
    }
  }

  void adminOverrideRating(String targetId, double rating) {
    // Reviews are used to calculate ranking. Override review stars.
    _reviews.add(
      ReviewModel(
        id: "rev_admin_${DateTime.now().millisecondsSinceEpoch}",
        targetId: targetId,
        reviewerName: "System Administrator",
        stars: rating,
        priceFairnessStars: rating,
        behaviorStars: rating,
        responseTimeStars: rating,
        comment: "Admin rating adjustment override.",
        date: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  // --- Product actions ---
  void addProduct(Product product) {
    _products.insert(0, product);
    notifyListeners();
  }

  // --- Booking / Service actions ---
  void bookTechnician({
    required String providerId,
    required String providerName,
    required String category,
    required DateTime date,
    required String slot,
    required String description,
    String? imagePath,
  }) {
    if (_currentUser == null) return;
    final booking = Booking(
      id: "book_${DateTime.now().millisecondsSinceEpoch}",
      buyerId: _currentUser!.id,
      buyerName: _currentUser!.name,
      providerId: providerId,
      providerName: providerName,
      category: category,
      date: date,
      timeSlot: slot,
      issueDescription: description,
      imagePath: imagePath,
      status: BookingStatus.Requested,
    );
    _bookings.insert(0, booking);
    notifyListeners();
  }

  void updateBookingStatus(String bookingId, BookingStatus status) {
    int idx = _bookings.indexWhere((b) => b.id == bookingId);
    if (idx != -1) {
      _bookings[idx] = _bookings[idx].copyWith(status: status);
      notifyListeners();
    }
  }

  void raiseInvoice(String bookingId, double amount) {
    int idx = _bookings.indexWhere((b) => b.id == bookingId);
    if (idx != -1) {
      _bookings[idx] = _bookings[idx].copyWith(
        invoiceAmount: amount,
        isInvoiceRaised: true,
        status: BookingStatus.Completed,
      );
      
      // Deduct commission from Service Provider wallet immediately
      String providerId = _bookings[idx].providerId;
      String category = _bookings[idx].category;
      double commissionRate = _categoryCommissions[category] ?? 10.0;
      double commissionAmount = (amount * commissionRate) / 100.0;

      // Update provider balance (balance goes negative representing pending commission payment)
      _deductCommission(providerId, commissionAmount, "Commission on Booking $bookingId (Category: $category)");
      notifyListeners();
    }
  }

  // --- Order features ---
  void placeOrder(String address) {
    if (_currentUser == null || _cart.isEmpty) return;

    // Group items by Seller
    Map<String, List<OrderItem>> grouped = {};
    for (var item in _cart) {
      grouped.putIfAbsent(item.product.sellerId, () => []).add(item);
    }

    for (var entry in grouped.entries) {
      String sellerId = entry.key;
      var items = entry.value;
      double total = items.fold(0.0, (sum, item) => sum + (item.product.price * item.quantity));
      String shopName = items.first.product.shopName;

      final order = OrderModel(
        id: "ORD-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}",
        buyerId: _currentUser!.id,
        buyerName: _currentUser!.name,
        sellerId: sellerId,
        shopName: shopName,
        items: items,
        totalAmount: total,
        status: OrderStatus.PickedUp,
        date: DateTime.now(),
      );
      _orders.insert(0, order);
    }

    clearCart();
  }

  void updateOrderStatus(String orderId, OrderStatus status) {
    int idx = _orders.indexWhere((o) => o.id == orderId);
    if (idx != -1) {
      _orders[idx] = _orders[idx].copyWith(status: status);
      notifyListeners();
    }
  }

  void adminPassOrder(String orderId) {
    int idx = _orders.indexWhere((o) => o.id == orderId);
    if (idx != -1 && !_orders[idx].isApprovedByAdmin) {
      _orders[idx] = _orders[idx].copyWith(isApprovedByAdmin: true);
      
      // Calculate and deduct commission from seller's wallet
      OrderModel order = _orders[idx];
      double totalCommission = 0.0;
      for (var item in order.items) {
        double rate = _categoryCommissions[item.product.category] ?? 10.0;
        double lineTotal = item.product.price * item.quantity;
        totalCommission += (lineTotal * rate) / 100.0;
      }
      
      _deductCommission(order.sellerId, totalCommission, "Commission on Admin passed order ${order.id}");
      notifyListeners();
    }
  }

  void _deductCommission(String userId, double amount, String details) {
    int idx = _users.indexWhere((u) => u.id == userId);
    if (idx != -1) {
      double newBalance = _users[idx].walletBalance - amount;
      _users[idx] = _users[idx].copyWith(walletBalance: newBalance);

      if (!_walletLogs.containsKey(userId)) {
        _walletLogs[userId] = [];
      }
      _walletLogs[userId]!.add(
        WalletTransaction(
          id: "tx_${DateTime.now().millisecondsSinceEpoch}",
          type: "commission",
          amount: amount,
          isNegative: true,
          date: DateTime.now(),
          details: details,
        ),
      );
    }
  }

  // Pay/recharge commission through bKash
  void payAdminViaBKash(String userId, double amount) {
    int idx = _users.indexWhere((u) => u.id == userId);
    if (idx != -1) {
      double newBalance = _users[idx].walletBalance + amount;
      _users[idx] = _users[idx].copyWith(walletBalance: newBalance);

      if (!_walletLogs.containsKey(userId)) {
        _walletLogs[userId] = [];
      }
      _walletLogs[userId]!.add(
        WalletTransaction(
          id: "tx_bkash_${DateTime.now().millisecondsSinceEpoch}",
          type: "bKash",
          amount: amount,
          isNegative: false,
          date: DateTime.now(),
          details: "bKash payment wallet auto-credit of $amount BDT",
        ),
      );
      notifyListeners();
    }
  }

  void addReview(String targetId, String reviewerName, double stars, String comment, {double price = 5.0, double behavior = 5.0, double response = 5.0}) {
    _reviews.add(
      ReviewModel(
        id: "rev_${DateTime.now().millisecondsSinceEpoch}",
        targetId: targetId,
        reviewerName: reviewerName,
        stars: stars,
        priceFairnessStars: price,
        behaviorStars: behavior,
        responseTimeStars: response,
        comment: comment,
        date: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  double getAverageRating(String targetId) {
    var list = _reviews.where((r) => r.targetId == targetId).toList();
    if (list.isEmpty) return 5.0;
    double sum = list.fold(0.0, (acc, r) => acc + r.stars);
    return sum / list.length;
  }
}
