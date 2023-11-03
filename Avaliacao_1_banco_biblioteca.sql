--1 Crie EDITORA
create table editora (
	ideditora serial not null,
	nome varchar(50) not null,
	-- primary key
	constraint pk_edt_ideditora primary key (ideditora),
	
	-- nome unico
	constraint un_edt_nome unique (nome)
);

-- inserindo os dados na tabela editora
insert into editora (nome)
values
('Bookman'),
('Edgard Blusher'),
('Nova Terra'),
('Brasport');

select * from editora;


--2 tabela CATEGORIA
create table categoria (
	idcategoria serial not null,
	nome varchar(50),
	
	--PK
	constraint pk_cat_idcategoria primary key (idcategoria),
	
	--unique
	constraint un_cat_nome unique (nome)
);

--inserindo dados na tabela Categoria
insert into categoria (nome)
values
('Banco de Dados'),
('HTML'),
('Java'),
('PHP');
select * from categoria;

--3 tabela Autor
create table autor (
	idautor serial not null,
	nome varchar(50),
	
	--pk
	constraint pk_autor_idautor primary key (idautor)
);

--inserindo dados na table autor
insert into autor (nome)
values
('Waldemar Setzer'),
('Flávio Soares'),
('Jhon Watson'),
('Rui Rossi dos Santos'),
('Antonio Pereira de Resende'),
('Claudiney Calixto Lima'),
('Evandro Carlos Teruel'),
('Ian Graham'),
('Pablo Dalloglio');

select * from autor;

--4 Tabela Livro
Create table livro (
	idlivro serial not null,
	ideditora integer not null,
	idcategoria integer not null,
	nome  varchar(50),
	
	--PK
	constraint pk_livro_idlivro primary key (idlivro),
	
	--FK
	constraint fk_livro_ideditora foreign key (ideditora) references editora (ideditora),
	constraint fk_livro_idcategoria foreign key (idcategoria) references categoria (idcategoria),
	
	--Unique
	constraint un_livro_nome unique (nome)
);