import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nexplore/core/themes/TextStyles.dart';

class MorePage extends StatefulWidget {
  const MorePage({super.key});
  static String id = 'MorePage';

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  // List of categories
  final List<String> categories = [
    'Action',
    'Romantic',
    'Comedy',
    'Drama',
    'Thriller',
    'Horror',
    'Adventure',
    'Sci-Fi',
    'Fantasy',
    'Mystery',
  ];

  // Selected category index
  int selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NexPlore', style: TextStyles.title),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Categories', style: TextStyles.title),
            SizedBox(height: 16),
            // Horizontal scrollable categories
            SizedBox(
              height: 50.w, // Height of each category item
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategoryIndex = index;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: selectedCategoryIndex == index
                              ? Colors.blue // Selected category color
                              : Colors
                                  .grey, // Default color for unselected categories
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Text(
                            categories[index],
                            style: const TextStyle(
                              color: Colors.white, // Text color
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
