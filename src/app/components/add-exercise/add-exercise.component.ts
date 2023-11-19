import { Component, OnInit } from '@angular/core';
import { CrudService } from '../../shared/services/crud.service';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { ToastrService } from 'ngx-toastr';
import { AuthService } from 'src/app/shared/services/auth.service';
import { AngularFireStorage } from '@angular/fire/compat/storage';
import * as md5 from "../../shared/services/md5";

@Component({
  selector: 'app-add-exercise',
  templateUrl: './add-exercise.component.html',
  styleUrls: ['./add-exercise.component.scss'],
})

export class AddExerciseComponent implements OnInit {
  public exerciseForm: FormGroup;
  private filePathExercise: String = "";
  private fileSrc: String = "";


  constructor(
    public crudApi: CrudService,
    public fb: FormBuilder,
    public toastr: ToastrService,
    public authService: AuthService,
    public afStorage: AngularFireStorage
  ) {}

  ngOnInit() {
    this.crudApi.GetAllExercises();
    this.exercisForm();

    this.exerciseForm = new FormGroup({
      name: new FormControl(''),
      primaryGroup: new FormControl(''),
      secondaryGroup: new FormControl(''),
      equipment: new FormControl(''),
      imgId: new FormControl(''),
    });
  }

  exercisForm() {
    this.exerciseForm = this.fb.group({
      name: ['', [Validators.required, Validators.minLength(2)]],
      equipment: ['', [Validators.required, Validators.minLength(2)]],
      secondaryGroup: ['', [Validators.required, Validators.minLength(2)]],
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

  previewImage(event: any){
    const imageFiles = event.target.files;
    const imageFilesLength = imageFiles.length;

    if (imageFilesLength > 0) {
      const imageSrc = URL.createObjectURL(imageFiles[0]);
      const imagePreviewElement = document.querySelector(".img-perfil")! as HTMLImageElement;

      imagePreviewElement.src = imageSrc;
      imagePreviewElement.style.display = "block";
      this.filePathExercise = imageFiles[0];
      this.fileSrc = imageSrc;
    }
  }

  submitExerciseData() {
    let eid = new Date().getTime().toString();
    let hash = new Date().getTime().toString() + this.fileSrc;
    let imgId = md5.md5(hash);

    this.afStorage.upload("exercises/" + imgId, this.filePathExercise);

    const exerciseData = {
      name: this.exerciseForm.value.name,
      primaryGroup: this.exerciseForm.value.primaryGroup,
      secondaryGroup: this.exerciseForm.value.secondaryGroup,
      equipment: this.exerciseForm.value.equipment,
      imgId: imgId,
    };

    this.crudApi.SetExerciseData(eid, exerciseData);
    this.toastr.success(
      this.exerciseForm.controls['name'].value + ' successfully added!'
    );
    this.ResetForm();
  }
}
