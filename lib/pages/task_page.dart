import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

void main() {
  runApp(const MaterialApp(home: TaskPage()));
}

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  List<Map<String, dynamic>> bookDetails = [];
  bool isLoading = true;
  int completedTasks = 0;
  double progress = 0.0;
  int selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  Future<void> fetchBooks() async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://www.googleapis.com/books/v1/volumes?q=subject:fiction&maxResults=5',
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['items'] != null && data['items'].isNotEmpty) {
          setState(() {
            bookDetails =
                data['items'].map<Map<String, dynamic>>((book) {
                  return {
                    'title': book['volumeInfo']['title'],
                    'author':
                        book['volumeInfo']['authors']?.join(", ") ??
                        'Unknown Author',
                    'imageUrl':
                        book['volumeInfo']['imageLinks']?['thumbnail'] ?? '',
                    'isRated': false,
                    'rating': 0.0,
                  };
                }).toList();
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
          });
        }
      } else {
        throw Exception('Failed to load books');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error fetching books: $e");
    }
  }

  void _submitRating(int index, double rating) {
    setState(() {
      bookDetails[index]['isRated'] = true;
      bookDetails[index]['rating'] = rating;
      completedTasks = bookDetails.where((b) => b['isRated']).length;
      progress = (completedTasks / bookDetails.length) * 100;
    });
  }

  // Method to change the selected tab
  void _onTabSelected(int index) {
    setState(() {
      selectedTabIndex = index;
    });
  }

  void _showRateDialog(int index, double earning) {
    double selectedRating = 0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: Colors.black87,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              title: const Text(
                "Rate this book",
                style: TextStyle(color: Colors.white),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 10),
                  // Wrap the Row in a SingleChildScrollView to prevent overflow
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (i) {
                        return IconButton(
                          icon: Icon(
                            i < selectedRating ? Icons.star : Icons.star_border,
                            color:
                                Colors
                                    .amber
                                    .shade300, // Lighter color for stars
                          ),
                          onPressed: () {
                            setDialogState(() {
                              selectedRating = (i + 1).toDouble();
                            });
                            Future.delayed(
                              const Duration(milliseconds: 300),
                              () {
                                Navigator.pop(context);
                                _submitRating(index, selectedRating);
                              },
                            );
                          },
                          iconSize: 30, // Adjust icon size
                        );
                      }),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _taskStatBox(IconData icon, String number, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Icon(icon, color: Colors.yellow, size: 30),
              const SizedBox(height: 10),
              Text(
                number,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(label, style: const TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _progressCircle() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 80,
              height: 80,
              child: CircularProgressIndicator(
                value: 0.0,
                strokeWidth: 6,
                backgroundColor: Colors.white24,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
              ),
            ),
            const Text(
              "0%",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Text("Progress", style: TextStyle(color: Colors.white)),
      ],
    );
  }

  Widget _progressCard() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade800,
      highlightColor: Colors.white24,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(12),
        ),
        width: double.infinity,
        height: 80,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(width: 120, height: 16, color: Colors.grey),
            const SizedBox(height: 12),
            Container(width: 200, height: 14, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _tabSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          TabItem(
            label: "All",
            selected: selectedTabIndex == 0, // Highlight if selected
            onTap: () => _onTabSelected(0), // Action on tap
          ),
          SizedBox(width: 20),
          TabItem(
            label: "Ongoing",
            selected: selectedTabIndex == 1, // Highlight if selected
            onTap: () => _onTabSelected(1), // Action on tap
          ),
          SizedBox(width: 20),
          TabItem(
            label: "Completed",
            selected: selectedTabIndex == 2, // Highlight if selected
            onTap: () => _onTabSelected(2), // Action on tap
          ),
        ],
      ),
    );
  }

  Widget _bookList() {
    return Expanded(
      child: ListView.builder(
        itemCount: bookDetails.length,
        itemBuilder: (context, index) {
          double earning = 1 + (index % 10) + 1;
          return ListTile(
            leading: Image.network(
              bookDetails[index]['imageUrl'] ?? '',
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(
              bookDetails[index]['title'] ?? '',
              style: const TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              "by ${bookDetails[index]['author']}",
              style: const TextStyle(color: Colors.white70),
            ),
            trailing:
                bookDetails[index]['isRated']
                    ? const Icon(Icons.star, color: Colors.yellow)
                    : ElevatedButton(
                      onPressed: () => _showRateDialog(index, earning),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow,
                        foregroundColor: Colors.black,
                      ),
                      child: const Text("Rate"),
                    ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int ongoingTasks = bookDetails.length - completedTasks;

    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: const Text('Book Rating', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _taskStatBox(Icons.alarm, "$ongoingTasks", "Ongoing"),
              _progressCircle(),
              _taskStatBox(Icons.check_circle, "$completedTasks", "Completed"),
            ],
          ),
          const SizedBox(height: 30),
          _tabSection(),
          const SizedBox(height: 10),
          isLoading ? Center(child: _progressCard()) : _bookList(),
        ],
      ),
    );
  }
}

class TabItem extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap; // Add onTap as a parameter

  const TabItem({
    super.key,
    required this.label,
    this.selected = false,
    required this.onTap, // Accept onTap in the constructor
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap, // Trigger onTap when the item is tapped
          child: Text(
            label,
            style: TextStyle(
              color: selected ? Colors.yellow : Colors.white54,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        if (selected)
          Container(
            margin: const EdgeInsets.only(top: 4),
            height: 3,
            width: 24,
            color: Colors.yellow,
          ),
      ],
    );
  }
}
