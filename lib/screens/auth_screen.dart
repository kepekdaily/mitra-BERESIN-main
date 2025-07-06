import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Image.asset(
              'assets/beresin.png',
              height: 40, // ← dibesarin
              width: 40,
            ),
            const SizedBox(width: 8),
            const Text(
              'Beresin Worker',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 32),

            // Logo tengah
            Center(
              child: Image.asset(
                'assets/aseet2.png', // ← gambar tengah
                width: 120,
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Selamat datang di Beresin Worker!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 8),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Aplikasi Beresin Worker bantu kamu cari pekerjaan harian, bersih-bersih,\ndan jasa logistik dalam satu sentuhan.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54),
              ),
            ),

            const SizedBox(height: 32),

            // Tombol Masuk
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Masuk',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Tombol Daftar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  side: const BorderSide(color: Colors.orange),
                ),
                child: const Text(
                  'Belum punya akun? Daftar',
                  style: TextStyle(color: Colors.orange, fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
