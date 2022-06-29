import { Component, OnInit } from '@angular/core';
import { APIServerService } from '../api-server.service';

@Component({
  selector: 'app-area-gerente',
  templateUrl: './area-gerente.component.html',
  styleUrls: ['./area-gerente.component.css']
})
export class AreaGerenteComponent implements OnInit {
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
