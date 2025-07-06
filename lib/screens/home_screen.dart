import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../widgets/bottom_nav.dart';
import 'chat_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isOnline = true;
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(-6.200000, 106.816666);
  final Set<Marker> _markers = {
    const Marker(
      markerId: MarkerId('job1'),
      position: LatLng(-6.202, 106.818),
      infoWindow: InfoWindow(title: 'Order Cleaning Rumah'),
    ),
    const Marker(
      markerId: MarkerId('job2'),
      position: LatLng(-6.198, 106.814),
      infoWindow: InfoWindow(title: 'Service AC'),
    ),
  };

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Widget quickActionButton(
      {required IconData icon,
      required String label,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.orange.shade100,
            child: Icon(icon, color: Colors.orange, size: 28),
          ),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 13))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        title: const Text(
          'Beresin - Worker',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Status
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            isOnline ? Icons.toggle_on : Icons.toggle_off,
                            color: isOnline ? Colors.green : Colors.grey,
                            size: 36,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            isOnline ? 'Status: Online' : 'Status: Offline',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: isOnline ? Colors.green : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Switch(
                        value: isOnline,
                        activeColor: Colors.green,
                        onChanged: (value) {
                          setState(() {
                            isOnline = value;
                          });
                        },
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Ringkasan Hari Ini
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Ringkasan Hari Ini',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      SizedBox(height: 12),
                      Text('• Pendapatan: Rp 250.000'),
                      SizedBox(height: 4),
                      Text('• Order Selesai: 4')
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Order Masuk
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/orderlist'); // Pastikan route ini sudah terdaftar
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade100,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '🔔 2 Order Masuk',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        Icon(Icons.chevron_right, color: Colors.black54),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),


                // Akses Cepat
                const Text('Akses Cepat',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    quickActionButton(
                  icon: Icons.account_balance_wallet,
                  label: 'Dompet',
                  onTap: () {
                    Navigator.pushNamed(context, '/dompet');
                  },
                ),


                    quickActionButton(
                      icon: Icons.history,
                      label: 'Riwayat',
                      onTap: () {
                        Navigator.pushNamed(context, '/riwayat');
                      },
                    ),

                    quickActionButton(
                      icon: Icons.chat,
                      label: 'Chat',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ChatScreen(chatId: 'order123_user456_worker789'), // ← Ganti dengan ID dinamis kalau ada
                          ),
                        );
                      },
                    ),
                    quickActionButton(
                      icon: Icons.book,
                      label: 'CMS',
                      onTap: () {},
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Peta Order
                const Text('Pekerjaan di Sekitar Anda',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: SizedBox(
                    height: 250,
                    child: GoogleMap(
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: _center,
                        zoom: 14.0,
                      ),
                      markers: _markers,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }
}
