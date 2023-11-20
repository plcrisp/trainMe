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
      console.log(res);
      this.Exercise = res.map(e => {
        return {
          eid: e.payload.doc.id,
          ...e.payload.doc.data() as Exercise
        } as Exercise;
      });

      this.Exercise.sort((a, b) => {
        const groupA = a.primaryGroup.toUpperCase();
        const groupB = b.primaryGroup.toUpperCase();
        return groupA.localeCompare(groupB);
      });
    });
  }
  

  removeExercise(Exercise){
    if(confirm("Tem certeza que deseja deletar "+ Exercise.name)){
      this.crudService.deleteExercise(Exercise.eid);
    }
  }
}
