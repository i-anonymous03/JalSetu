import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Mobile-only Google sign-in
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
  );

  // Auth state listener
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // Get current user
  User? get currentUser => _firebaseAuth.currentUser;

  // ------------------ EMAIL SIGN-IN ------------------
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      debugPrint('Email sign-in error: ${e.message}');
      rethrow;
    }
  }

  // ------------------ EMAIL REGISTER ------------------
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password, String role, Map<String, dynamic> userData) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'email': user.email,
          'role': role,
          ...userData,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      return userCredential;
    } on FirebaseAuthException catch (e) {
      debugPrint('Email registration error: ${e.message}');
      rethrow;
    }
  }

  // ------------------ GOOGLE SIGN-IN ------------------
  Future<UserCredential> signInWithGoogle(String role) async {
    try {
      // Trigger Google sign-in
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw FirebaseAuthException(
          code: 'USER_CANCELLED',
          message: 'Sign-in was cancelled by the user.',
        );
      }

      // Obtain auth details
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase
      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      // Store user data in Firestore (if new)
      final user = userCredential.user;
      if (user != null) {
        final userDoc = _firestore.collection('users').doc(user.uid);
        final snapshot = await userDoc.get();
        if (!snapshot.exists) {
          await userDoc.set({
            'uid': user.uid,
            'email': user.email,
            'displayName': user.displayName,
            'photoURL': user.photoURL,
            'role': role,
            'createdAt': FieldValue.serverTimestamp(),
          });
        }
      }

      return userCredential;
    } catch (e) {
      debugPrint('Google sign-in error: $e');
      rethrow;
    }
  }

  // ------------------ SIGN OUT ------------------
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut(); // Disconnect Google session
      await _firebaseAuth.signOut();
    } catch (e) {
      debugPrint('Sign-out error: $e');
      rethrow;
    }
  }

  // ------------------ RESET PASSWORD ------------------
  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      debugPrint('Password reset error: ${e.message}');
      rethrow;
    }
  }

  // ------------------ GET USER ROLE ------------------
  Future<String?> getUserRole(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return doc.data()?['role'] as String?;
      }
      return null;
    } catch (e) {
      debugPrint('Error getting user role: $e');
      return null;
    }
  }

  // ------------------ UPDATE PROFILE ------------------
  Future<void> updateUserProfile(String uid, Map<String, dynamic> updates) async {
    try {
      await _firestore.collection('users').doc(uid).update(updates);
    } catch (e) {
      debugPrint('Error updating user profile: $e');
      rethrow;
    }
  }

  // ------------------ DELETE ACCOUNT ------------------
  Future<void> deleteUserAccount() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).delete();
        await user.delete();
      }
    } catch (e) {
      debugPrint('Error deleting user account: $e');
      rethrow;
    }
  }
}
