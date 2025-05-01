import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: JobListing()));
}

class JobListing extends StatelessWidget {
  const JobListing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(title: const Text('Job Levels')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          JobCard(
            title: 'intern',
            rebate: 'KES 18',
            tasks: 5,
            deposit: 'KES 0.00',
            isCurrent: true,
            badgeAsset:
                Icons.verified, // Replace with actual asset if available
            highlightColor: Colors.amber.shade300,
            buttonLabel: 'Current Job\nlevel',
          ),
          const SizedBox(height: 16),
          JobCard(
            title: 'Job1',
            rebate: 'KES 20',
            tasks: 5,
            deposit: 'KES 2800.00',
            isCurrent: false,
            badgeAsset: Icons.verified_user, // Replace with actual asset
            highlightColor: Colors.indigo.shade900,
            buttonLabel: 'Join Now',
          ),
        ],
      ),
    );
  }
}

class JobCard extends StatelessWidget {
  final String title;
  final String rebate;
  final int tasks;
  final String deposit;
  final bool isCurrent;
  final IconData badgeAsset;
  final Color highlightColor;
  final String buttonLabel;

  const JobCard({
    super.key,
    required this.title,
    required this.rebate,
    required this.tasks,
    required this.deposit,
    required this.isCurrent,
    required this.badgeAsset,
    required this.highlightColor,
    required this.buttonLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Rebate Per Order: $rebate'),
                    Text('Daily Tasks: $tasks'),
                    Text('Deposit Amount: $deposit'),
                  ],
                ),
              ),
              Column(
                children: [
                  Icon(badgeAsset, size: 48, color: highlightColor),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: isCurrent ? Colors.white : highlightColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      buttonLabel,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isCurrent ? Colors.black : Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: 18,
          left: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: highlightColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
