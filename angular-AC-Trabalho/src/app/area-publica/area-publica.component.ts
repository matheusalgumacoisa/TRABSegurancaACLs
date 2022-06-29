import { Component, OnInit } from '@angular/core';
import { APIServerService } from '../api-server.service';

@Component({
  selector: 'app-area-publica',
  templateUrl: './area-publica.component.html',
  styleUrls: ['./area-publica.component.css']
})
export class AreaPublicaComponent implements OnInit {

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
