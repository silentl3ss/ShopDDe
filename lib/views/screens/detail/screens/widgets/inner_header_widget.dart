import 'package:flutter/material.dart';

class InnerHeaderWidget extends StatelessWidget {
  const InnerHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 120, // Chiều cao cố định tối ưu hơn
      child: Stack(
        children: [
          // Banner Image
          Positioned.fill(
            child: Image.asset(
              'assets/icons/searchBanner.jpeg',
              fit: BoxFit.cover,
            ),
          ),

          // Back Button
          Positioned(
            left: 16,
            top: 32, // Giảm khoảng cách xuống
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),

          // Search Bar
          Positioned(
            left: 64,
            top: 32, // Giảm khoảng cách xuống
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              height: 40, // Giảm chiều cao search bar
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter text',
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF7F7F7F),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8, // Tinh chỉnh lại padding
                  ),
                  prefixIcon: Image.asset('assets/icons/searc1.png'),
                  suffixIcon: Image.asset('assets/icons/cam.png'),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),

          // Bell Icon
          Positioned(
            right: 64,
            top: 36,
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                onTap: () {},
                child: Ink(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/icons/bell.png'),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Message Icon
          Positioned(
            right: 16,
            top: 36,
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                onTap: () {},
                child: Ink(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/icons/message.png'),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
