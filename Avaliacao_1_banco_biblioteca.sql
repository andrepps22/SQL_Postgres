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
('Fabrício Xavier'),
('Pablo Dalloglio');

select * from autor;

--4 Tabela Livro
Create table livro (
	idlivro serial not null,
	ideditora integer not null,
	idcategoria integer not null,
	nome  varchar(100),
	
	--PK
	constraint pk_livro_idlivro primary key (idlivro),
	
	--FK
	constraint fk_livro_ideditora foreign key (ideditora) references editora (ideditora),
	constraint fk_livro_idcategoria foreign key (idcategoria) references categoria (idcategoria),
	
	--Unique
	constraint un_livro_nome unique (nome)
);

--inserindo dados na tabela livro
insert into livro
(ideditora, idcategoria, nome)
values
(2, 1, 'Banco de Dados – 1 Edição'),
(1, 1, 'Oracle DataBase 11G Administração'),
(3, 3, 'Programação de Computadores em Java'),
(4, 3, 'Programação Orientada a Aspectos em Java'),
(4, 2, 'HTML5 – Guia Prático'),
(3, 2, 'XHTML: Guia de Referência para Desenvolvimento na Web'),
(1, 4, 'PHP para Desenvolvimento Profissional'),
(2, 4, 'PHP com Programação Orientada a Objetos');

select * from livro;

--5 tabela livro_autor
create table livro_autor (
	idlivro integer not null,
	idautor integer not null,
	
	--PK
	constraint pk_la_idlivro_idautor primary key (idlivro, idautor),
	
	--FK
	constraint fk_la_idlivro foreign key (idlivro) references livro (idlivro),
	constraint fk_la_idautor foreign key (idautor) references autor (idautor)
);

-- inserindo dados na tabela livro_autor
insert into livro_autor
(idlivro, idautor)
values
(1, 1),
(1, 2),
(2, 3),
(3, 4),
(4, 5),
(4, 6),
(5, 7),
(6, 8),
(7, 9),
(8, 10);

--6 tabela Aluno.
create table aluno (
	idaluno serial not null,
	nome varchar(80) not null,
	
	--PK 
	constraint pk_aluno_idaluno primary key (idaluno)
);

--inserindo dados na tabela Aluno
insert into aluno
(nome)
values
('Mario'),
('João'),
('Paulo'),
('Pedro'),
('Maria');

select * from aluno;

--7 Tabela Emprestimo
create table emprestimo(
	idemprestimo serial not null,
	idaluno integer not null,
	data_emprestimo date not null default current_date,
	data_devolucao date not null,
	valor float not null default 0,
	devolvido varchar(1) not null,
	
	--PK
	constraint pk_emp_idemprestimo primary key (idemprestimo),
	
	--FK
	constraint fk_emp_idaluno foreign key (idaluno) references aluno (idaluno)
);

--Inserindo dados na tabela emprestimo
insert into emprestimo 
(idaluno, data_emprestimo, data_devolucao, valor, devolvido)
values
(1, '02-05-2012', '12-05-2012', 10, 'S'),
(1, '23-04-2012', '03-05-2012', 5, 'N'),
(2, '10-05-2012', '20-05-2012', 12, 'N'),
(3, '10-05-2012', '20-05-2012', 8, 'S'),
(4, '05-05-2012', '15-05-2012', 15, 'N'),
(4, '07-05-2012', '17-05-2012', 20, 'S'),
(4, '08-05-2012', '18-05-2012', 5, 'S');

select * from emprestimo;
commit;

--8 tabela emprestimo_livro
create table emprestimo_livro (
	idemprestimo integer not null,
	idlivro integer not null,
	
	--PK
	constraint pk_el_idemprestimo_idlivro primary key (idemprestimo, idlivro),
	
	--FK
	constraint fk_el_idemprestimo foreign key (idemprestimo) references emprestimo (idemprestimo),
	constraint fk_el_idlivro foreign key (idlivro) references livro (idlivro)
);

--inserindo dados na tabela emprestimo_livro
insert into emprestimo_livro
(idemprestimo, idlivro)
values
(1, 1),
(2, 4),
(2, 3),
(3, 2),
(3, 7),
(4, 5),
(5, 4),
(6, 6),
(6, 1),
(7, 8);

select * from emprestimo_livro;

--Indice da tabala emprestimo_livro
create index 
	idx_emp_data_emprestimo 
on
	emprestimo (data_emprestimo);
	
create index 
	idx_emp_data_devolucao
on 
	emprestimo (data_devolucao);

commit;


--CONSULTAS SIMPLES
--19. O nome dos autores em ordem alfabética.
select nome from autor order by nome asc;

--20. O nome dos alunos que começam com a letra P.
select nome from aluno where nome like 'P%';

--21. O nome dos livros da categoria Banco de Dados ou Java.
select * from livro;
select nome from livro where idcategoria = 1 or idcategoria = 3;

--22. O nome dos livros da editora Bookman.
select * from editora;
select nome from livro where ideditora = 1;

--23. Os empréstimos realizados entre 05/05/2012 e 10/05/2012.
select * from emprestimo where data_emprestimo between '05-05-2012' and '10-05-2012';

--24. Os empréstimos que não foram feitos entre 05/05/2012 e 10/05/2012
select * from emprestimo where data_emprestimo < '05-05-2012' or data_emprestimo > '10-05-2012';

--25. Os empréstimos que os livros já foram devolvidos.
select * from emprestimo where devolvido = 'S';

--CONSULTAS COM AGRUPAMENTO SIMPLES
--26. A quantidade de livros.
select count(nome) as qtd_livros from livro;

--27. O somatório do valor dos empréstimos.
select sum(valor) as valor_total_emprestimos from emprestimo;

--28. A média do valor dos empréstimos.
select avg(valor) as media_valor_emprestimo from emprestimo;

--29. O maior valor dos empréstimos.
select max(valor) from emprestimo;

--30. O menor valor dos empréstimos.
select min(valor) from emprestimo;

--31. O somatório do valor do empréstimo que estão entre 05/05/2012 e 10/05/2012.
select sum(valor) from emprestimo where data_emprestimo between '05-05-2012' and '10-05-2012';

--32. A quantidade de empréstimos que estão entre 01/05/2012 e 05/05/2012.
select count(*) from emprestimo where data_emprestimo between '01-05-2012' and '05-05-2012';

--CONSULTAS COM JOIN
--33. O nome do livro, a categoria e a editora (LIVRO) – fazer uma view
create view dados_livro as
select
	a.nome as livro, 
	b.nome as categoria, 
	c.nome as editora 
from livro a
left join 
	categoria b on b.idcategoria = a.idcategoria
left join 
	editora c on c.ideditora = a.ideditora;

select * from dados_livro;

--34. O nome do livro e o nome do autor (LIVRO_AUTOR) – fazer uma view.
create view dados_livro_autor as 
select 
	b.nome as livro,
	c.nome as autor
from
	livro_autor a
left join 
	livro b on b.idlivro = a.idlivro
left join 
	autor c on c.idautor = a.idautor;

select * from dados_livro_autor;

--35. O nome dos livros do autor Ian Graham (LIVRO_AUTOR).
--Fazendo a consulta pela View
select livro from dados_livro_autor where autor like 'Ian Graham';

--com join
select 
	b.nome as livro,
	c.nome as autor
from 
	livro_autor a
left join 
	livro b on a.idlivro = b.idlivro
left join 
	autor c on a.idautor = c.idautor
where c.nome like 'Ian Graham';
	
--36. O nome do aluno, a data do empréstimo e a data de devolução (EMPRESTIMO).
select 
	b.nome as aluno,
	a.data_emprestimo,
	a.data_devolucao
from 
	emprestimo a
left join 
	aluno b on a.idaluno = b.idaluno;

--37. O nome de todos os livros que foram emprestados (EMPRESTIMO_LIVRO).
select 
	b.nome as livro_emprestado
from 
	emprestimo_livro a
left join 
	livro b on a.idlivro = b.idlivro;

--CONSULTAS COM AGRUPAMENTO + JOIN
--38. O nome da editora e a quantidade de livros de cada editora (LIVRO).
select * from livro;
select
	b.nome as editora, 
	count(b.nome) as quantidade	
from
	livro a
left join 
	editora b on a.ideditora = b.ideditora	
group by
	b.nome;
	
--39. O nome da categoria e a quantidade de livros de cada categoria (LIVRO).
select
	b.nome as categoria,
	count(b.nome) as qtd_livro_categoria
from 
	livro a
left join 
	categoria b on a.idcategoria = b.idcategoria
group by
	b.nome;

--40. O nome do autor e a quantidade de livros de cada autor (LIVRO_AUTOR).
select * from livro_autor;
select * from autor;
select
	b.nome as autor,
	count(a.idlivro) as qtd
from 
	livro_autor a
left join 
	autor b on a.idautor = b.idautor
group by
	b.nome;
	
--41. O nome do aluno e a quantidade de empréstimo de cada aluno (EMPRESTIMO).
select
	b.nome as aluno,
	count(a.idaluno) as qtd_de_emprestimo
from 
	emprestimo a
left join 
	aluno b on a.idaluno = b.idaluno
group by 
	b.nome;

--42. O nome do aluno e o somatório do valor total dos empréstimos de cada aluno (EMPRESTIMO).
select
	b.nome as aluno,
	sum(a.valor) as valor_emprestimos
from
	emprestimo a
left join 
	aluno b on a.idaluno = b.idaluno
group by
	b.nome;

--43. O nome do aluno e o somatório do valor total dos empréstimos de cada aluno somente daqueles que o somatório for maior do que 7,00 (EMPRESTIMO).
select
	b.nome as aluno,
	sum(a.valor) as valor_emprestimos
from
	emprestimo a
left join 
	aluno b on a.idaluno = b.idaluno
where
	a.valor > 7
group by
	b.nome;

--CONSULTAS COMANDOS DIVERSOS
--44. O nome de todos os alunos em ordem decrescente e em letra maiúscula.
select
	upper(nome)
from
	aluno
order by 
	nome desc;
	
--45. Os empréstimos que foram feitos no mês 04 de 2012.
select 
	*
from
	emprestimo
where
	extract(month from data_emprestimo) = 4;
	
--46. Todos os campos do empréstimo. Caso já tenha sido devolvido, mostrar a mensagem “Devolução completa”, senão “Em atraso”.
select
	*,
	coalesce(case devolvido
		when 'S' then 'Devolução completa'
	else
		'Em atraso'
	end) as observacao
from
	emprestimo;

--47. Somente o caractere 5 até o caractere 10 do nome dos autores.
select
	substring(nome from 5 for 10)
from
	autor;

--48. O valor do empréstimo e somente o mês da data de empréstimo. Escreva “Janeiro”, “Fevereiro”, etc
select 
	valor,
	case extract(month from data_emprestimo)
		when 1 then 'Janeiro'
		when 2 then 'Fevereiro'
		when 3 then 'Março'
		when 4 then 'Abril'
		when 5 then 'Maio'
		when 6 then 'Junho'
		when 7 then 'Julho'
		when 8 then 'Agosto'
		when 9 then 'Setembro'
		when 10 then 'Outubro'
		when 11 then 'Novembro'
		when 12 then 'Dezembro'
	end as mes_emprestimo
from
	emprestimo;

--SUBCONSULTAS
--49. A data do empréstimo e o valor dos empréstimos que o valor seja maior que a média de todos os empréstimos.
select
	data_emprestimo,
	valor
from
	emprestimo
where
	valor > (select
				avg(valor)
			 from
				emprestimo);
	
--50. A data do empréstimo e o valor dos empréstimos que possuem mais de um livro.
select
	data_emprestimo,
	valor
from
	emprestimo
where idaluno in (select
	   		count(idaluno)
	   from
	  		emprestimo
	   group by
	  		idaluno
	  	having count(idaluno) > 1);

--51. A data do empréstimo e o valor dos empréstimos que o valor seja menor que a soma de todos os empréstimos.
select 
	data_emprestimo,
	valor
from
	emprestimo
where 
	valor < (select
			 	sum(valor)
			 from
				emprestimo);
