import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart'; // Tambahkan ini

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<Map<String, dynamic>> orders = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final newOrders = args?['newOrders'] as List<Map<String, dynamic>>? ?? [];

    // Tambahkan status default "sedang dikerjakan"
    orders = newOrders.map((order) {
      return {
        ...order,
        'status': 'sedang dikerjakan',
      };
    }).toList();
  }

  void _selesaikanPesanan(int index) async {
    final completedOrder = orders[index];

    setState(() {
      orders.removeAt(index);
    });

    // --- Firebase Simpan ke History ---
    final workerId = completedOrder['workerId'] ?? 'worker001'; // ganti ini jika kamu pakai FirebaseAuth
    final orderId = 'order${DateTime.now().millisecondsSinceEpoch}';
    final selesaiPada = DateTime.now().toString();

    final historyRef = FirebaseDatabase.instance
        .ref('history/$workerId/$orderId');

    await historyRef.set({
      'layanan': completedOrder['layanan'],
      'alamat': completedOrder['alamat'],
      'namaPengguna': completedOrder['namaPengguna'],
      'status': 'selesai',
      'timestamp': completedOrder['timestamp'] ?? DateTime.now().millisecondsSinceEpoch,
      'selesaiPada': selesaiPada,
    });

    // Navigasi ke halaman riwayat sambil kirim data
    Navigator.pushNamed(
      context,
      '/riwayat',
      arguments: {
        'completedOrder': completedOrder,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesanan Masuk'),
      ),
      body: orders.isEmpty
          ? const Center(child: Text("Belum ada pesanan."))
          : ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: const Icon(Icons.assignment_turned_in),
                    title: Text(order['layanan'] ?? 'Layanan Tidak Diketahui'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Nama: ${order['namaPengguna'] ?? '-'}"),
                        Text("Alamat: ${order['alamat'] ?? '-'}"),
                        Text("Status: ${order['status']}"),
                      ],
                    ),
                    trailing: ElevatedButton(
                      onPressed: () => _selesaikanPesanan(index),
                      child: const Text("Selesaikan"),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
