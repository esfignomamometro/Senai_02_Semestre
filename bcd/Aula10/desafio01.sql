USE pizzaria;


-- 1. PROCEDIMENTO ARMAZENADO (pedidoDeUmItem)

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
    INSERT INTO pedidos VALUES (DEFAULT, cli_id, CURDATE(), NOW(), NULL);

    -- Pegar o ID do pedido recém-criado
    SET novoPedido = LAST_INSERT_ID();

    -- Cadastrar o item do pedidos
    INSERT INTO itens_pedido VALUES (novoPedido, piz_id, qtd, valorPizza);

    -- Calcular e atualizar o valor total do pedido
    UPDATE pedidos
    SET valor = (
        SELECT SUM(valor * quantidade)
        FROM itens_pedido
        WHERE pedido_id = novoPedido
    )
    WHERE pedido_id = novoPedido;
END $

DELIMITER ;



-- 2. CADASTRO DOS PEDIDOS DE TESTE (DESAFIO 01)


-- Thamires de Campos Luz (ID 96) quer 1 pizza Vienense (ID 12, por exemplo)
-- Substitui o 12 pelo pizza_id correto da pizza Vienense na tua base
CALL pedidoDeUmItem(96, 12, 1);

-- Everton Jose de Souza (ID 105) quer 2 pizzas Toscana
-- Substitui o ID da pizza Toscana pelo correto
CALL pedidoDeUmItem(105, 15, 2);

-- Silvia Roberta de Jesus Garcia (ID 98) quer 1 pizza Canadense e 2 Cubanas
-- Substitui pelos IDs corretos da Canadense e Cubana
CALL pedidoDeUmItem(98, 8, 1);
CALL pedidoDeUmItem(98, 10, 2);


-- 3. PROVAS DE EXECUÇÃO (CONFERÊNCIA)

SELECT * FROM pedidos where cliente_id IN (96, 105, 98);