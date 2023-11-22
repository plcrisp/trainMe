import { Component, OnInit } from '@angular/core';
import { CrudService } from '../../shared/services/crud.service';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ToastrService } from 'ngx-toastr';
import { AuthService } from 'src/app/shared/services/auth.service';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-add-exercise',
  templateUrl: './add-exercise.component.html',
  styleUrls: ['./add-exercise.component.scss'],
})

export class AddExerciseComponent implements OnInit {
  public exerciseForm: FormGroup;
  constructor(
    public crudApi: CrudService,
    public fb: FormBuilder,
    public toastr: ToastrService,
    public authService: AuthService,
  ) {}

  ngOnInit() {
    this.crudApi.GetAllExercises();
    this.exercisForm();
  }

  exercisForm() {
    this.exerciseForm = this.fb.group({
      name: ['', [Validators.required, Validators.minLength(2)]],
      equipment: ['', [Validators.required, Validators.minLength(2)]],
      secondaryGroup: [''],
      primaryGroup: ['', [Validators.required, Validators.minLength(2)]],
      imgId: ['', [Validators.required, Validators.minLength(2)]],
      obs: ['', [Validators.required, Validators.minLength(2)]],
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
  get obs() {
    return this.exerciseForm.get('obs');
  }

  ResetForm() {
    this.exerciseForm.reset();
  }

  submitExerciseData() {
    let eid = new Date().getTime().toString(); 
    this.crudApi.SetExerciseData(eid, this.exerciseForm.value);
    this.ResetForm();
  }

  alert(){
    Swal.fire({
        title: `${this.exerciseForm.value.name} adicionado(a) com sucesso!`,
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