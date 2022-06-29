import { Component, OnInit } from '@angular/core';
import { APIServerService } from '../api-server.service';

@Component({
  selector: 'app-area-administrador',
  templateUrl: './area-administrador.component.html',
  styleUrls: ['./area-administrador.component.css']
})
export class AreaAdministradorComponent implements OnInit {
  permissao : number = -1;
  timer: number = -1;
  constructor(private api: APIServerService) {
    this.api.getPermissao('o', 's', 'm').then(retorno => {
      this.permissao = retorno;
      this.timer =  (Date.now() - api.lastStartTime)/1000; 
    });

   }

  ngOnInit(): void {
  }

}
