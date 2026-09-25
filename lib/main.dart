import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'store/farm_store.dart';
import 'ui/app_shell.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ChangeNotifierProvider(create: (_) => FarmStore(), child: const MyFarmAccountsApp()));
}

class MyFarmAccountsApp extends StatelessWidget {
  const MyFarmAccountsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FarmStore>(
      builder: (_, store, __) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: store.t('حسابات مزرعتي', 'My Farm Accounts'),
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff2f7d5b), brightness: Brightness.light),
          scaffoldBackgroundColor: const Color(0xfff5f8f5),
          inputDecorationTheme: const InputDecorationTheme(border: OutlineInputBorder()),
        ),
        locale: Locale(store.languageCode),
        builder: (context, child) => Directionality(textDirection: store.isArabic ? TextDirection.rtl : TextDirection.ltr, child: child!),
        home: const AppShell(),
      ),
    );
  }
}
