class TransactionModel {
  final String id;
  final String userId;
  final double amount;
  final String type; // 'pemasukan' atau 'pengeluaran'
  final String? category;
  final String? description;
  final DateTime createdAt;

  TransactionModel({
    required this.id,
    required this.userId,
    required this.amount,
    required this.type,
    this.category,
    this.description,
    required this.createdAt,
  });

  // Mengubah data dari Supabase (JSON) menjadi objek Flutter
  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      // Menangani konversi angka dengan aman
      amount: (json['amount'] as num).toDouble(),
      type: json['type'] as String,
      category: json['category'] as String?,
      description: json['description'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  // Mengubah objek Flutter menjadi data (JSON) untuk dikirim ke Supabase
  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'type': type,
      'category': category,
      'description': description,
      // id, user_id, dan created_at akan diurus otomatis oleh Supabase
    };
  }
}
