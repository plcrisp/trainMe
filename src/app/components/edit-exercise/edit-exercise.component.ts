import { Component } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { AuthService } from 'src/app/shared/services/auth.service';
import { CrudService } from 'src/app/shared/services/crud.service';
import { Exercise } from 'src/app/shared/services/exercise';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-edit-exercise',
  templateUrl: './edit-exercise.component.html',
  styleUrls: ['./edit-exercise.component.scss']
})
export class EditExerciseComponent {
  public exerciseForm: FormGroup;
  exercise: Exercise;
  exerciseId: string;

  constructor(
    public crudService: CrudService,
    public fb: FormBuilder,
    public toastr: ToastrService,
    public authService: AuthService,
    private route: ActivatedRoute,
    private router: Router
  ) {}

  ngOnInit() {
    this.route.params.subscribe(params => {
      this.exerciseId = params['eid'];
      console.log('Exercise ID:', this.exerciseId);

      this.crudService.GetExercise(this.exerciseId).subscribe((exerciseData: any) => {
        this.exercise = exerciseData.data();
        console.log('Dados do exercício:', this.exercise);

        // Preencher os campos do FormGroup com os valores do exercício
        this.exerciseForm.patchValue({
          name: this.exercise.name,
          equipment: this.exercise.equipment,
          secondaryGroup: this.exercise.secondaryGroup,
          primaryGroup: this.exercise.primaryGroup,
          imgId: this.exercise.imgId
        });
      });
    });
    this.crudService.GetAllExercises();
    this.exercisForm();
  }

  exercisForm() {
    this.exerciseForm = this.fb.group({
      name: ['', [Validators.required, Validators.minLength(2)]],
      equipment: ['', [Validators.required, Validators.minLength(2)]],
      secondaryGroup: [''],
      primaryGroup: ['', [Validators.required, Validators.minLength(2)]],
      imgId: ['', [Validators.required, Validators.minLength(2)]],
    });
  }
  get name() {
    return this.exerciseForm.get('name');
  }
  get primaryGroup() {
    return this.exerciseForm.get('primaryGroup');
  }
  get secondaryGroup() {
    return this.exerciseForm.get('secondaryGroup');
  }
  get equipment() {
    return this.exerciseForm.get('equipment');
  }
  get imgId() {
    return this.exerciseForm.get('imgId');
  }

  ResetForm() {
    this.exerciseForm.reset();
  }

  submitExerciseData() {
    this.crudService.updateExerciseData(this.exerciseId, this.exerciseForm.value);
    this.ResetForm();
    this.router.navigate(['/dashboard']);
  }

  alert(){
    Swal.fire({
        title: `${this.exercise.name} editado(a) com sucesso!`,
        width: 600,
        padding: '3em',
        color: '#FFF',
        background: '#1D2D47',
        confirmButtonColor: '#009688',
        backdrop: `
          rgba(41, 51, 92,0.4)
        `

    })
    }

}
