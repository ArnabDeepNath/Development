class TransactionsMain {
  final double amount;
  final String description; // You can add a description if needed
  final DateTime timestamp;

  TransactionsMain({
    required this.amount,
    required this.description,
    required this.timestamp,
  });

  // Create a method to convert the transaction data to a map
  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'description': description,
      'timestamp': timestamp,
    };
  }

  // Create a factory method to create a transaction object from a map
  factory TransactionsMain.fromMap(Map<String, dynamic> map) {
    return TransactionsMain(
      amount: map['amount'],
      description: map['description'],
      timestamp: map['timestamp'],
    );
  }
}
