import { Component, OnInit } from '@angular/core';
import { CrudService } from '../../shared/services/crud.service';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ToastrService } from 'ngx-toastr';
import { AuthService } from 'src/app/shared/services/auth.service';

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
    let eid = new Date().getTime().toString(); 
    this.crudApi.SetExerciseData(eid, this.exerciseForm.value);
    window.alert('Exercício adicionado com sucesso!');
    this.ResetForm();
  }
}