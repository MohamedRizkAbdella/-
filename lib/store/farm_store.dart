import 'package:flutter/foundation.dart';

class FarmTransaction {
  FarmTransaction({required this.id, required this.type, required this.category, required this.description, required this.amount, required this.date});
  final String id;
  final TransactionType type;
  String category;
  String description;
  double amount;
  DateTime date;
}

enum TransactionType { income, expense }

class FarmStore extends ChangeNotifier {
  bool isArabic = true;
  int selectedIndex = 0;
  String get languageCode => isArabic ? 'ar' : 'en';

  final List<FarmTransaction> transactions = [
    FarmTransaction(id: '1', type: TransactionType.income, category: 'بيع تمر / Dates sale', description: 'موسم 2026', amount: 18500, date: DateTime(2026, 9, 22)),
    FarmTransaction(id: '2', type: TransactionType.expense, category: 'عمالة / Labor', description: 'أجور العمال', amount: 4200, date: DateTime(2026, 9, 21)),
    FarmTransaction(id: '3', type: TransactionType.expense, category: 'ري / Irrigation', description: 'صيانة شبكة الري', amount: 1250, date: DateTime(2026, 9, 18)),
  ];

  String t(String ar, String en) => isArabic ? ar : en;
  double get income => transactions.where((x) => x.type == TransactionType.income).fold(0, (s, x) => s + x.amount);
  double get expenses => transactions.where((x) => x.type == TransactionType.expense).fold(0, (s, x) => s + x.amount);
  double get balance => income - expenses;

  void toggleLanguage() { isArabic = !isArabic; notifyListeners(); }
  void navigate(int index) { selectedIndex = index; notifyListeners(); }
  void add(FarmTransaction item) { transactions.insert(0, item); notifyListeners(); }
  void update(FarmTransaction item) { notifyListeners(); }
  void remove(String id) { transactions.removeWhere((x) => x.id == id); notifyListeners(); }
}
