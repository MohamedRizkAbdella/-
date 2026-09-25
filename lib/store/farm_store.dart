import 'package:flutter/foundation.dart';

enum TransactionType { income, expense }
enum EmployeeStatus { active, inactive }

class FarmTransaction {
  FarmTransaction({required this.id, required this.type, required this.category, required this.description, required this.amount, required this.date, this.reference = ''});
  final String id;
  final TransactionType type;
  String category;
  String description;
  double amount;
  DateTime date;
  String reference;
}

class Employee {
  Employee({required this.id, required this.name, required this.phone, required this.salary, this.advance = 0, this.bonus = 0, this.status = EmployeeStatus.active});
  final String id;
  String name;
  String phone;
  double salary;
  double advance;
  double bonus;
  EmployeeStatus status;
  double get netSalary => salary - advance + bonus;
}

class StockItem {
  StockItem({required this.id, required this.name, required this.category, required this.quantity, required this.unit});
  final String id;
  String name;
  String category;
  double quantity;
  String unit;
}

class FarmStore extends ChangeNotifier {
  bool isArabic = true;
  int selectedIndex = 0;
  String search = '';
  String get languageCode => isArabic ? 'ar' : 'en';

  final List<FarmTransaction> transactions = [
    FarmTransaction(id: '1', type: TransactionType.income, category: 'بيع تمر', description: 'إيراد موسم 2026', amount: 18500, date: DateTime(2026, 9, 22)),
    FarmTransaction(id: '2', type: TransactionType.expense, category: 'عمالة', description: 'أجور العمال', amount: 4200, date: DateTime(2026, 9, 21)),
    FarmTransaction(id: '3', type: TransactionType.expense, category: 'ري', description: 'صيانة شبكة الري', amount: 1250, date: DateTime(2026, 9, 18)),
  ];
  final List<Employee> employees = [
    Employee(id: 'e1', name: 'أحمد محمد', phone: '01100000000', salary: 4500, bonus: 300),
    Employee(id: 'e2', name: 'محمود علي', phone: '01111111111', salary: 4000, advance: 500),
  ];
  final List<StockItem> stock = [
    StockItem(id: 's1', name: 'سماد عضوي', category: 'مستلزمات زراعية', quantity: 120, unit: 'كجم'),
    StockItem(id: 's2', name: 'شتلات بارحي', category: 'الصوبة الزراعية', quantity: 85, unit: 'شتلة'),
  ];

  String t(String ar, String en) => isArabic ? ar : en;
  double get income => transactions.where((x) => x.type == TransactionType.income).fold(0, (s, x) => s + x.amount);
  double get expenses => transactions.where((x) => x.type == TransactionType.expense).fold(0, (s, x) => s + x.amount);
  double get balance => income - expenses;
  double get payroll => employees.where((x) => x.status == EmployeeStatus.active).fold(0, (s, x) => s + x.netSalary);
  int get activeEmployees => employees.where((x) => x.status == EmployeeStatus.active).length;

  void toggleLanguage() { isArabic = !isArabic; notifyListeners(); }
  void navigate(int index) { selectedIndex = index; notifyListeners(); }
  void setSearch(String value) { search = value; notifyListeners(); }
  void add(FarmTransaction item) { transactions.insert(0, item); notifyListeners(); }
  void updateTransaction(FarmTransaction item) { final i = transactions.indexWhere((x) => x.id == item.id); if (i >= 0) transactions[i] = item; notifyListeners(); }
  void remove(String id) { transactions.removeWhere((x) => x.id == id); notifyListeners(); }
  void addEmployee(Employee item) { employees.add(item); notifyListeners(); }
  void addStock(StockItem item) { stock.add(item); notifyListeners(); }
}
