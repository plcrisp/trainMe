import { Component, OnInit } from '@angular/core';
import { AuthService } from '../../shared/services/auth.service';
import { CrudService } from 'src/app/shared/services/crud.service';
import { Exercise } from 'src/app/shared/services/exercise';

@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.scss'],
})

export class DashboardComponent implements OnInit {
  Exercise: Exercise[];


  constructor(private crudService: CrudService, public authService: AuthService) {}



  ngOnInit() {
    this.crudService.GetAllExercises().subscribe(res => {
      this.Exercise = res.map(e => {
        return {
          eid: e.payload.doc.id,
          ...e.payload.doc.data() as Exercise
        } as Exercise;
      });
    });
  }
  

  removeExercise(Exercise){
    if(confirm("Are you sure to delete "+ Exercise.name)){
      this.crudService.DeleteExercise(Exercise);
    }
  }
}
