import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:http/http.dart' as http;
import 'package:news_app/bottom_nav.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../api.dart';

class EditPost extends StatefulWidget {
  final String id;
  final String title;
  // String image;
  final String desc;
  const EditPost(
      {required this.id,
      required this.desc,
      required this.title,
      // required this.image,
      super.key});

  @override
  State<EditPost> createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? _pickedImageFile;

  @override
  void initState() {
    _titleController.text = widget.title;
    _descriptionController.text = widget.desc;

    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  String userName = "";

  Future getUserName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      userName = preferences.getString("userName2")!;
    });
  }

  void _getImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) {
      return;
    }
    setState(() {
      _pickedImageFile = File(pickedImage.path);
    });

    // widget.onSelectedImage(_pickedImageFile!);
  }

  Future createPost() async {
    final url = Uri.parse("${Config.baseUrl}/newsappapi/post_api.php?update");

    var request = await http.MultipartRequest("POST", url);
    request.fields['title'] = _titleController.text;
    request.fields['desc'] = _descriptionController.text;
    request.fields["username"] = userName;
    request.fields["id"] = widget.id;

    var pic =
        await http.MultipartFile.fromPath("image", _pickedImageFile!.path);
    request.files.add(pic);

    var response = await request.send();

    if (response.statusCode == 200) {
      print("image uploaded seccssfully");
    } else {
      print("eroro");
    }
    //  var data = json.decode(response.b)

    // if(data =="hhh"){

    // }
  }

  @override
  Widget build(BuildContext context) {
    getUserName();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eidt Post'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _descriptionController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
              ),
              const SizedBox(height: 16.0),
              _pickedImageFile == null
                  ? ElevatedButton.icon(
                      onPressed: _getImage,
                      icon: const Icon(Icons.add_a_photo),
                      label: const Text('Add a photo'),
                    )
                  : Column(
                      children: [
                        Text(_pickedImageFile!.path),
                        Image.file(
                          _pickedImageFile!,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 16.0),
                        ElevatedButton.icon(
                          onPressed: _getImage,
                          icon: const Icon(Icons.edit),
                          label: const Text('Change photo'),
                        ),
                      ],
                    ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Upload post data to server
                  createPost().then((value) => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyHomePage())));
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Post Updated"),
                  ));
                },
                child: const Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
