import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../store/farm_store.dart';
import 'dashboard_screen.dart';
import 'transactions_screen.dart';
import 'management_screens.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key});
  @override
  Widget build(BuildContext context) {
    final store = context.watch<FarmStore>();
    final pages = [const DashboardScreen(), const TransactionsScreen(type: null), const TransactionsScreen(type: TransactionType.income), const TransactionsScreen(type: TransactionType.expense), const EmployeesScreen(), const InventoryScreen(), const ReportsScreen()];
    final wide = MediaQuery.sizeOf(context).width >= 900;
    return Scaffold(
      appBar: AppBar(title: Text(store.t('حسابات مزرعتي', 'My Farm Accounts'), style: const TextStyle(fontWeight: FontWeight.bold)), actions: [IconButton(onPressed: store.toggleLanguage, icon: const Icon(Icons.translate), tooltip: store.t('تغيير اللغة', 'Change language')), const SizedBox(width: 8)]),
      drawer: wide ? null : Drawer(child: _Navigation(onSelect: (i) { Navigator.pop(context); store.navigate(i); })),
      body: Row(children: [if (wide) SizedBox(width: 260, child: _Navigation(onSelect: store.navigate)), Expanded(child: pages[store.selectedIndex.clamp(0, pages.length - 1)])]),
      bottomNavigationBar: wide ? null : NavigationBar(selectedIndex: store.selectedIndex.clamp(0, 3), onDestinationSelected: store.navigate, destinations: [NavigationDestination(icon: const Icon(Icons.dashboard_outlined), label: store.t('الرئيسية', 'Home')), NavigationDestination(icon: const Icon(Icons.receipt_long), label: store.t('الحسابات', 'Accounts')), NavigationDestination(icon: const Icon(Icons.people_outline), label: store.t('الموظفون', 'Staff')), NavigationDestination(icon: const Icon(Icons.analytics_outlined), label: store.t('التقارير', 'Reports'))]),
    );
  }
}

class _Navigation extends StatelessWidget {
  const _Navigation({required this.onSelect});
  final ValueChanged<int> onSelect;
  @override
  Widget build(BuildContext context) {
    final store = context.watch<FarmStore>();
    final items = [(0, Icons.dashboard_outlined, 'الرئيسية', 'Dashboard'), (1, Icons.receipt_long_outlined, 'كل الحركات', 'Transactions'), (2, Icons.trending_up, 'الإيرادات', 'Income'), (3, Icons.trending_down, 'المصروفات', 'Expenses'), (4, Icons.people_outline, 'الموظفون والرواتب', 'Employees & payroll'), (5, Icons.inventory_2_outlined, 'المخزون والصوبة', 'Inventory & nursery'), (6, Icons.analytics_outlined, 'التقارير', 'Reports')];
    return ColoredBox(color: const Color(0xffeaf4ed), child: SafeArea(child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [Padding(padding: const EdgeInsets.all(24), child: Row(children: [const CircleAvatar(backgroundColor: Color(0xff2f7d5b), child: Icon(Icons.agriculture, color: Colors.white)), const SizedBox(width: 12), Expanded(child: Text(store.t('مزرعتي', 'My Farm'), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)))])), for (final item in items) ListTile(selected: store.selectedIndex == item.$1, leading: Icon(item.$2), title: Text(store.t(item.$3, item.$4)), onTap: () => onSelect(item.$1)), const Spacer(), const Divider(), Padding(padding: const EdgeInsets.all(16), child: Text(store.t('تصميم وتطوير: مهندس / محمد رزق عبداللا\nرقم الهاتف: 01126201133', 'Designed & developed by Eng. Mohamed Rizk Abdalla\nPhone: 01126201133'), style: const TextStyle(fontSize: 11, color: Colors.black54)))])));
  }
}
