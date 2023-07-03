import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';

class AddSafeAreaPage extends StatefulWidget {
  @override
  _AddSafeAreaPageState createState() => _AddSafeAreaPageState();
}

class _AddSafeAreaPageState extends State<AddSafeAreaPage> {
  File? _selectedImage;
  TextEditingController locationController = TextEditingController();
  TextEditingController buildingNameController = TextEditingController();
  TextEditingController buildingInfoController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController coordinatesController = TextEditingController();
  TextEditingController distanceController = TextEditingController();

  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null) {
        _selectedImage = File(pickedImage.path);
      }
    });
  }

  Future<void> _uploadImageAndSaveData() async {
    if (_selectedImage == null) {
      return;
    }

    final storage = FirebaseStorage.instance;
    final imageName = DateTime.now().millisecondsSinceEpoch.toString();
    final storageRef = storage.ref().child('images/$imageName.jpg');
    final uploadTask = storageRef.putFile(_selectedImage! as File);

    final downloadUrl = await (await uploadTask).ref.getDownloadURL();
    saveDataToFirestore(downloadUrl.toString());
  }

  void saveDataToFirestore(String imageUrl) {
    String location = locationController.text;
    String buildingName = buildingNameController.text;
    String buildingInfo = buildingInfoController.text;
    String address = addressController.text;
    String coordinates = coordinatesController.text;
    String distance = distanceController.text;

    List<String> coordinateList = coordinates.split(',');
    double latitude = double.parse(coordinateList[0].trim());
    double longitude = double.parse(coordinateList[1].trim());

    GeoPoint coordinateGeopoint = GeoPoint(latitude, longitude);

    FirebaseFirestore.instance.collection('safe_areas').add({
      'building_name': buildingName,
      'building_info': buildingInfo,
      'location': location,
      'address': address,
      'coordinates': coordinateGeopoint,
      'distance': distance,
      'image_url': imageUrl,
    });

    Navigator.pop(context);
  }

  Future<Position?> _selectLocation() async {
    final position = await Navigator.push<Position?>(
      context,
      MaterialPageRoute(builder: (context) => MapPage()),
    );
    return position;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Toplanma Alanı Ekle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bina Bilgileri',
              style: TextStyle(fontFamily: 'SFPro', fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              controller: buildingNameController,
              decoration: InputDecoration(labelText: 'Bina İsmi'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: buildingInfoController,
              decoration: InputDecoration(labelText: 'Bina Bilgileri'),
            ),
            SizedBox(height: 20),
            Text(
              'Konum Bilgileri',
              style: TextStyle(fontFamily: 'SFPro', fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                final position = await _selectLocation();
                if (position != null) {
                  coordinatesController.text = '${position.latitude}, ${position.longitude}';
                }
              },
              child: Text('Konum Seç'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: addressController,
              decoration: InputDecoration(labelText: 'Açık Adres'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: coordinatesController,
              decoration: InputDecoration(labelText: 'Koordinatlar'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: distanceController,
              decoration: InputDecoration(labelText: 'Kullanıcının Konumuna Olan Uzaklık'),
            ),
            SizedBox(height: 20),
            Text(
              'Fotoğraf Ekle',
              style: TextStyle(fontFamily: 'SFPro', fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _selectImage,
              child: Text('Fotoğraf Seç'),
            ),
            if (_selectedImage != null)
              Image.file(
                _selectedImage!,
                height: 200,
              ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _uploadImageAndSaveData,
              child: Text('Onayla'),
            ),
          ],
        ),
      ),
    );
  }
}

class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Harita'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high,
            );

            Navigator.pop(context, position);
          },
          child: Text('Konum Seçildi'),
        ),
      ),
    );
  }
}
