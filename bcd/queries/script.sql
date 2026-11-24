drop database if exists gestao_pedidos;
create database gestao_pedidos;
use gestao_pedidos;
create table produto(
    id int not null primary key auto_increment,
    nome varchar(100) not null
);
create table telefone(
    id int not null primary key auto_increment,
    id_cliente int not null,
    numero varchar(100) not null unique,
    tipo enum('Residencial', 'Comercial', 'Celular') not null
);
create table cliente(
    id int not null primary key auto_increment,
    nome varchar(100) not null,
    cep varchar(11) not null,
    numero varchar(10),
    complemento varchar(100)
);
create table pedido(
    id int not null primary key auto_increment,
    id_cliente int not null,
    id_produto int not null,
    quantidade int not null,
    valor_unitario decimal(10,2) not null,
    subtotal decimal(10,2) default (valor_unitario * quantidade)
);

alter table telefone add constraint fk_telefones foreign key (id_cliente) references cliente(id);
alter table pedido add constraint fk_faz foreign key (id_cliente) references cliente(id);
alter table pedido add constraint fk_possui foreign key (id_produto) references produto(id);

describe produto;
describe telefone;
describe cliente;
describe pedido;
show tables;

use gestao_pedidos;
insert into cliente(nome, complemento, numero, cep) values
("Ana Maria Silva",null,"21","13905-522"),
("Valentina Oliveira","Ap:19 Bloco:2","12","13903-333"),
("Enzo Martins","Ap: 19"," 195B","13903-235");

insert into telefone(id_cliente,numero,tipo) values
(1,"19 99987-8789","Celular"),
(1,"19 99980-4848","Celular"),
(2,"19 98450-1212","Residencial"),
(3,"19 99988-2121","Celular"),
(3,"19 99777-2222","Residencial"),
(3,"19 99900-1010","Comercial");

insert into produto(nome) values
("Impressora laser"),
("Impressora deskjet"),
("Impressora matricial"),
("Impressora mobile");

insert into pedido(id,id_produto,id_cliente,quantidade,valor_unitario) values
(1005,1,1,5,1500.00),
(1006,2,1,3,350.00),
(1007,3,2,1,190.00),
(1008,4,3,6,980.00);

select * from cliente;
select * from telefone;
select * from produto;
select * from pedido;

insert into cliente (nome, cep, numero, complemento) values
('Timóteo Matos','13905-714','27','Ap44 bl01'),
('Xeila Teixeira de Souza','13907-100',null,'Fundos'),
('Raul Bispo Filho','13907-100','100',null),
('Hugo Souza','13904-906','9090','Fundos'),
('Brito Bispo Martim','13904-906','1313',null),
('Hugo Silva Alves','13904-452','1010',null),
('Valter Martins','13904-071','1245',null),
('Antônio Martins','13905-520','2345',null),
('Zélia Júnior','13901-329','13',null),
('Evandro Martins de Oliveira','13905-682','17','BL12 AP44');
SELECT * FROM cliente;

insert into Telefone (id_cliente, tipo, numero) values
(4, "celular", "19-90952-7709"),
(4, "residencial", "19-86960-6613"),
(5, "celular", "19-59052-5910"),
(5, "residencial", "19-70278-3889"),
(6, "celular", "19-95184-7473"),
(7, "celular", "19-18092-0669"),
(8, "celular", "19-19025-8194"),
(9, "celular", "19-54195-3946"),
(9, "residencial", "19-09467-9337"),
(10, "celular", "19-85553-5217"),
(11, "celular", "19-76827-0808"),
(12, "celular", "19-03094-9372"),
(12, "residencial", "19-87797-0571"),
(12, "comercial", "19-06019-6601"),
(13, "celular", "19-53922-8414");
select * from telefone;

-- 1.
SELECT id, nome 
FROM produto 
ORDER BY nome;

--2.
SELECT * 
FROM produto 
ORDER BY id DESC 
LIMIT 5;

--3.
SELECT id, quantidade, valor_unitario 
FROM pedido 
ORDER BY valor_unitario DESC;

--4.
SELECT * 
FROM pedido 
ORDER BY id DESC 
LIMIT 10;

--5.
SELECT p.id AS id_pedido, c.nome AS nome_cliente, p.quantidade, p.valor_unitario 
FROM pedido p 
JOIN cliente c ON p.id_cliente = c.id;

--6.
SELECT p.id AS id_pedido, pr.nome AS nome_produto, p.quantidade, p.valor_unitario 
FROM pedido p 
JOIN produto pr ON p.id_produto = pr.id;
--7.
SELECT p.id AS id_pedido, c.nome AS nome_cliente, pr.nome AS nome_produto, p.quantidade, p.valor_unitario, p.subtotal 
FROM pedido p 
JOIN cliente c ON p.id_cliente = c.id 
JOIN produto pr ON p.id_produto = pr.id;

--8.
SELECT c.nome AS nome_cliente, pr.nome AS nome_produto, p.subtotal 
FROM pedido p 
JOIN cliente c ON p.id_cliente = c.id 
JOIN produto pr ON p.id_produto = pr.id 
ORDER BY p.subtotal DESC 
LIMIT 5;

--9.
SELECT COUNT(*) AS total_clientes 
FROM cliente;

--10.
SELECT COUNT(*) AS total_produtos 
FROM produto;

--11.
SELECT c.nome, COUNT(p.id) AS total_pedidos 
FROM cliente c 
LEFT JOIN pedido p ON c.id = p.id_cliente 
GROUP BY c.id, c.nome;

--12.
SELECT pr.nome, COUNT(p.id) AS vezes_pedido 
FROM produto pr 
LEFT JOIN pedido p ON pr.id = p.id_produto 
GROUP BY pr.id, pr.nome 
ORDER BY pr.nome ASC;

--13.
SELECT SUM(subtotal) AS valor_total_geral 
FROM pedido;

--14.
SELECT AVG(quantidade) AS quantidade_media
FROM pedido;

--15.
SELECT pr.nome, SUM(p.subtotal) AS total_vendido
FROM produto pr
JOIN pedido p ON pr.id = p.id_produto
GROUP BY pr.id, pr.nome
ORDER BY total_vendido DESC;