import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AreaUsuarioLogadoComponent } from './area-usuario-logado.component';

describe('AreaUsuarioLogadoComponent', () => {
  let component: AreaUsuarioLogadoComponent;
  let fixture: ComponentFixture<AreaUsuarioLogadoComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ AreaUsuarioLogadoComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(AreaUsuarioLogadoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
