class PaymentData {
  final double grandTotal;
  final List<PaymentItem> data;

  PaymentData({
    required this.grandTotal,
    required this.data,
  });

  factory PaymentData.fromJson(Map<String, dynamic> json) {
    return PaymentData(
      grandTotal: json['grand_total'].toDouble(),
      data: List<PaymentItem>.from(
        json['data'].map((item) => PaymentItem.fromJson(item)),
      ),
    );
  }
}

class PaymentItem {
  final int id;
  final int quantity;
  final String currency;
  final String transactionId;
  final String paymentAt;
  final Product product;
  final double totalPayment;

  PaymentItem({
    required this.id,
    required this.quantity,
    required this.currency,
    required this.transactionId,
    required this.paymentAt,
    required this.product,
    required this.totalPayment,
  });

  factory PaymentItem.fromJson(Map<String, dynamic> json) {
    return PaymentItem(
      id: json['id'],
      quantity: json['quantity'],
      currency: json['currency'],
      transactionId: json['transaction_id'],
      paymentAt: (json['payment_at']),
      product: Product.fromJson(json['product']),
      totalPayment: json['total_payment'].toDouble(),
    );
  }
}

class Product {
  final int id;
  final String name;
  final double price;
  final String plan;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.plan,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
      plan: json['plan'],
    );
  }
}
