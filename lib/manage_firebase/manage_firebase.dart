import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ManagerFirebaseAuth{
  FirebaseAuth _auth = FirebaseAuth.instance;




  static final ManagerFirebaseAuth _managerFirebaseAuth = ManagerFirebaseAuth.internal();
  ManagerFirebaseAuth.internal();
  factory ManagerFirebaseAuth(){
    return _managerFirebaseAuth;
  }
  createUserEmailAndPassword(String email,String password) async {
    UserCredential? userCredential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password
    );
    if(userCredential.user != null){
      return userCredential;
    }

  }
  Future<UserCredential>? loginUser(String email,String password)async {
    UserCredential usuario = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password
    );
    if(usuario.user?.uid != null){
      return usuario;
    }else{
      return usuario;
    }
  }
  checkUser(){
    User? user  = _auth.currentUser;
    if(user != null){
      return user;
    }
  }


  exit()async{
    await _auth.signOut();
  }


}

class ManagerFirebaseFirestore {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  ManagerFirebaseAuth managerFirebaseAuth = ManagerFirebaseAuth();
  saveData()async{
    User? usuario = managerFirebaseAuth.checkUser();
    if(usuario != null){
      _db.collection('creditos').doc().set({'teste':'teste'});
    }
  }
}

class ManagerFirebaseStorage{

}
