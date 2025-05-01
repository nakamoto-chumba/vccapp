import 'package:flutter/material.dart';

class FinancialOverviewWidget extends StatelessWidget {
  const FinancialOverviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: const Icon(Icons.wb_sunny, color: Colors.blue),
        title: const Text(
          'Let\'s take a look at your financial overview for October!',
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {},
      ),
    );
  }
}
