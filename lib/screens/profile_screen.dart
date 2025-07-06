import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? userData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    final ref = FirebaseDatabase.instance.ref().child('workers').child(uid);
    final snapshot = await ref.get();

    if (snapshot.exists) {
      setState(() {
        userData = Map<String, dynamic>.from(snapshot.value as Map);
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
        userData = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/home');
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Profil Saya"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : userData == null
                ? const Center(child: Text("Data tidak ditemukan"))
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        const CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              AssetImage('assets/profile_placeholder.png'),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          userData!['fullName'] ?? 'Tanpa Nama',
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          userData!['email'] ?? '-',
                          style:
                              const TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        const SizedBox(height: 24),

                        // Kartu informasi
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              Card(
                                elevation: 2,
                                child: ListTile(
                                  leading: const Icon(Icons.home),
                                  title: const Text("Alamat"),
                                  subtitle: Text(userData!['address'] ?? '-'),
                                ),
                              ),
                              Card(
                                elevation: 2,
                                child: ListTile(
                                  leading: const Icon(Icons.email),
                                  title: const Text("Email"),
                                  subtitle: Text(userData!['email'] ?? '-'),
                                ),
                              ),
                              Card(
                                elevation: 2,
                                child: ListTile(
                                  leading: const Icon(Icons.person),
                                  title: const Text("Nama Lengkap"),
                                  subtitle: Text(userData!['fullName'] ?? '-'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
      ),
    );
  }
}
