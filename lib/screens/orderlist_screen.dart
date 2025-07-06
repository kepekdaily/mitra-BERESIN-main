import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  final DatabaseReference orderRef = FirebaseDatabase.instance.ref().child('orders');

  void updateStatus(String orderId, Map order, String newStatus) async {
    await orderRef.child(orderId).update({'status': newStatus});

    if (newStatus == 'diterima') {
      Navigator.pushReplacementNamed(
        context,
        '/orders',
        arguments: {
          'newOrders': [order],
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Order $orderId telah $newStatus')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Daftar Order Masuk")),
      body: StreamBuilder<DatabaseEvent>(
        stream: orderRef.onValue,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Terjadi kesalahan."));
          }

          if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
            return const Center(child: Text("Tidak ada order saat ini"));
          }

          final rawData = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;

          final orders = rawData.entries.map((e) {
            return {
              'id': e.key,
              ...Map<String, dynamic>.from(e.value),
            };
          }).toList();

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];

              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text(order['layanan'] ?? '-'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Pengguna: ${order['namaPengguna']}"),
                      Text("Alamat: ${order['alamat']}"),
                      Text("Status: ${order['status']}"),
                    ],
                  ),
                  trailing: order['status'] == 'pending'
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.check, color: Colors.green),
                              onPressed: () => updateStatus(order['id'], order, 'diterima'),
                            ),
                            IconButton(
                              icon: const Icon(Icons.close, color: Colors.red),
                              onPressed: () => updateStatus(order['id'], order, 'ditolak'),
                            ),
                          ],
                        )
                      : Text(
                          order['status'],
                          style: TextStyle(
                            color: order['status'] == 'diterima' ? Colors.green : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
