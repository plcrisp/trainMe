import { Injectable } from '@angular/core';
import {
  ActivatedRouteSnapshot,
  RouterStateSnapshot,
  Router,
  UrlTree,
} from '@angular/router';

import { AuthService } from '../../shared/services/auth.service';
import { UserService } from '../services/user.service';

import { map, Observable } from 'rxjs';
import { AngularFirestore, AngularFirestoreCollection } from '@angular/fire/compat/firestore';

@Injectable({
  providedIn: 'root',
})
export class AuthGuard {
  constructor(public authService: AuthService, public userService: UserService,  public router: Router, private afs: AngularFirestore,) {}

  canActivate(
    route: ActivatedRouteSnapshot,
    state: RouterStateSnapshot): Observable<boolean | UrlTree> | Promise<boolean | UrlTree> | boolean | UrlTree {

    this.authService.isAdmin();

    let userDB: any;
    let user = JSON.parse(localStorage.getItem("user")!);

    return this.userService.getUser(user.uid).pipe(
      map(user => {
        userDB = user.data();

        if (this.authService.isLoggedIn === false || userDB.admUser === false) {
          this.router.navigate(['sign-in']);
          return false;
        }
        return true;
      }));
  }
}