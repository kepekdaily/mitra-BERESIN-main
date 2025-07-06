// lib/screens/category_page.dart
import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  final String categoryLabel;
  final IconData icon;

  const CategoryScreen({
    Key? key,
    required this.categoryLabel,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Contoh data pekerja dummy
    final List<Map<String, dynamic>> workers = [
      {'name': 'Ahmad', 'skill': 'Spesialis Mesin', 'rating': 4.6},
      {'name': 'Bayu', 'skill': 'Servis AC', 'rating': 4.8},
      {'name': 'Citra', 'skill': 'Montir Motor', 'rating': 4.7},
    ];

    return Scaffold(
      appBar: AppBar(title: Text(categoryLabel)),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemCount: workers.length,
        itemBuilder: (context, index) {
          final worker = workers[index];
          return Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                )
              ],
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue.shade100,
                  child: Icon(icon, color: Colors.blueAccent),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(worker['name'],
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      Text(worker['skill'],
                          style: TextStyle(color: Colors.grey[600])),
                    ],
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.star, size: 16, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text(worker['rating'].toString()),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
