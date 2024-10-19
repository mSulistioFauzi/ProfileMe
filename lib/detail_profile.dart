import 'package:flutter/material.dart';
import 'navbar_profil.dart';

class Page2 extends StatefulWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  // List untuk menampung konten secara dinamis
  List<Map<String, String>> sections = [
    {'title': 'About', 'content': 'Saya berusia 17 tahun, merupakan anak pertama dari dua bersaudara. '
        'Saat ini, saya sedang menempuh pendidikan di SMK Wikrama Bogor dengan jurusan '
        'Pengembangan Perangkat Lunak dan Gim (PPLG).'},
    {'title': 'History', 'content': 'Saya pernah meraih prestasi dalam hobi saya bermain sepak bola, termasuk juara 1 '
        'dan 3 di tingkat kabupaten. Saya juga melanjutkan turnamen hingga ke tingkat provinsi '
        'dan sering dipanggil ke Jakarta untuk mengikuti kompetisi.'},
    {'title': 'Skills', 'content': 'Saya sedang mengembangkan keahlian dalam bidang yang saya pelajari di sekolah, '
        'khususnya di jurusan Pengembangan Perangkat Lunak dan Gim (PPLG). Selain itu, '
        'saya juga memiliki keahlian dalam hobi saya bermain sepak bola.'},
  ];

  // TextEditingController untuk input data baru
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  // Fungsi untuk menambah data baru
  void _addSection() {
    setState(() {
      sections.add({
        'title': _titleController.text,
        'content': _contentController.text,
      });
      _titleController.clear();
      _contentController.clear();
    });
  }

  // Fungsi untuk mengedit data yang sudah ada
  void _editSection(int index) {
    setState(() {
      sections[index] = {
        'title': _titleController.text,
        'content': _contentController.text,
      };
      _titleController.clear();
      _contentController.clear();
    });
  }

  // Fungsi untuk menghapus data
  void _deleteSection(int index) {
    setState(() {
      sections.removeAt(index);
    });
  }

  // Fungsi untuk memunculkan dialog input untuk tambah/edit
  void _showInputDialog({int? index}) {
    if (index != null) {
      _titleController.text = sections[index]['title']!;
      _contentController.text = sections[index]['content']!;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(index == null ? 'Add Section' : 'Edit Section'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: _contentController,
                decoration: InputDecoration(labelText: 'Content'),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (index == null) {
                  _addSection();
                } else {
                  _editSection(index);
                }
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page 2'),
        backgroundColor: const Color.fromARGB(255, 64, 47, 255),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.teal.shade50],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          image: DecorationImage(
            image: AssetImage('assets/images/bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Gambar atau Logo di bagian atas
              ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: Image.asset(
                  'assets/images/1.png',
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),

              // Daftar section dinamis
              ...sections.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, String> section = entry.value;
                return Column(
                  children: [
                    _buildInfoCard(section['title']!, section['content']!, index),
                    const SizedBox(height: 20),
                  ],
                );
              }).toList(),

              // Tombol untuk menambah section baru
              ElevatedButton(
                onPressed: () => _showInputDialog(),
                child: Text('Add New Section'),
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: Navbar(),
    );
  }

  // Widget untuk menampilkan Card dinamis
  Widget _buildInfoCard(String title, String content, int index) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => _showInputDialog(index: index),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _deleteSection(index),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: const TextStyle(
                fontSize: 16,
                fontFamily: 'Roboto',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
