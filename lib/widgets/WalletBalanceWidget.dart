import 'package:flutter/material.dart';

class WalletBalanceWidget extends StatelessWidget {
  final bool visible;

  const WalletBalanceWidget({super.key, required this.visible});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Wallet Balance',
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),
        const SizedBox(height: 8),
        Text(
          visible ? '\$58,095' : '******',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
