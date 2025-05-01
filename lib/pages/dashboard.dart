import 'package:flutter/material.dart';
import 'package:vcc/widgets/WalletBalanceWidget.dart';
import 'package:vcc/widgets/FinancialOverviewWidget.dart';
import 'package:vcc/widgets/SavingGoalsWidget.dart';
import 'package:vcc/widgets/TransactionHistoryWidget.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const WalletBalanceWidget(visible: true),
              const SizedBox(height: 20),
              const SavingGoalsWidget(),
              const SizedBox(height: 20),
              const FinancialOverviewWidget(),
              const SizedBox(height: 20),
              const TransactionHistoryWidget(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
