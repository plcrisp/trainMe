import { Injectable } from '@angular/core';
import { AngularFireObject } from '@angular/fire/compat/database';
import { AngularFirestore, AngularFirestoreCollection } from '@angular/fire/compat/firestore';
import { User } from '../services/user';
import { Router } from '@angular/router';


@Injectable({
  providedIn: 'root'
})
export class UserService {
  userRef!: AngularFireObject<any>;
  userLogado!: AngularFireObject<any>;
  users!: AngularFirestoreCollection<any>;

  constructor(
    private firestore: AngularFirestore,
    private router: Router
  ) { }

  getAllUsers() {
    const docRef = this.firestore.collection('users');
    return docRef.get();
  }

  getUser(uid: string) {
    return this.firestore.doc(`users/${uid}`).get();
  }
}