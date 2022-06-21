import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AreaGerenteComponent } from './area-gerente.component';

describe('AreaGerenteComponent', () => {
  let component: AreaGerenteComponent;
  let fixture: ComponentFixture<AreaGerenteComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ AreaGerenteComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(AreaGerenteComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
