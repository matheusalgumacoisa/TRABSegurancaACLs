import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { APIServerService } from './api-server.service';
import {NgForm} from '@angular/forms';
import { AppModule } from './app.module';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'angular-AC-Trabalho';
  permissao : number = -1;
  timer: number = -1;
  tipo!: string;
  usuario!: string;

  constructor(private router: Router,private api: APIServerService){}

  Navigate(route:string){
    this.router.navigate(['/'+route]);    
  }

  GetPermissoes_pb(){
    console.log('tipo: '+this.tipo);
    console.log('usuario: '+this.usuario);
    this.api.getPermissao(this.usuario, 'publica', this.tipo).then(retorno => {
      this.permissao = retorno;
      this.timer =  (Date.now() - this.api.lastStartTime)/1000; 
    });
  }

  GetPermissoes_lg(){
    console.log('tipo: '+this.tipo);
    console.log('usuario: '+this.usuario);
    this.api.getPermissao(this.usuario, 'logado', this.tipo).then(retorno => {
      this.permissao = retorno;
      this.timer =  (Date.now() - this.api.lastStartTime)/1000; 
    });
  }

  GetPermissoes_gr(){
    console.log('tipo: '+this.tipo);
    console.log('usuario: '+this.usuario);
    this.api.getPermissao(this.usuario, 'gerente', this.tipo).then(retorno => {
      this.permissao = retorno;
      this.timer =  (Date.now() - this.api.lastStartTime)/1000; 
    });
  }

  GetPermissoes_adm(){
    console.log('tipo: '+this.tipo);
    console.log('usuario: '+this.usuario);
    this.api.getPermissao(this.usuario, 'administrador', this.tipo).then(retorno => {
      this.permissao = retorno;
      this.timer =  (Date.now() - this.api.lastStartTime)/1000; 
    });
  }
}
