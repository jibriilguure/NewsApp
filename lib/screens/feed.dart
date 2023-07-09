// import 'package:flutter/material.dart';

// class NewsFeedPage extends StatefulWidget {
//   @override
//   _NewsFeedPageState createState() => _NewsFeedPageState();
// }

// class _NewsFeedPageState extends State<NewsFeedPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('News Feed'),
//       ),
//       body: ListView.builder(
//         itemCount: _newsItems.length,
//         itemBuilder: (BuildContext context, int index) {
//           return NewsCard(
//             newsItem: _newsItems[index],
//             onTap: () {
//               // Navigate to article details page
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// class NewsItem {
//   final String headline;
//   final String summary;
//   final String imageUrl;

//   NewsItem(
//       {required this.headline, required this.summary, required this.imageUrl});
// }

// class NewsCard extends StatelessWidget {
//   final NewsItem newsItem;
//   final VoidCallback onTap;

//   NewsCard({required this.newsItem, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: InkWell(
//         onTap: onTap,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             AspectRatio(
//               aspectRatio: 16 / 9,
//               child: Image.network(
//                 newsItem.imageUrl,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             SizedBox(height: 8),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     newsItem.headline,
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     'By Guure',
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Colors.grey,
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     newsItem.summary,
//                     style: TextStyle(
//                       fontSize: 14,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 8),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     '2 hours ago',
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Colors.grey,
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       IconButton(
//                         icon: Icon(Icons.favorite_border),
//                         onPressed: () {},
//                       ),
//                       IconButton(
//                         icon: Icon(Icons.share),
//                         onPressed: () {},
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
