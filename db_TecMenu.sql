Create schema if not exists db_TecMenu;
Use db_tecMenu;

create table if not exists usuario(
id_usuario int not null primary key auto_increment,
nome_usu varchar(255),
cargo varchar(50),
tel_usu varchar(25)
);

select * from usuario;

alter table usuario
add column senha_usu varchar(50);

update usuario set cargo = "admin" where id_usuario = 1;

describe usuario;

insert into usuario (nome_usu, cargo, tel_usu, senha_usu) values
("admin", "admin", "21964405406", "admin");

select * from usuario;

create table if not exists produto(
id_produto int not null primary key auto_increment,
nome_prod varchar (50),
cat varchar (50),
qtd int
);

INSERT INTO produto (nome_prod, id_cat, qtd, id_fabricante)
VALUES 
('Feijão', 5, 80, 1),
('Carne', 2, 50, 1),
('Batata', 3, 60, 1),
('Cebola', 1, 40, 1);

select * from produto;

describe produto;

CREATE TABLE IF NOT EXISTS prato (
id_prato int not null primary key auto_increment,
nome_prato varchar(50),
descricao varchar(255)
);

INSERT INTO prato (nome_prato, descricao)
VALUES 
('Arroz com Feijão', 'Prato clássico com arroz branco e feijão preto.'),
('Carne Assada', 'Carne temperada com batatas e cebola ao forno.'),
('Baião de Dois', 'Arroz misturado com feijão e carne.');

select * from prato;

CREATE TABLE IF NOT EXISTS prato_produto (
id_prato_produto INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
id_prato INT,
id_produto INT,
quantidade_necessaria INT,
CONSTRAINT fk_pp_prato
FOREIGN KEY (id_prato)
REFERENCES prato (id_prato)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT fk_pp_produto
FOREIGN KEY (id_produto)
REFERENCES produto (id_produto)
ON DELETE CASCADE
ON UPDATE CASCADE
);

INSERT INTO prato_produto (id_prato, id_produto, quantidade_necessaria)
VALUES
(1, 6, 1), 
(1, 7, 1); 

INSERT INTO prato_produto (id_prato, id_produto, quantidade_necessaria)
VALUES
(2, 8, 1),  
(2, 9, 2), 
(2, 10, 1); 

INSERT INTO prato_produto (id_prato, id_produto, quantidade_necessaria)
VALUES
(3, 6, 1),  
(3, 7, 1),  
(3, 8, 1);  

select * from prato_produto;


alter table produto
change column cat 
id_cat varchar(50);

alter table produto 
modify column id_cat int;

alter table produto
add constraint fk_prod_cat
foreign key (id_cat)
references categoria (id_cat)
on update cascade;

alter table produto 
add column id_fabricante int;

alter table produto
add constraint fk_prod_fab
foreign key (id_fabricante)
references fabricante (id_fabricante)
on update cascade;

create table if not exists fabricante(
id_fabricante int not null primary key auto_increment,
nome_fab varchar(255),
tel_fab varchar (25),
cnpj smallint
);

alter table fabricante
modify column cnpj bigint;

insert into fabricante (nome_fab, tel_fab, cnpj) values 
("Fabrica de arroz", "21999532234", "12345678123456");

update fabricante set nome_fab = "fabrica de arroz" where id_fabricante = 1;

select id_fabricante from fabricante where nome_fab = 'fabrica de arroz';

describe fabricante;

select * from fabricante;


create table if not exists categoria(
id_cat int not null primary key auto_increment,
nome_cat varchar (50)
);

insert into categoria (nome_cat) values
("tempero"),
("proteina"),
("legume"),
("verdura"),
("grao");

select * from categoria;



create table if not exists cadastro(
id_cadastro int not null primary key auto_increment,
id_produto int,
id_usuario int,

constraint fk_cad_usu
foreign key (id_usuario)
references usuario (id_usuario)
on delete cascade
on update cascade,

constraint fk_cad_prod
foreign key (id_produto)
references produto (id_produto)
on delete cascade
on update cascade
);

select * from cadastro;

create table if not exists solicita(
id_solicitacao int not null primary key auto_increment,
id_produto int,
id_usuario int,
soli_dt timestamp,

constraint fk_soli_usu
foreign key (id_usuario)
references usuario (id_usuario)
on delete restrict
on update cascade,

constraint fk_soli_prod
foreign key (id_produto)
references produto (id_produto)
on delete restrict
on update cascade
);

alter table solicita modify column soli_dt timestamp default (current_timestamp);

select * from solicita;

create table if not exists menu (
id_menu int not null primary key auto_increment,
nome_prato varchar(50),
descricao varchar(255)
);

select * from menu;

create table if not exists compra (
id_compra int not null primary key auto_increment,
id_produto int,
quantidade int,
data_compra timestamp default (current_timestamp),
foreign key (id_produto) references produto(id_produto)
);

ALTER TABLE compra DROP FOREIGN KEY compra_ibfk_1;
ALTER TABLE compra
ADD CONSTRAINT compra_ibfk_1
FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
ON DELETE CASCADE;

select * from compra;