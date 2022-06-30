CREATE TABLE areas_acesso (
   id serial NOT NULL,
   html_header VARCHAR UNIQUE,
   PRIMARY KEY (ID)
);

/*CREATE TABLE usuarios(
   id serial NOT NULL,
   login VARCHAR UNIQUE,
   PRIMARY KEY (ID)
);*/

	INSERT INTO areas_acesso VALUES
    (1,'publica'),
	(2,'logado'),
	(3,'gerente'),
	(4,'administrador')
	;
	


create table usuarios as select s as id, md5(random()::text) as login from generate_Series(1,10000000) s;

CREATE or replace TABLE papeis(
   id serial NOT NULL,
   nome varchar UNIQUE,
   PRIMARY KEY (ID)
);


	
	INSERT INTO papeis VALUES
    (1,'usuario'),
	(2,'gerente'),
	(3,'administrador')
	;

/*CREATE TABLE usuario_papeis(
   id serial NOT NULL,
   id_usuario INTEGER,
   id_papel INTEGER,
   PRIMARY KEY (ID)
);*/

create table usuario_papeis as select s as id,s as id_usuario, floor(random() * 3 + 1) as id_papel from generate_Series(1,10000000) s; 

/*ALTER TABLE IF EXISTS public.usuario_papeis
    ADD CONSTRAINT usuario_fk FOREIGN KEY (id_usuario)
    REFERENCES public.usuarios (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

ALTER TABLE IF EXISTS public.usuario_papeis
    ADD CONSTRAINT papel_fk FOREIGN KEY (id_papel)
    REFERENCES public.papeis (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;*/



--=======================================================================================================

/*Create TABLE matriz(
	id serial NOT NULL,
    id_sujeito INTEGER NOT NULL,
	id_objeto INTEGER NOT NULL,
	permissao INTEGER NOT NULL
  PRIMARY KEY (ID));*/
  

create table matriz as select s as id,s as id_sujeito, 
case 
	when s < 10000000 then 1 
	when s < 20000000 then 2
	when s < 30000000 then 3
	when s < 40000000 then 4  
	end as id_objeto, 
floor(random() * 2) as permissao
from generate_Series(1,40000000) s


create table matriz_papel as select s as id,case 
	when s < 4 then 1 
	when s < 8 then 2
	when s < 12 then 3
	when s < 16 then 4  
	end as id_sujeito, 
case 
	when s < 4 then 1 
	when s < 8 then 2
	when s < 12 then 3
	when s < 16 then 4  
	end as id_objeto, 
floor(random() * 2) as permissao
from generate_Series(1,16) s



Create TABLE competencias_sj_01(
	id serial NOT NULL,
    id_objeto INTEGER NOT NULL,
	permissao INTEGER NOT NULL,
  PRIMARY KEY (ID));
  
  
  
  	INSERT INTO competencias_sj_01 VALUES
    (1,1,1),
	(2,2,0),
	(3,3,0),
	(4,4,0)
	;
  
  Create TABLE competencias_sj_02(
	id serial NOT NULL,
    id_objeto INTEGER NOT NULL,
	permissao INTEGER NOT NULL,
  PRIMARY KEY (ID));
  
    INSERT INTO competencias_sj_02 VALUES
    (1,1,1),
	(2,2,1),
	(3,3,0),
	(4,4,0)
	;
  
  
  Create TABLE competencias_sj_03(
	id serial NOT NULL,
    id_objeto INTEGER NOT NULL,
	permissao INTEGER NOT NULL,
  PRIMARY KEY (ID));
  
    INSERT INTO competencias_sj_03 VALUES
    (1,1,1),
	(2,2,1),
	(3,3,1),
	(4,4,0)
	;
  
  Create TABLE competencias_sj_04(
	id serial NOT NULL,
    id_objeto INTEGER NOT NULL,
	permissao INTEGER NOT NULL,
  PRIMARY KEY (ID));
  
    INSERT INTO competencias_sj_04 VALUES
    (1,1,1),
	(2,2,1),
	(3,3,1),
	(4,4,1)
	;


  
  CREATE OR REPLACE FUNCTION getpermissoes(sujeito VARCHAR, objeto VARCHAR, algoritimo VARCHAR)
    RETURNS numeric AS $$
    DECLARE
		RETORNO INTEGER;
		usuario_id INTEGER;
	BEGIN
	
		IF (algoritimo = 'MT')
		THEN
			SELECT permissao into RETORNO from matriz  m
			inner join usuarios u on (m.id_sujeito = u.id)
			inner join areas_acesso a on (m.id_objeto = a.id)
			where u.login = sujeito and a.html_header = objeto;
			
		
		END IF;
		
		IF (algoritimo = 'MT_P')
		THEN
			SELECT permissao into RETORNO from matriz_papel m
			inner join usuario_papeis u on (m.id_sujeito = u.id)
			inner join areas_acesso a on (m.id_objeto = a.id)
			inner join usuarios usu on (u.id_usuario = usu.id)
			where usu.login = sujeito and a.html_header = objeto;
		END IF;
		
		IF (algoritimo = 'CP')
		THEN
			SELECT ID INTO usuario_id from  usuarios u where u.login = sujeito;
		
			IF (usuario_id = 1)
			THEN
				SELECT  permissao into RETORNO from competencias_sj_01 c
				inner join areas_acesso a on (c.id_objeto = a.id)
				where a.html_header = objeto;
			END IF;
			IF (usuario_id = 2)
			THEN
				SELECT  permissao into RETORNO from competencias_sj_02 c
				inner join areas_acesso a on (c.id_objeto= a.id)
				where a.html_header = objeto;
			
			END IF;
			IF (usuario_id = 3)
			THEN
				SELECT  permissao into RETORNO from competencias_sj_03 c
				inner join areas_acesso a on (c.id_objeto = a.id)
				where a.html_header = objeto;
			
			END IF;
			IF (usuario_id > 3)
			THEN
				SELECT  permissao into RETORNO from competencias_sj_04 c
				inner join areas_acesso a on (c.id_objeto = a.id)
				where a.html_header = objeto;
			
			END IF;
		
		END IF;
		
		return RETORNO;
	end;
	$$  LANGUAGE plpgsql;
	
	UPDATE usuarios
    SET login = 'NULL'
	where id = 1;
	
	UPDATE usuarios
    SET login = 'USUARIO_PADRAO_123' 
	where id = 2;
	
	UPDATE usuarios
    SET login = 'GERENTE_DE_ALGUMA_COISA'
	where id = 3;
	
	UPDATE usuarios
    SET login = 'ADMINISTRADOR_01'
	where id = 4;

  
 /* ALTER TABLE IF EXISTS public.matriz
    ADD CONSTRAINT sujeito_fk FOREIGN KEY (id_sujeito)
    REFERENCES public.usuarios (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;
	
	
ALTER TABLE IF EXISTS public.matriz
    ADD CONSTRAINT objeto_fk FOREIGN KEY (id_objeto)
    REFERENCES public.areas_acesso (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;*/
	
	
	
/*Create TABLE lista_publica(
	id serial NOT NULL,
    id_sujeito INTEGER NOT NULL,
	permissao INTEGER NOT NULL,
  PRIMARY KEY (ID));*/
  
   /* ALTER TABLE IF EXISTS public.lista_publica
    ADD CONSTRAINT sujeito_fk FOREIGN KEY (id_sujeito)
    REFERENCES public.usuarios (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;*/
  
  
  
/*  Create TABLE lista_gerente(
	id serial NOT NULL,
    id_sujeito INTEGER NOT NULL,
	permissao INTEGER NOT NULL,
  PRIMARY KEY (ID));*/
  
 /* ALTER TABLE IF EXISTS public.lista_gerente
    ADD CONSTRAINT sujeito_fk FOREIGN KEY (id_sujeito)
    REFERENCES public.usuarios (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;*/
  
 /* Create TABLE lista_logado(
	id serial NOT NULL,
    id_sujeito INTEGER NOT NULL,
	permissao INTEGER NOT NULL,
  PRIMARY KEY (ID));*/
  
 /* ALTER TABLE IF EXISTS public.lista_logado
    ADD CONSTRAINT sujeito_fk FOREIGN KEY (id_sujeito)
    REFERENCES public.usuarios (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;*/
  
  
   /* Create TABLE lista_administador(
	id serial NOT NULL,
    id_sujeito INTEGER NOT NULL,
	permissao INTEGER NOT NULL,
  PRIMARY KEY (ID));*/
  
 /* ALTER TABLE IF EXISTS public.lista_administador
    ADD CONSTRAINT sujeito_fk FOREIGN KEY (id_sujeito)
    REFERENCES public.usuarios (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;*/
	
	
	
/*Create TABLE matriz_papeis(
	id serial NOT NULL,
    id_papel INTEGER NOT NULL,
	id_objeto INTEGER NOT NULL,
  PRIMARY KEY (ID));*/
  
  
 /* ALTER TABLE IF EXISTS public.matriz_papeis
    ADD CONSTRAINT papel_fk FOREIGN KEY (id_papel)
    REFERENCES public.papeis (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;
	
	
	ALTER TABLE IF EXISTS public.matriz_papeis
    ADD CONSTRAINT objeto_fk FOREIGN KEY (id_objeto)
    REFERENCES public.areas_acesso (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;*/
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
/*	Create TABLE lista_publica_papel(
	id serial NOT NULL,
    id_papel INTEGER NOT NULL,
	permissao INTEGER NOT NULL,
  PRIMARY KEY (ID));*/
  
   /* ALTER TABLE IF EXISTS public.lista_publica_papel
    ADD CONSTRAINT papel_fk FOREIGN KEY (id_papel)
    REFERENCES public.papeis (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;*/
 
  
  /*Create TABLE lista_gerente_papel(
	id serial NOT NULL,
    id_papel INTEGER NOT NULL,
	permissao INTEGER NOT NULL,
  PRIMARY KEY (ID));*/
  
 /* ALTER TABLE IF EXISTS public.lista_gerente_papel
    ADD CONSTRAINT papel_fk FOREIGN KEY (id_papel)
    REFERENCES public.papeis (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;*/
  
  /*Create TABLE lista_logado_papel(
	id serial NOT NULL,
    id_papel INTEGER NOT NULL,
	permissao INTEGER NOT NULL,
  PRIMARY KEY (ID));*/
  
/*  ALTER TABLE IF EXISTS public.lista_logado_papel
    ADD CONSTRAINT papel_fk FOREIGN KEY (id_papel)
    REFERENCES public.papeis (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;*/
  
  
    /*Create TABLE lista_administador_papel(
	id serial NOT NULL,
    id_papel INTEGER NOT NULL,
	permissao INTEGER NOT NULL,
  PRIMARY KEY (ID));*/
  
/*  ALTER TABLE IF EXISTS public.lista_administador
    ADD CONSTRAINT papel_fk FOREIGN KEY (id_papel)
    REFERENCES public.papeis (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;*/
	

	
	