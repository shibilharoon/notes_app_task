import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes_app_task/model/note_model.dart';
import 'package:notes_app_task/service/auth_service.dart';

class FireStoreService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuthServices auth = FirebaseAuthServices();
  addNotes({String? title, String? note}) async {
    DocumentReference docRef = firestore
        .collection('users')
        .doc(auth.auth.currentUser!.uid)
        .collection('notes')
        .doc();
    NoteModel notes = NoteModel(title: title, description: note, id: docRef.id);
    await docRef.set(notes.toJson());
  }

  Stream<List<NoteModel>> getNotes() {
    return firestore
        .collection('users')
        .doc(auth.auth.currentUser!.uid)
        .collection('notes')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => NoteModel.fromJson(doc.data()))
            .toList());
  }

  Future<void> deleteNote(String documentId) async {
    try {
      await firestore
          .collection('users')
          .doc(auth.auth.currentUser!.uid)
          .collection('notes')
          .doc(documentId)
          .delete();
      print('Note deleted successfully');
    } catch (error) {
      print('Error deleting note: $error');
    }
  }

  updateNotes({String? documentId, String? newTitle, String? newNote}) async {
    try {
      await firestore
          .collection('users')
          .doc(auth.auth.currentUser!.uid)
          .collection('notes')
          .doc(documentId!)
          .update({
        'title': newTitle,
        'notes': newNote,
      });
      print('Note updated successfully');
    } catch (error) {
      print('Error updating note: $error');
    }
  }
}
