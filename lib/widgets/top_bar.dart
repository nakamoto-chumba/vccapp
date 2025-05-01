import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MaterialApp(home: TaskPage()));
}

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  List<String> bookTitles = [];
  bool isLoading = true; // To show loading indicator while fetching books

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

      // Debugging: print the response
      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Debugging: check the data structure
        print("Decoded data: $data");

        // Safely check if 'items' exists and is not empty
        if (data['items'] != null && data['items'].isNotEmpty) {
          setState(() {
            // Extract titles from the response correctly
            bookTitles =
                data['items']
                    .map<String>(
                      (book) =>
                          book['volumeInfo']['title']?.toString() ?? 'No title',
                    )
                    .toList();
            isLoading = false; // Stop loading once data is fetched
          });
        } else {
          setState(() {
            bookTitles = [];
            isLoading = false; // No books found
          });
        }
      } else {
        throw Exception('Failed to load books');
      }
    } catch (e) {
      print("Error fetching books: $e");
      setState(() {
        isLoading = false; // Stop loading in case of error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: const Text('Task', style: TextStyle(color: Colors.white)),
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
              _taskStatBox(Icons.alarm, "5", "Ongoing"),
              _progressCircle(),
              _taskStatBox(Icons.check_circle, "0", "Completed"),
            ],
          ),
          const SizedBox(height: 30),
          _tabSection(),
          const SizedBox(height: 10),
          isLoading
              ? Center(
                child: CircularProgressIndicator(),
              ) // Show loading indicator
              : _bookList(),
        ],
      ),
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

  Widget _tabSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: const [
          TabItem(label: "All", selected: true),
          SizedBox(width: 20),
          TabItem(label: "Ongoing"),
          SizedBox(width: 20),
          TabItem(label: "Completed"),
        ],
      ),
    );
  }

  Widget _bookList() {
    return Expanded(
      child: ListView.builder(
        itemCount: bookTitles.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              bookTitles[index],
              style: const TextStyle(color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}

class TabItem extends StatelessWidget {
  final String label;
  final bool selected;

  const TabItem({super.key, required this.label, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            color: selected ? Colors.yellow : Colors.white54,
            fontWeight: FontWeight.bold,
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
