import 'package:flutter_test/flutter_test.dart';
import 'package:my_farm_accounts/store/farm_store.dart';

void main() {
  test('calculates totals and payroll', () {
    final store = FarmStore();
    expect(store.income, 18500);
    expect(store.expenses, 5450);
    expect(store.balance, 13050);
    expect(store.payroll, 8300);
  });
  test('adds a transaction, employee, and stock item', () {
    final store = FarmStore();
    store.add(FarmTransaction(id: 't', type: TransactionType.income, category: 'x', description: 'x', amount: 100, date: DateTime.now()));
    store.addEmployee(Employee(id: 'e', name: 'New', phone: '0', salary: 1000));
    store.addStock(StockItem(id: 's', name: 'New', category: 'x', quantity: 1, unit: 'unit'));
    expect(store.transactions.any((x) => x.id == 't'), isTrue);
    expect(store.employees.length, 3);
    expect(store.stock.length, 3);
  });
}
