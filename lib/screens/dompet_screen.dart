import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class DompetScreen extends StatelessWidget {
  const DompetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final walletRef = FirebaseDatabase.instance.ref().child('wallets').child(uid ?? '');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dompet Saya'),
      ),
      body: StreamBuilder<DatabaseEvent>(
        stream: walletRef.onValue,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Terjadi kesalahan"));
          }
          if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
            return const Center(child: Text("Data dompet tidak tersedia"));
          }

          final data = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
          final walletData = Map<String, dynamic>.from(data);

          final saldo = walletData['saldo'] ?? 0;
          final transaksi = walletData['transactions'] ?? {};

          final transaksiList = transaksi.entries.toList()
            ..sort((a, b) => b.value['tanggal'].compareTo(a.value['tanggal']));

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Saldo Saat Ini',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text('Rp $saldo',
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 24),
                const Text('Riwayat Pemasukan',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Expanded(
                  child: transaksiList.isEmpty
                      ? const Center(child: Text("Belum ada transaksi"))
                      : ListView.builder(
                          itemCount: transaksiList.length,
                          itemBuilder: (context, index) {
                            final item = transaksiList[index].value;
                            return ListTile(
                              leading: const Icon(Icons.arrow_downward, color: Colors.green),
                              title: Text(item['keterangan']),
                              subtitle: Text(item['tanggal']),
                              trailing: Text('+Rp ${item['jumlah']}',
                                  style: const TextStyle(color: Colors.green)),
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
