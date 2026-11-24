-- Consultas /Query
select * from cliente;
select * from produto;
select * from pedido;
select * from telefone;


select * from cliente order by nome desc;

select * from cliente order by id desc;

select * from cliente limit 4;

select * from cliente where id between 3 and 5;

select * from cliente where id between 10 and 13;

select * from cliente where nome "Valter Martins";

select * from cliente where nome like "%Silva%";

select now();
select round(10.0/3,2);
select round(1.475,2);
select floor(1.475);

select c.nome, t.numero, t.tipo
from cliente c inner join telefone t
on c.id = t.id_cliente
