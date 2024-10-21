import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'detail_profile.dart';
import 'login_page.dart';
import 'navbar_profil.dart';

class ProfilPage extends StatelessWidget {
  final String username;
  final String role;
  final String deskripsi;
  final String sekolah;
  const ProfilPage({super.key, required this.username, required this.role, required this.deskripsi, required this.sekolah});

  // Fungsi untuk logout, yaitu menghapus token
  Future<void> logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token'); // Menghapus token dari SharedPreferences

    // Navigasi kembali ke halaman login setelah logout
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) =>  LoginPage()),
          (Route<dynamic> route) => false, // Hapus semua halaman sebelumnya
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg.jpg'), // Akses gambar langsung dari assets
                fit: BoxFit.cover, // Mengatur gambar agar mengisi container
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center column secara vertikal
              children: [
                Container(
                  margin: const EdgeInsets.all(20.0), // Margin di sekitar container
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0), // Padding di dalam container
                      child: Column(
                        children: [
                          ClipOval(
                            child: Image.asset(
                              'assets/images/ciww.jpeg', // Akses gambar langsung dari assets
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Hi, $username',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Roboto',
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '$role',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                              fontFamily: 'Roboto',
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '$deskripsi',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Roboto',
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '$sekolah',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Roboto',
                            ),
                            textAlign: TextAlign.center,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const Navbar()),
                              );
                            },
                            child: const Text(
                              'See More',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16,
                                fontFamily: 'Roboto',
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () async {
                              await logout(context); // Proses logout
                            },
                            child: const Text(
                              'Logout',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Roboto',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
