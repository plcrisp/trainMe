import { Injectable } from '@angular/core';
import { Exercise } from '../services/exercise';
import {
  AngularFireDatabase,
  AngularFireList,
  AngularFireObject,
} from '@angular/fire/compat/database';

import {
  AngularFirestore,
  AngularFirestoreCollection,
  AngularFirestoreDocument,
} from '@angular/fire/compat/firestore';

@Injectable({
  providedIn: 'root',
})
export class CrudService {
  exerciseRef!: AngularFireObject<any>;
  exercises!: AngularFirestoreCollection<any>;
  constructor(public afs: AngularFirestore,) {}



  // Fetch Single exercise Object
  GetExercise(eid: string) {
    return this.afs.doc(`users/${eid}`).get();
  }



  // Fetch exercise List
  GetAllExercises() {
    const docRef = this.afs.collection('exercises');
    return docRef.get();
  }



  async updateExerciseData(exercise: Exercise, uid: string) {
    const exerciseRef = this.afs.collection(`users/`);

    await exerciseRef.doc(uid).update({
      name: exercise.name,
      primaryGroup: exercise.primaryGroup,
      secondaryGroup: exercise.secondaryGroup,
      imgId: exercise.imgId,
      equipment: exercise.equipment
    }).then(() => {
      window.alert('Dados atualizados');
    });
  }

  SetExerciseData(eid: string, exercise: any) {
    const exerciseRef: AngularFirestoreDocument<any> = this.afs.doc(
      `exercises/${eid}`
    );

    const exerciseData: Exercise = {
      eid: eid,
      name: exercise.name,
      primaryGroup: exercise.primaryGroup,
      secondaryGroup: exercise.secondaryGroup,
      imgId: exercise.imgId,
      equipment: exercise.equipment
    };

    return exerciseRef.set(exerciseData, {
      merge: true,
    });
  }



  DeleteExercise(eid: string) {
    const exerciseRef = this.afs.collection('exercises').doc(eid);
    return exerciseRef.delete();
  }
}