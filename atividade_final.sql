select *
from carros;
select *
from clientes;
select *
from locacao;
select *
from dimensoes;

INSERT INTO DIMENSOES (altura_mm, largura_mm, comprimento_mm, peso_kg, tanque_L, entre_eixos_mm, porta_mala_L, ocupante, fk_idCarro) VALUES
(1.475, 1.656, 3.892, 1020, 55, 2.467, 285, 5, 6), -- Gol
(1.480, 1.760, 4.540, 1230, 60, 2.600, 470, 5, 4), -- Corolla
(1.673, 1.844, 4.945, 1650, 55, 2.982, 0, 5, 1),  -- Toro
(1.487, 1.765, 3.935, 1084, 54, 2.488, 270, 5, 3), -- Fiesta
(1.490, 1.730, 4.425, 1130, 45, 2.550, 473, 5, 2), -- Yaris
(1.470, 1.720, 4.015, 993, 50, 2.530, 300, 5, 5),  -- Hb20
(1.471, 1.731, 4.163, 1034, 44, 2.551, 303, 5, 7); -- Onix

#3 Agora as perguntas a serem respondidas com o schema todo pronto: Crie 1 View para cada uma das perguntas

#Questao 1 -- Qual o modelo do carro que já foi alugado
select carros.modelo, locacao.dataLocacao
from carros as carros
inner join locacao as locacao on carros.idCarro = locacao.fk_idCarro;

#Questao 2 -- Qual o nome do cliente que já alugou um carro
select clientes.nome, locacao.dataLocacao
from clientes as clientes
inner join locacao as locacao on clientes.idCLiente = locacao.fk_idCliente;

#Questao 3 -- Qual o nome do cliente que alugou o carro com a diária mais alta.
select clientes.nome, max(locacao.valorDiaria) as valorDiaria
from clientes as clientes
inner join locacao as locacao on clientes.idCliente = locacao.fk_idCliente
group by (clientes.nome);

#Questao 4-- Qual a categoria do carro que foi alugado por ultimo
select carros.categoria, min(dataLocacao)
from carros as carros
inner join locacao as locacao on carros.idCarro = locacao.fk_idCarro
group by carros.categoria;

#Questao 5 -- Qual o nome do fabricante(s) que produziu o carro(s) mais potente(s)
WITH carros AS (
    SELECT *
    FROM carros
),
potencia AS (
    SELECT fabricante, MAX(potenciaMotor) AS potencia
    FROM carros
    GROUP BY fabricante
)
SELECT cp.fabricante, cp.potencia
FROM carros AS c
JOIN potencia AS cp
ON c.fabricante = cp.fabricante AND c.potenciaMotor = cp.potencia;


#Questao 6 -- Qual a cor da SUV locada no dia 2024-10-22
#Questao 7 -- Qual o modelo do carro, fabricante, cor que tem a menor diária
#Questao 8 -- Qual o modelo do carro e categoria que não foi alugado ainda
#Questao 9 -- Qual o nome do cliente que nunca alugou um carro do ano de fabricao 2013
#Questao 10 -- Qual o nome do cliente que já alugou um carro SUV
#Questao 11 -- Qual o nome do cliente que NÃO alugou um carro Sedan
#Questao 12 -- Qual a categoria do cliente que já alugou um carro com mais de 3000 quilômetros rodados
#Questao 13 -- Qual o modelo do carro que tem a menor altura.
#Questao 14 -- Qual o tamanho do porta mala do carro que é da categoria Hatch
#Questao 15 – Você deve criar mais 10 sub Consultas nesse sistema.