import 'package:flutter/material.dart';

class TransactionHistoryWidget extends StatelessWidget {
  const TransactionHistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Transaction History',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                'See All',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 220, // You can adjust this height as needed
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              _TransactionItem(
                name: 'Alice Burgers',
                amount: '\$500',
                date: 'April 27, 2025',
                profileImage: 'assets/profile_placeholder.png',
              ),
              _TransactionItem(
                name: 'Investment',
                amount: '\$1200',
                date: 'April 26, 2025',
                profileImage: 'assets/investment_placeholder.png',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TransactionItem extends StatelessWidget {
  final String name;
  final String amount;
  final String date;
  final String profileImage;

  const _TransactionItem({
    required this.name,
    required this.amount,
    required this.date,
    required this.profileImage,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(profileImage),
        radius: 24,
      ),
      title: Text(
        name,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      subtitle: Text(
        date,
        style: const TextStyle(fontSize: 12, color: Colors.grey),
      ),
      trailing: Text(
        amount,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.black,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }
}
