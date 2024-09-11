# ----- Exercicios Funcoes ----
# 1 Crie uma Função que : pesquise um nome que termine com a letra S na tabela Fornecedores
Delimiter $$
create function fornecedoresLetra_S()
returns varchar(60)
deterministic
begin
	return (
		Select GROUP_CONCAT(nome SEPARATOR ', ')
        from fornecedores
        where nome like '%S'
        );
end;
delimiter;
select fornecedoresLetra_S() as fornecedores_letra_s;

# 2 Crie uma Função que : Retire os seguintes caracteres do texto abaixo : * . - !
Delimiter $$
create function trataCaracteres(texto varchar(255))
returns varchar(255)
deterministic
begin
	set texto = replace(texto, '*', '');
    set texto = replace(texto, '.', '');
    set texto = replace(texto, '-', '');
    set texto = replace(texto, '!', '');
    set texto = replace(texto, '+', '');
	
    return texto;
end;
delimiter;

select trataCaracteres('Ta*lvez v.ocê ain*da n.ão saiba o que é *SQL. Ma.s,
 -provavelm-ente, ente-nde que lidar com o gerenciamento é super importante. d-e da-dos t+em se to+rna.do um d!!esafio cada vez maior') as tratamento;
 
# 3 Crie uma Função que : Calcule a média de 3 valores
DELIMITER $$
CREATE FUNCTION media_valores(a FLOAT, b FLOAT, c FLOAT)
RETURNS FLOAT
DETERMINISTIC
BEGIN
    RETURN (a + b + c) / 3;
END $$
DELIMITER ;

select media_valores(4.0,5.0,6.0) as medias;

# 4 Crie uma Função que : Calcule a expressao : x+2(y-1)*5+x;
delimiter $$
create function expressao(x int, y int)
returns int
deterministic
begin 
	return x + 2 * (y + 1) * 5 + x;
end;
delimiter;

select expressao(2,3) as expressao;

# 5 Crie uma Função que : apresente um texto com palavras escritas ao contrario.
DELIMITER $$

CREATE FUNCTION palindromo(palavra1 VARCHAR(50), palavra2 VARCHAR(50), palavra3 VARCHAR(50))
RETURNS VARCHAR(150)
DETERMINISTIC
BEGIN 
    DECLARE palavra_invertida1 VARCHAR(50);
    DECLARE palavra_invertida2 VARCHAR(50);
    DECLARE palavra_invertida3 VARCHAR(50);

    SET palavra_invertida1 = REVERSE(palavra1);
    SET palavra_invertida2 = REVERSE(palavra2);
    SET palavra_invertida3 = REVERSE(palavra3);
	
    RETURN CONCAT(palavra_invertida1, '|', palavra_invertida2, '|', palavra_invertida3);
END $$
DELIMITER ;

SELECT palindromo('ana', 'radar', 'oso') AS palavras_invertidas;


# 6 Crie uma Função que : dê 5% de denconto em uma venda realizada.
DELIMITER $$

CREATE FUNCTION desconto(venda FLOAT)
RETURNS FLOAT
DETERMINISTIC
BEGIN
    DECLARE valor_final FLOAT;
    
    SET valor_final = venda * 0.95;
    
    RETURN valor_final;
END $$

DELIMITER ;

select desconto(300.0) as desconto;
