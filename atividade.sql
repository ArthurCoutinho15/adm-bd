
select * from 
barco;
select * from 
reservas; 
select * from 
marinheiros;

select nome_marin, nome_barco, dia_reserva
from marinheiros as marinheiros
inner join reservas as reservas on marinheiros.id_marin = reservas.fk_id_marin
inner join barco as barco on reservas.fk_id_barco = barco.id_barco;

select nome_marin, data_nascimento
from marinheiros as marinheiros
inner join reservas as reservas on marinheiros.id_marin = reservas.fk_id_marin
inner join barco as barco on reservas.fk_id_barco = barco.id_barco
where nome_barco like 'Interlake';

select marinheiros.nome_marin, marinheiros.avaliacao
from marinheiros as marinheiros
inner join reservas as reservas on marinheiros.id_marin = reservas.fk_id_marin
inner join barco as barco on reservas.fk_id_barco = barco.id_barco
where barco.nome_barco like 'clipper';

select marinheiros.nome_marin, reservas.dia_reserva
from marinheiros as marinheiros
inner join reservas as reservas on marinheiros.id_marin = reservas.fk_id_marin
inner join barco as barco on reservas.fk_id_barco = barco.id_barco
where barco.cor like 'vermelho';

select marinheiros.nome_marin, reservas.dia_reserva
from marinheiros as marinheiros
inner join reservas as reservas on marinheiros.id_marin = reservas.fk_id_marin
inner join barco as barco on reservas.fk_id_barco = barco.id_barco
where barco.cor like 'verde';

select marinheiros.nome_marin, reservas.dia_reserva
from marinheiros as marinheiros
inner join reservas as reservas on marinheiros.id_marin = reservas.fk_id_marin
inner join barco as barco on reservas.fk_id_barco = barco.id_barco
where barco.cor like 'azul';

select marinheiros.nome_marin, barco.nome_barco, barco.cor
from marinheiros as marinheiros
inner join reservas as reservas on marinheiros.id_marin = reservas.fk_id_marin
inner join barco as barco on reservas.fk_id_barco = barco.id_barco
where marinheiros.nome_marin like 'lubber';

select marinheiros.nome_marin, barco.nome_barco, barco.cor, dia_reserva
from marinheiros as marinheiros
inner join reservas as reservas on marinheiros.id_marin = reservas.fk_id_marin
inner join barco as barco on reservas.fk_id_barco = barco.id_barco
where reservas.dia_reserva like '2023-10-10'
and marinheiros.nome_marin like 'dustin';

SELECT marinheiros.nome_marin, barco.nome_barco, barco.cor, reservas.dia_reserva
FROM marinheiros
INNER JOIN reservas ON marinheiros.id_marin = reservas.fk_id_marin
INNER JOIN barco ON reservas.fk_id_barco = barco.id_barco
WHERE reservas.dia_reserva > '2023-05-09'
GROUP BY marinheiros.nome_marin, barco.nome_barco, barco.cor, reservas.dia_reserva;