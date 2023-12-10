class TransactionsMain {
  final double amount;
  final String description; // You can add a description if needed
  final DateTime timestamp;
  final String? sender;
  final String? reciever;
  final bool isEditable;
  final double balance;

  TransactionsMain({
    required this.amount,
    required this.description,
    required this.timestamp,
    required this.reciever,
    required this.sender,
    required this.balance,
    required this.isEditable,
  });

  // Create a method to convert the transaction data to a map
  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'description': description,
      'timestamp': timestamp,
      'sender': sender,
      'receiver': reciever,
      'balance': balance,
      'isEditable': isEditable,
    };
  }

  // Create a factory method to create a transaction object from a map
  factory TransactionsMain.fromMap(Map<String, dynamic> map) {
    return TransactionsMain(
      amount: map['amount'],
      description: map['description'],
      timestamp: map['timestamp'],
      sender: map['sender'],
      reciever: map['receiver'],
      balance: map['balance'],
      isEditable: map['isEditable'],
    );
  }
}
