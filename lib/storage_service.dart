import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Storage{
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;


  Future<firebase_storage.ListResult> listFiles() async{
    firebase_storage.ListResult results = await storage.ref('Encrypted').listAll();

    results.items.forEach((firebase_storage.Reference ref) {
      print('Found file: $ref');
    });

    return results;
  }

  Future<String> downloadURl(String fileName) async {
    String downloadURL = await storage.ref('Encrypted/$fileName').getDownloadURL();

    return downloadURL;
  }

  Future<void> deleteFile(String fileName) async {
    // Get a reference to the file
    final ref = storage.ref('Encrypted/$fileName');
    // Delete the file
    await ref.delete();
  }


}