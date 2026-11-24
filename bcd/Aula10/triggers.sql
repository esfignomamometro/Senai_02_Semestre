USE pizzaria;

DROP TRIGGER IF EXISTS trg_atualiza_valor_pedido_insert;

DELIMITER //

CREATE TRIGGER trg_atualiza_valor_pedido_insert
AFTER INSERT ON itens_pedido
FOR EACH ROW
BEGIN
    UPDATE pedidos
    SET valor = (
        SELECT COALESCE(SUM(valor * quantidade), 0)
        FROM itens_pedido
        WHERE pedido_id = NEW.pedido_id
    )
    WHERE pedido_id = NEW.pedido_id;
END//

DELIMITER ;