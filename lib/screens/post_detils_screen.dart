import 'package:flutter/material.dart';

class PostDetails extends StatelessWidget {
  // final String imageUrl;
  // final String title;
  // final String content;

  // PostDetailsPage(
  //     {required this.imageUrl, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.network(
                "https://www.thedrive.com/uploads/2023/03/22/new-camaro-lead.jpg?auto=webp&crop=16%3A9&auto=webp&optimize=high&quality=70&width=1440",
                fit: BoxFit.cover,
                height: 200,
              ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "title",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "content",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
