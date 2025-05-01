import 'package:flutter/material.dart';

class SavingGoalsWidget extends StatelessWidget {
  const SavingGoalsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Saving Goals',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('\$41,287 of \$150,874 USD'),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: 41287 / 150874,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            const SizedBox(height: 8),
            const Text('\$8,000 USD remaining to achieve your goals'),
          ],
        ),
      ),
    );
  }
}
