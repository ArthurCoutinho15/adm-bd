/*1. Views (Visões)
Conceito: Uma view é uma tabela virtual baseada em uma consulta SQL. Ela não armazena dados fisicamente, mas exibe dados de uma ou mais tabelas. Views são úteis para simplificar consultas complexas, melhorar a segurança (limitando o acesso a certas colunas) e fornecer uma interface de dados personalizada.

Exercício 1: Crie uma view que mostre o nome do cliente e o saldo de suas contas em um banco.*/


CREATE VIEW cliente_saldo AS
SELECT cliente.nome_cliente, conta.saldo
FROM cliente
JOIN depositante ON cliente.nome_cliente = depositante.nome_cliente
JOIN conta ON depositante.num_conta = conta.num_conta;

#Exercício 2: Crie uma view que mostre o nome da agência e o saldo total das contas associadas a cada agência.


CREATE VIEW agencia_saldo_total AS
SELECT agencia.nome_agencia, SUM(conta.saldo) AS saldo_total
FROM agencia
JOIN conta ON agencia.nome_agencia = conta.nome_agencia
GROUP BY agencia.nome_agencia;

/*2. Functions (Funções)
Conceito: Uma function é um bloco de código que pode ser reutilizado em consultas SQL. Ela pode receber parâmetros de entrada, realizar operações e retornar um valor. Functions são frequentemente usadas para cálculos ou manipulações de dados.*/

#Exercício 1: Crie uma função que calcule o imposto de renda sobre um salário. Considere que o imposto é de 15% para salários acima de R$ 4.000,00.

Delimiter $$
CREATE FUNCTION calcula_imposto(salario DECIMAL(10,2))
RETURNS DECIMAL(10,2)
BEGIN
    DECLARE imposto DECIMAL(10,2);
    IF salario > 4000 THEN
        SET imposto = salario * 0.15;
    ELSE
        SET imposto = 0;
    END IF;
    RETURN imposto;
END;
Delimiter;

#Exercício 2: Crie uma função que receba o nome de um cliente e retorne o saldo total de suas contas.

Delimiter $$
CREATE FUNCTION saldo_cliente(nome_cliente VARCHAR(100))
RETURNS DECIMAL(10,2)
BEGIN
    DECLARE saldo_total DECIMAL(10,2);
    SELECT SUM(conta.saldo) INTO saldo_total
    FROM depositante
    JOIN conta ON depositante.num_conta = conta.num_conta
    WHERE depositante.nome_cliente = nome_cliente;
    RETURN saldo_total;
END;
Delimiter;
/*3. Procedures (Procedimentos)
Conceito: Uma procedure é semelhante a uma função, mas não retorna um valor diretamente. Em vez disso, realiza uma sequência de operações no banco de dados, como inserções, atualizações e exclusões. Procedures são úteis para automatizar tarefas administrativas.*/

#Exercício 1: Crie uma procedure que atualize o saldo de uma conta, dado o número da conta e o valor a ser somado.


CREATE PROCEDURE atualiza_saldo(IN num_conta INT, IN valor DECIMAL(10,2))
BEGIN
    UPDATE conta
    SET saldo = saldo + valor
    WHERE num_conta = num_conta;
END;
Exercício 2: Crie uma procedure que transfira um valor entre duas contas.


CREATE PROCEDURE transfere_valor(IN num_conta_origem INT, IN num_conta_destino INT, IN valor DECIMAL(10,2))
BEGIN
    -- Subtrai o valor da conta de origem
    UPDATE conta
    SET saldo = saldo - valor
    WHERE num_conta = num_conta_origem;

    -- Adiciona o valor à conta de destino
    UPDATE conta
    SET saldo = saldo + valor
    WHERE num_conta = num_conta_destino;
END;

/*4. Triggers (Gatilhos)
Conceito: Um trigger é um bloco de código que é automaticamente executado (disparado) em resposta a eventos específicos no banco de dados, como inserções, atualizações ou exclusões. Eles são usados para manter a integridade dos dados e realizar ações automáticas baseadas em mudanças nas tabelas.

Exercício 1: Crie um trigger que, após a inserção de um novo cliente na tabela cliente, insira um log na tabela log_cliente registrando a ação.*/


CREATE TRIGGER log_novo_cliente
AFTER INSERT ON cliente
FOR EACH ROW
BEGIN
    INSERT INTO log_cliente (nome_cliente, data_acao, tipo_acao)
    VALUES (NEW.nome_cliente, NOW(), 'inserção');
END;

#Exercício 2: Crie um trigger que, ao excluir uma conta, verifique se o cliente associado tem outras contas. Se o cliente não tiver mais contas, exclua-o da tabela depositante.


CREATE TRIGGER verifica_exclusao_conta
AFTER DELETE ON conta
FOR EACH ROW
BEGIN
    DECLARE num_contas INT;
    
    -- Verifica se o cliente possui outras contas
    SELECT COUNT(*)
    INTO num_contas
    FROM depositante
    WHERE nome_cliente IN (SELECT nome_cliente FROM depositante WHERE num_conta = OLD.num_conta);
    
    -- Se o cliente não possui outras contas, exclui-o da tabela depositante
    IF num_contas = 0 THEN
        DELETE FROM depositante WHERE nome_cliente IN (SELECT nome_cliente FROM depositante WHERE num_conta = OLD.num_conta);
    END IF;
END;

/*
Dicas para Estudo:
Views: Use views para simplificar consultas complexas e ocultar a complexidade dos dados. Pratique a criação de views baseadas em várias tabelas usando joins.

Functions: Foque em funções que retornam valores úteis, como cálculos financeiros ou manipulações de string/datas. Treine passando diferentes parâmetros de entrada.

Procedures: As procedures são ótimas para tarefas repetitivas e processos de negócios. Tente criar procedures que realizem operações comuns, como transferências de valores e atualizações de registros.

Triggers: Triggers são poderosas para garantir a integridade dos dados. Pratique a criação de triggers que respondem a operações como inserção e exclusão, mantendo a consistência entre as tabelas.*/