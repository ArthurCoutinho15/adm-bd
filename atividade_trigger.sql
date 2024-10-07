DELIMITER $$
CREATE TRIGGER verifica_e_exclui_depositante
AFTER DELETE ON conta
FOR EACH ROW
BEGIN
    DECLARE num_contas INT;


    SELECT COUNT(*)
    INTO num_contas
    FROM depositante
    WHERE nome_cliente IN (SELECT nome_cliente FROM depositante WHERE num_conta = OLD.num_conta);


    IF num_contas = 0 THEN
        DELETE FROM depositante WHERE num_conta = OLD.num_conta;
    END IF; 
END$$
DELIMITER ;