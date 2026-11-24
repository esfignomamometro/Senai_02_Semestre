SELECT * FROM produto;
SELECT * FROM pedido;

SELECT p.*, pr* FROM produto pr ON p.id_produto = pr.id;

SELECT cliente.*, pedido.* FROM cliente JOIN pedido ON cliente.id = pedido.id_cliente;

SELECT cliente.*, pedido.* FROM cliente JOIN pedido
ON cliente.id = pedido.id_cliente
WHERE cliente.id = 1;

SELECT p.*, pr.* FROM pedido p JOIN produto pr
ON p.id_produto = pr.id
ORDER BY p.id DESC
LIMIT 2;