import { Component } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'angular-AC-Trabalho';

  constructor(private router: Router){}

  Navigate(route:string){
    this.router.navigate(['/'+route]);    
  }
}
