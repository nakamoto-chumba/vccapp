import 'package:flutter/material.dart';

class WealthPage extends StatefulWidget {
  const WealthPage({Key? key}) : super(key: key);

  @override
  State<WealthPage> createState() => _WealthPageState();
}

class _WealthPageState extends State<WealthPage> {
  // Simulated data – this would be fetched from an API later
  final List<Map<String, dynamic>> storagePeriods = [
    {
      "company": "Zurich Financial Services Group",
      "duration": "3 Day",
      "dailyProfit": "0.5%",
      "minDeposit": "KES 10",
      "progress": 7,
    },
    {
      "company": "Vanguard Group",
      "duration": "7 Day",
      "dailyProfit": "0.55%",
      "minDeposit": "KES 10",
      "progress": 0,
    },
    {
      "company": "Royal Bank of Canada",
      "duration": "30 Day",
      "dailyProfit": "0.65%",
      "minDeposit": "KES 10",
      "progress": 76,
    },
    {
      "company": "Fidelity Investments",
      "duration": "180 Day",
      "dailyProfit": "2.5%",
      "minDeposit": "KES 100",
      "progress": 7,
    },
    {
      "company": "Charles Schwab",
      "duration": "7 Day",
      "dailyProfit": "0.55%",
      "minDeposit": "KES 10",
      "progress": 100,
    },
    {
      "company": "WELLS FARGO",
      "duration": "One year",
      "dailyProfit": "1.7%",
      "minDeposit": "KES 100",
      "progress": 100,
    },
    {
      "company": "FWD Group",
      "duration": "3 Day",
      "dailyProfit": "2.5%",
      "minDeposit": "KES 10",
      "progress": null, // No progress bar for this one
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2D2D3A),
        elevation: 0,
        title: const Text('Wealth Fund', style: TextStyle(color: Colors.white)),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.schedule, color: Colors.white),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildEarningsCard(),
            const SizedBox(height: 24),
            const Text(
              'Storage Period',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: storagePeriods.length,
              itemBuilder: (context, index) {
                final data = storagePeriods[index];
                return _buildStorageCard(data);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEarningsCard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _earningsTile("Total Income", "KES 0"),
        _earningsTile("Today", "KES 0"),
      ],
    );
  }

  Widget _earningsTile(String title, String amount) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.fiber_manual_record,
                  size: 10,
                  color: Colors.orange,
                ),
                const SizedBox(width: 6),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              amount,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStorageCard(Map<String, dynamic> data) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Side: Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              'http://zpeyuam41.top/storage/files/20250425/03e5f26b0649e2baa7f55c2e9a7d469f.jpg',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),

          // Right Side: Info and Button
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Company Name
                Text(
                  data['company'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),

                Text(
                  data['duration'],
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                Text("Daily Profit: ${data['dailyProfit']}"),
                Text("Min Deposit: ${data['minDeposit']}"),

                if (data['progress'] != null) ...[
                  const SizedBox(height: 6),
                  LinearProgressIndicator(
                    value: (data['progress'] as int) / 100,
                    backgroundColor: Colors.grey[300],
                    color: Colors.amber,
                    minHeight: 6,
                  ),
                  const SizedBox(height: 4),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "${data['progress']}%",
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ],

                const SizedBox(height: 8),

                // Action Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Investing in ${data['company']}"),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 28, 139, 137),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Invest Now",
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
