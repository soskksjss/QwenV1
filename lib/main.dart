import 'package:flutter/material.dart';

void main() {
  runApp(const QwenApp());
}

class QwenApp extends StatelessWidget {
  const QwenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QWEN',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0D1117),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF4C8DFF),
          surface: Color(0xFF161B22),
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  ChatMessage({required this.text, required this.isUser});
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<ChatMessage> _messages = [
    ChatMessage(text: 'Hello! Main QWEN hoon. Main aapki kya madad kar sakta hoon?', isUser: false),
  ];
  final TextEditingController _controller = TextEditingController();

  String _qwenBrain(String input) {
    final q = input.toLowerCase();
    if (q.contains('hello') || q.contains('hi') || q.contains('namaste')) {
      return 'Hello Boss! Aap kaise hain?';
    }
    if (q.contains('name')) {
      return 'Mera naam QWEN hai. Main aapka personal AI assistant hoon.';
    }
    if (q.contains('time')) {
      return 'Abhi ka time ${TimeOfDay.now().format(context)} hai.';
    }
    if (q.contains('made') || q.contains('creator') || q.contains('banaya')) {
      return 'Mujhe mere Boss ne bahut mehnat se banaya hai!';
    }
    return 'Maine aapki baat samajh li hai. Abhi main learning stage mein hoon, jald hi real AI brain se connect ho jaunga.';
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add(ChatMessage(text: text, isUser: true));
    });
    _controller.clear();
    Future.delayed(const Duration(milliseconds: 600), () {
      setState(() {
        _messages.add(ChatMessage(text: _qwenBrain(text), isUser: false));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF161B22),
        title: const Text(
          'QWEN',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 3),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final m = _messages[index];
                return Align(
                  alignment: m.isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: m.isUser ? const Color(0xFF4C8DFF) : const Color(0xFF161B22),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(m.text, style: const TextStyle(color: Colors.white)),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'QWEN se kuch bhi pucho...',
                      hintStyle: TextStyle(color: Colors.grey.shade500),
                      filled: true,
                      fillColor: const Color(0xFF161B22),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 18),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Voice feature jald aa raha hai!')),
                    );
                  },
                  icon: const Icon(Icons.mic, color: Color(0xFF4C8DFF), size: 28),
                ),
                IconButton(
                  onPressed: _sendMessage,
                  icon: const Icon(Icons.send, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
