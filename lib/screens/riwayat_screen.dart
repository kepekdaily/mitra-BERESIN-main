import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class RiwayatScreen extends StatelessWidget {
  const RiwayatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final historyRef = FirebaseDatabase.instance.ref().child('history').child(uid ?? 'null');

    return Scaffold(
      appBar: AppBar(title: const Text("Riwayat Pesanan")),
      body: StreamBuilder<DatabaseEvent>(
        stream: historyRef.onValue,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Terjadi kesalahan."));
          }

          if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
            return const Center(child: Text("Belum ada riwayat."));
          }

          final data = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
          final orders = data.values.toList();

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index] as Map<dynamic, dynamic>;
              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text(order['layanan'] ?? 'Layanan'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Alamat: ${order['alamat'] ?? '-'}"),
                      Text("Pelanggan: ${order['namaPengguna'] ?? '-'}"),
                      Text("Selesai pada: ${order['selesaiPada'] ?? '-'}"),
                    ],
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
