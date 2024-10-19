import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'detail_profile.dart';
import 'detail_lainnya.dart';

// Definisikan ikon kustom
class CustomIcons {
  static const IconData add_reaction = IconData(0xe058, fontFamily: 'MaterialIcons');
  static const IconData another_icon = IconData(0xe059, fontFamily: 'MaterialIcons'); // Tambahkan ikon lain sesuai kebutuhan
}

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    // Inisialisasi controller hanya sekali
    final NavbarController controller = Get.put(NavbarController());

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => controller.selectedIndex.value = index,
          destinations: const [
            NavigationDestination(icon: Icon(CustomIcons.add_reaction), label: 'Reaksi'),
            NavigationDestination(icon: Icon(CustomIcons.another_icon), label: 'Lainnya'),
            // Tambahkan ikon dan label sesuai kebutuhan
          ],
        ),
      ),
      body: controller.screens[controller.selectedIndex.value],
    );
  }
}

class NavbarController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final List<Widget> screens = [
    Page2(),
    Lainnya(),
    // Center(child: Text('Halaman Utama')),
    // Center(child: Text('Halaman Lainnya')),
    // Lainnya(),
  ];
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const Navbar(),
  ));
}
