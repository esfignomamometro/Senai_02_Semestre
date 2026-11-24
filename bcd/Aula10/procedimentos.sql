USE pizzaria;

DROP PROCEDURE IF EXISTS pedidoDeUmItem;

DELIMITER $

CREATE PROCEDURE pedidoDeUmItem(
    cli_id INT,
    piz_id INT,
    qtd INT
)
BEGIN

    DECLARE valorPizza FLOAT;
    DECLARE novoPedido INT;

    -- Buscar o valor da pizza
    SELECT valor INTO valorPizza
    FROM pizzas
    WHERE pizza_id = piz_id;

    -- Cadastrar o pedido
    INSERT INTO pedidos VALUES
    (DEFAULT, cli_id, CURDATE(), NOW(), NULL);

    -- Pegar o ID do pedido
    SET novoPedido = LAST_INSERT_ID();

    -- Cadastrar o item do pedido
    INSERT INTO itens_pedido VALUES
    (novoPedido, piz_id, qtd, valorPizza);

    -- Calcular o valor total
    UPDATE pedidos
    SET valor = (
        SELECT SUM(valor * quantidade)
        FROM itens_pedido
        WHERE pedido_id = novoPedido
    )
    WHERE pedido_id = novoPedido;

END $

DELIMITER ;