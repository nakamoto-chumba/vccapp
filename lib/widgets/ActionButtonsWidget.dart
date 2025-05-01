import 'package:flutter/material.dart';

class ActionButtonsWidget extends StatelessWidget {
  const ActionButtonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          _ActionButton(icon: Icons.arrow_upward, label: 'Transfer'),
          _ActionButton(icon: Icons.arrow_downward, label: 'Withdraw'),
          _ActionButton(icon: Icons.attach_money, label: 'Invest'),
          _ActionButton(icon: Icons.add, label: 'Top up'),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ActionButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.white24,
          radius: 28,
          child: Icon(icon, color: Colors.white),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.white)),
      ],
    );
  }
}
