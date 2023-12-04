import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';
import 'home.dart';
import 'post.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:io';

// class NewPost extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _NewPost();
//   }
// }

class NewPost extends StatefulWidget {
  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  TextEditingController caption = TextEditingController();
  TextEditingController image = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late File _imageFile;

  Future<void> _pickImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      setState(() {
        _imageFile = File(result.files.single.path!);
        image.text = _imageFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "New Post Feed Social Hub",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: caption,
                decoration: InputDecoration(
                  icon: Icon(Icons.person),
                  labelText: "Enter your caption",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter your caption';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: image,
                readOnly: true,
                decoration: InputDecoration(
                  icon: Icon(Icons.image),
                  labelText: "Image Path",
                  suffixIcon: IconButton(
                    icon: Icon(Icons.folder_open),
                    onPressed: _pickImage,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Select an image';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                   try {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Post created successfully!'),
                        ),
                      );
                      print(image.text);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(
                            caption: caption.text,
                            postImage:  image.text, // Pass the file path as string
                          ),
                        ),
                      );
                    }
                   } catch (e) {
                      print("Error navigating: $e");
                    }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}