import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http'

@Injectable({
  providedIn: 'root'
})
export class APIServerService {

  
  rootURL : string = 'http://localhost:3080';
  lastStartTime : number = 0;

  constructor( private http: HttpClient) { }

  async getPermissao(sujeito:string,objeto:string,metodo:string):Promise<number> {

    this.lastStartTime = Date.now();
    const headers = { 'content-type': 'application/json'};
    const body = JSON.stringify({sujeito,objeto,metodo});
    console.log('enviando: '+body);
    //await new Promise(f => setTimeout(f, 1000));
    return await this.http.post<string>(this.rootURL + '/api/user', body, { headers }).toPromise().then((result) => {
        console.log('resposta: '+ JSON.stringify(result));
        //return result!;
        return JSON.parse(JSON.stringify(result))[0].permissao;
    }).catch(error => { throw error });
  }

}


