import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AreaAdministradorComponent } from './area-administrador/area-administrador.component';
import { AreaGerenteComponent } from './area-gerente/area-gerente.component';
import { AreaPublicaComponent } from './area-publica/area-publica.component';
import { AreaUsuarioLogadoComponent } from './area-usuario-logado/area-usuario-logado.component';

const routes: Routes = [
  {path:'adm', component: AreaAdministradorComponent},
  {path:'ger', component: AreaGerenteComponent},
  {path:'pub', component: AreaPublicaComponent},
  {path:'usu', component: AreaUsuarioLogadoComponent}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})




export class AppRoutingModule { }
