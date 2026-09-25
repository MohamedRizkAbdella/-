import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../store/farm_store.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final store = context.watch<FarmStore>();
    return ListView(padding: const EdgeInsets.all(24), children: [
      Text(store.t('مرحباً بك في مزرعتك 👋', 'Welcome to your farm 👋'), style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
      const SizedBox(height: 6), Text(store.t('نظرة سريعة على الأداء المالي', 'A quick look at your financial performance'), style: const TextStyle(color: Colors.black54)),
      const SizedBox(height: 24),
      LayoutBuilder(builder: (_, c) { final w = c.maxWidth > 900 ? (c.maxWidth - 48) / 4 : (c.maxWidth - 16) / 2; return Wrap(spacing: 16, runSpacing: 16, children: [
        _Metric(width: w, label: store.t('الرصيد الحالي', 'Current balance'), value: store.balance, icon: Icons.account_balance_wallet, color: const Color(0xff2f7d5b)),
        _Metric(width: w, label: store.t('إجمالي الإيرادات', 'Total income'), value: store.income, icon: Icons.arrow_upward, color: Colors.blue),
        _Metric(width: w, label: store.t('إجمالي المصروفات', 'Total expenses'), value: store.expenses, icon: Icons.arrow_downward, color: Colors.orange),
        _Metric(width: w, label: store.t('عدد العمليات', 'Transactions'), value: store.transactions.length.toDouble(), icon: Icons.receipt_long, color: Colors.purple, currency: false),
      ]); }),
      const SizedBox(height: 24),
      Card(child: Padding(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(store.t('حركة آخر 7 أيام', 'Last 7 days activity'), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)), const SizedBox(height: 20), const SizedBox(height: 150, child: _SimpleChart())]))),
      const SizedBox(height: 24), Text(store.t('أحدث العمليات', 'Recent transactions'), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)), const SizedBox(height: 8),
      ...store.transactions.take(4).map((x) => ListTile(leading: CircleAvatar(backgroundColor: x.type == TransactionType.income ? Colors.green.shade100 : Colors.orange.shade100, child: Icon(x.type == TransactionType.income ? Icons.arrow_upward : Icons.arrow_downward, color: x.type == TransactionType.income ? Colors.green : Colors.orange)), title: Text(x.category), subtitle: Text(x.description), trailing: Text('${x.type == TransactionType.income ? '+' : '-'} ${x.amount.toStringAsFixed(0)}'),)),
    ]);
  }
}
class _Metric extends StatelessWidget { const _Metric({required this.width, required this.label, required this.value, required this.icon, required this.color, this.currency = true}); final double width, value; final String label; final IconData icon; final Color color; final bool currency; @override Widget build(BuildContext context) => SizedBox(width: width, child: Card(child: Padding(padding: const EdgeInsets.all(18), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [CircleAvatar(backgroundColor: color.withOpacity(.12), child: Icon(icon, color: color)), const SizedBox(height: 14), Text(label, style: const TextStyle(color: Colors.black54)), const SizedBox(height: 5), Text('${value.toStringAsFixed(currency ? 0 : 0)}${currency ? ' ج.م' : ''}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold))])))); }
class _SimpleChart extends StatelessWidget { const _SimpleChart(); @override Widget build(BuildContext context) => CustomPaint(painter: _ChartPainter(), child: const SizedBox.expand()); }
class _ChartPainter extends CustomPainter { @override void paint(Canvas c, Size s) { final p = Paint()..color = const Color(0xff2f7d5b)..strokeWidth = 4..style = PaintingStyle.stroke..strokeCap = StrokeCap.round; final path = Path()..moveTo(10, s.height*.78)..cubicTo(s.width*.18, s.height*.45, s.width*.28, s.height*.72, s.width*.42, s.height*.35)..cubicTo(s.width*.57, s.height*.05, s.width*.68, s.height*.55, s.width*.82, s.height*.25)..quadraticBezierTo(s.width*.92, s.height*.08, s.width-10, s.height*.18); c.drawPath(path, p); } @override bool shouldRepaint(_) => false; }
