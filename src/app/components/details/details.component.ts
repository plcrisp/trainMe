import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { AuthService } from 'src/app/shared/services/auth.service';
import { CrudService } from 'src/app/shared/services/crud.service';
import { Exercise } from 'src/app/shared/services/exercise';

@Component({
  selector: 'app-details',
  templateUrl: './details.component.html',
  styleUrls: ['./details.component.scss']
})
export class DetailsComponent implements OnInit {
  exercise: Exercise;
  exerciseId: string;

  constructor(private crudService: CrudService, public authService: AuthService, private route: ActivatedRoute) {
  }

  ngOnInit() {
    this.route.params.subscribe(params => {
      this.exerciseId = params['eid']; // Use params object here
      console.log('Exercise ID:', this.exerciseId); // Check if the exerciseId is logged correctly

      this.crudService.GetExercise(this.exerciseId).subscribe((exerciseData: any) => {
        // exerciseData é um objeto que contém os dados do exercício
        this.exercise = exerciseData.data(); // Use data() para extrair os dados do documento
        console.log('Dados do exercício:', this.exercise);
      });
    });
  }
}
