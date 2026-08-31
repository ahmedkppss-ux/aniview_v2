import 'package:flutter/material.dart';

void main() {
  runApp(const AniViewApp());
}

class AniViewApp extends StatelessWidget {
  const AniViewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AniView',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0A0E17),
        primaryColor: const Color(0xFF8A2BE2),
      ),
      home: const MainNavigationScreen(),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;
  
  final List<Map<String, dynamic>> _allContent = [
    {"title": "Shadow Heir", "type": "أنمي ياباني", "episodes": "24 حلقة", "img": "https://unsplash.com"},
    {"title": "Love in Seoul", "type": "مسلسل كوري", "episodes": "16 حلقة", "img": "https://unsplash.com"},
    {"title": "Action Hero", "type": "فيلم أجنبي", "episodes": "ساعتان", "img": "https://unsplash.com"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AniView', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
        backgroundColor: const Color(0xFF111625),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('المحتوى التلقائي الشائع 🔥', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: _allContent.length,
                itemBuilder: (context, index) {
                  final item = _allContent[index];
                  return Card(
                    color: const Color(0xFF1A1F31),
                    margin: const EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ContentDetailScreen(item: item)));
                      },
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)),
                            child: Image.network(item['img'], width: 100, height: 100, fit: BoxFit.cover),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item['title'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 4),
                                Text(item['type'], style: const TextStyle(color: Color(0xFF8A2BE2))),
                                Text(item['episodes'], style: const TextStyle(color: Colors.white60, fontSize: 12)),
                              ],
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios, color: Colors.white24, size: 16),
                          const SizedBox(width: 16),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: const Color(0xFF111625),
        selectedItemColor: const Color(0xFF8A2BE2),
        unselectedItemColor: Colors.white60,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.tv), label: 'المسلسلات'),
          BottomNavigationBarItem(icon: Icon(Icons.local_movies), label: 'الأفلام'),
        ],
      ),
    );
  }
}

class ContentDetailScreen extends StatefulWidget {
  final Map<String, dynamic> item;
  const ContentDetailScreen({super.key, required this.item});

  @override
  State<ContentDetailScreen> createState() => _ContentDetailScreenState();
}

class _ContentDetailScreenState extends State<ContentDetailScreen> {
  final TextEditingController _commentController = TextEditingController();
  double _rating = 0.0;
  final List<Map<String, String>> _comments = [
    {"user": "أحمد", "text": "رهيب جداً والترجمة احترافية! 🔥"},
    {"user": "سارة", "text": "متحمسة للحلقات القادمة التلقائية."}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item['title']),
        backgroundColor: const Color(0xFF111625),
      ),
      body: Column(
        children: [
          Container(
            height: 220,
            color: Colors.black,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.network(widget.item['img'], width: double.infinity, fit: BoxFit.cover, opacity: const AlwaysStoppedAnimation(0.4)),
                IconButton(
                  icon: const Icon(Icons.play_circle_fill, size: 64, color: Color(0xFF8A2BE2)),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('جاري الاتصال تلقائياً بأسرع سيرفر مشاهدة مجاني...')),
                    );
                  },
                ),
                Positioned(
                  bottom: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.horizontal(8, 4),
                    color: Colors.black80,
                    child: const Text('سيرفر مجاني 1 (سريع)', style: TextStyle(fontSize: 12)),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.between,
              children: [
                const Text('تقييمك للعمل بالكامل:', style: TextStyle(fontWeight: FontWeight.bold)),
                Row(
                  children: List.generate(5, (index) {
                    return InkWell(
                      onTap: () => setState(() => _rating = index + 1.0),
                      child: Icon(index < _rating ? Icons.star : Icons.star_border, color: Colors.amber, size: 24),
                    );
                  }),
                )
              ],
            ),
          ),
          const Divider(color: Colors.white12, height: 1),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _comments.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const CircleAvatar(backgroundColor: Color(0xFF8A2BE2), child: Icon(Icons.person, color: Colors.white)),
                  title: Text(_comments[index]['user']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  subtitle: Text(_comments[index]['text']!, style: const TextStyle(color: Colors.white70, fontSize: 13)),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: const Color(0xFF111625),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: 'اكتب تعليقك في شات الحلقة...',
                      filled: true,
                      fillColor: const Color(0xFF1A1F31),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                      contentPadding: const EdgeInsets.horizontal(16),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Color(0xFF8A2BE2)),
                  onPressed: () {
                    if (_commentController.text.isNotEmpty) {
                      setState(() {
                        _comments.add({"user": "أنا", "text": _commentController.text});
                        _commentController.clear();
                      });
                    }
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
