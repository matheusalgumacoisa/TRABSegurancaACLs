import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { AreaPublicaComponent } from './area-publica/area-publica.component';
import { AreaUsuarioLogadoComponent } from './area-usuario-logado/area-usuario-logado.component';
import { AreaGerenteComponent } from './area-gerente/area-gerente.component';
import { AreaAdministradorComponent } from './area-administrador/area-administrador.component';


@NgModule({
  declarations: [
    AppComponent,
    AreaPublicaComponent,
    AreaUsuarioLogadoComponent,
    AreaGerenteComponent,
    AreaAdministradorComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    NgbModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
