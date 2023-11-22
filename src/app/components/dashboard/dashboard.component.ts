import { Component, OnInit } from '@angular/core';
import { AuthService } from '../../shared/services/auth.service';
import { CrudService } from 'src/app/shared/services/crud.service';
import { Exercise } from 'src/app/shared/services/exercise';
import { AngularFireStorage } from '@angular/fire/compat/storage';
import { ActivatedRoute } from '@angular/router';
import Swal from 'sweetalert2';


@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.scss'],
})

export class DashboardComponent implements OnInit {
  Exercise: Exercise[];


  constructor(private crudService: CrudService, public authService: AuthService, private route: ActivatedRoute) {}



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
  

  //removeExercise(Exercise){
 //   if(confirm("Tem certeza que deseja deletar "+ Exercise.name)){
  //    this.crudService.deleteExercise(Exercise.eid);
  //  }
 // }

  removeExercise(Exercise){
    Swal.fire({
      title: "Tem certeza?",
      text: "Você não conseguirá reverter isso!",
      icon: "warning",
      color: '#FFF',
      background: '#1D2D47',
      showCancelButton: true,
      confirmButtonColor: "#3085d6",
      cancelButtonColor: "#d33",
      confirmButtonText: "Remover"
    }).then((result) => {
      if (result.isConfirmed) {
        this.crudService.deleteExercise(Exercise.eid);
        Swal.fire({
          background: '#1D2D47',
          color: '#FFF',
          title: "Removido!",
          confirmButtonColor: '#009688',
          text: `${Exercise.name} removido(a) com sucesso!`,
          icon: "success"
        });
      }
    });
  }
}
