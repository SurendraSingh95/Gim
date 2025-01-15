import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PageViewWithProgressLine extends StatefulWidget {
  const PageViewWithProgressLine({super.key});

  @override
  _PageViewWithProgressLineState createState() =>
      _PageViewWithProgressLineState();
}

class _PageViewWithProgressLineState extends State<PageViewWithProgressLine> {
  final PageController _pageController = PageController();
  int currentPage = 0;
  final int totalPages = 5;
  final ImagePicker _picker = ImagePicker();
  final List<File> _images = [];

  Future<void> _pickImagesFromGallery() async {
    final List<XFile>? pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles != null) {
      setState(() {
        _images.addAll(pickedFiles.map((file) => File(file.path)).toList());
      });
    }
    Navigator.pop(context);
  }

  Future<void> _pickImageFromCamera() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _images.add(File(pickedFile.path)); // Store captured image
      });
    }
    Navigator.pop(context);
  }

  void _showImagePickerBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Pick from Gallery'),
                onTap: _pickImagesFromGallery,
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take a Photo'),
                onTap: _pickImageFromCamera,
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PageView with Custom UI"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: LinearProgressIndicator(
              value: (currentPage + 1) / totalPages,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Text(
              "Step ${currentPage + 1}/$totalPages",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(
            height: 50,
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: totalPages,
              scrollDirection: Axis.vertical,
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                if (index == 0) {
                  return _buildPage1();
                } else if (index == 1) {
                  return _buildPage2();
                } else if (index == 2) {
                  return _buildPage3();
                } else if (index == 3) {
                  return _buildPage4();
                } else {
                  return _buildPage5();
                }
              },
            ),
          ),


          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back Button
                ElevatedButton(
                  onPressed: currentPage > 0
                      ? () {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        currentPage > 0 ? Colors.blue : Colors.grey,
                  ),
                  child: const Text("Back"),
                ),

                ElevatedButton(
                  onPressed: currentPage < totalPages - 1
                      ? () {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      : null, // Disable if on the last page
                  style: ElevatedButton.styleFrom(
                    backgroundColor: currentPage < totalPages - 1
                        ? Colors.blue
                        : Colors.orangeAccent,
                  ),
                  child: const Text("Next"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildPage1() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            const SizedBox(height: 20),
        
            // Text Widget
            const Text(
              "Do You have seat belts on \n all seats of your vehicle",
              style: TextStyle(fontSize: 24, color: Colors.black),
            ),
            const SizedBox(height: 20),
        
            const Text(
              "Add Photos",
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            _images.isNotEmpty
                ? Wrap(
              spacing: 8.0, // Horizontal space between images
              runSpacing: 8.0, // Vertical space between rows
              children: _images.map((image) {
                return Container(
                  width: (MediaQuery.of(context).size.width - 32) / 3, // 3 images in a row, 16px padding on both sides
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.file(
                      image,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }).toList(),
            )
                : Text('No images selected'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: (){
                        _showImagePickerBottomSheet();
                      },
                        child: const Icon(Icons.camera_alt,size: 100,color: Colors.black12,)),
                  ],
                ),
            const Text(
              "Add Comment",
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextFormField(
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Enter something',
                  hintText: 'Type here...',
                  filled: true,

                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildPage2() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            const SizedBox(height: 20),

            // Text Widget
            const Text(
              "Do You have enough fuel \n in your vehicle?",
              style: TextStyle(fontSize: 24, color: Colors.black),
            ),
            const SizedBox(height: 20),

            const Text(
              "Add Photos",
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            _images.isNotEmpty
                ? Wrap(
              spacing: 8.0, // Horizontal space between images
              runSpacing: 8.0, // Vertical space between rows
              children: _images.map((image) {
                return Container(
                  width: (MediaQuery.of(context).size.width - 32) / 3, // 3 images in a row, 16px padding on both sides
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.file(
                      image,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }).toList(),
            )
                : Text('No images selected'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                    onTap: (){
                      _showImagePickerBottomSheet();
                    },
                    child: const Icon(Icons.camera_alt,size: 100,color: Colors.black12,)),
              ],
            ),
            const Text(
              "Add Comment",
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextFormField(
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Enter something',
                  hintText: 'Type here...',
                  filled: true,

                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
  Widget _buildPage3() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            const SizedBox(height: 20),

            // Text Widget
            const Text(
              "Do You have enough fuel \n in your vehicle?",
              style: TextStyle(fontSize: 24, color: Colors.black),
            ),
            const SizedBox(height: 20),

            const Text(
              "Add Photos",
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            _images.isNotEmpty
                ? Wrap(
              spacing: 8.0, // Horizontal space between images
              runSpacing: 8.0, // Vertical space between rows
              children: _images.map((image) {
                return Container(
                  width: (MediaQuery.of(context).size.width - 32) / 3, // 3 images in a row, 16px padding on both sides
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.file(
                      image,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }).toList(),
            )
                : Text('No images selected'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                    onTap: (){
                      _showImagePickerBottomSheet();
                    },
                    child: const Icon(Icons.camera_alt,size: 100,color: Colors.black12,)),
              ],
            ),
            const Text(
              "Add Comment",
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextFormField(
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Enter something',
                  hintText: 'Type here...',
                  filled: true,

                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
  Widget _buildPage4() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            const SizedBox(height: 20),

            // Text Widget
            const Text(
              "Do You have enough fuel \n in your vehicle?",
              style: TextStyle(fontSize: 24, color: Colors.black),
            ),
            const SizedBox(height: 20),

            const Text(
              "Add Photos",
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            _images.isNotEmpty
                ? Wrap(
              spacing: 8.0, // Horizontal space between images
              runSpacing: 8.0, // Vertical space between rows
              children: _images.map((image) {
                return Container(
                  width: (MediaQuery.of(context).size.width - 32) / 3, // 3 images in a row, 16px padding on both sides
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.file(
                      image,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }).toList(),
            )
                : Text('No images selected'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                    onTap: (){
                      _showImagePickerBottomSheet();
                    },
                    child: const Icon(Icons.camera_alt,size: 100,color: Colors.black12,)),
              ],
            ),
            const Text(
              "Add Comment",
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextFormField(
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Enter something',
                  hintText: 'Type here...',
                  filled: true,

                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
  Widget _buildPage5() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            const SizedBox(height: 20),

            // Text Widget
            const Text(
              "Do You have enough fuel \n in your vehicle?",
              style: TextStyle(fontSize: 24, color: Colors.black),
            ),
            const SizedBox(height: 20),

            const Text(
              "Add Photos",
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            _images.isNotEmpty
                ? Wrap(
              spacing: 8.0, // Horizontal space between images
              runSpacing: 8.0, // Vertical space between rows
              children: _images.map((image) {
                return Container(
                  width: (MediaQuery.of(context).size.width - 32) / 3, // 3 images in a row, 16px padding on both sides
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.file(
                      image,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }).toList(),
            )
                : Text('No images selected'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                    onTap: (){
                      _showImagePickerBottomSheet();
                    },
                    child: const Icon(Icons.camera_alt,size: 100,color: Colors.black12,)),
              ],
            ),
            const Text(
              "Add Comment",
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextFormField(
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Enter something',
                  hintText: 'Type here...',
                  filled: true,

                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
