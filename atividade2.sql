# 1 Crie uma view que apresente o total de pedidos do dia 2024-08-21
create view vtotalpedidossetembro(total_pedidos) as 
select count(*)
from pedidos
where dataped like '2024-08-21';
# 2 Crie uma view que apresente o total de pedidos já realizados
create view vtotalpedidos(total_pedidos) as 
select count(*)
from pedidos;
# 3 Crie uma view que apresente o nome dos clientes que ja fizeram uma compra
# 4 Crie uma view que apresente os produtos que já foram comprados
# 5 Crie uma view que apresente quais produtos os clientes compraram
create view clientes_pedido(nome_cliente, produto) as 
select  clientes.nome, produtos.descricao
from pedidos as pedidos
inner join clientes as clientes on pedidos.fk_id_Cliente = clientes.idCliente
inner join itemspedidos as itemspedidos on pedidos.idPedido = itemspedidos.fk_id_Pedido
inner join produtos as produtos on itemspedidos.fk_id_Produto = produtos.idProduto;
# 6 Crie uma view que apresente o ticket media dos valores dos pedidos
create view media_pedidos(preco_medio_produtos) as 
select round(avg(valorTotalPedido))
from pedidos;
# 7 Crie uma view que apresente o lucro que rendeu um pedido qualquer
create view lucro_pedidos(id_pedido, produto, lucro) as 
select pedidos.idPedido,produtos.descricao,round(pedidos.valorTotalPedido  - produtos.precoCompra) as lucro
from pedidos as pedidos 
inner join itemspedidos  as itemspedidos on pedidos.idPedido = itemspedidos.fk_id_Pedido
inner join produtos as produtos on itemspedidos.fk_id_Produto = produtos.idProduto
having lucro > 0;
# 8 Crie uma view que apresente quantos pedidos já foram feitos
create view quantidade_pedidos (qtd_pedidos) as 
select count(*)
from pedidos;
# 9 Crie uma view que apresente qual o maior pedido em valor
create view maior_valor_pedidos (maior_valor) as 
select max(valorTotalPedido)
from pedidos;

# 10 Crie uma view que apresente qual o menor pedido em valor
create view menor_valor_pedidos (menor_valor) as 
select min(valorTotalPedido)
from pedidos;

# 11 Crie uma view que apresente qual o endereco do cliente Teclaudio
create view endereco_teclaudio (nome_cliente, bairro_cliente) as 
select clientes.nome, enderecos.bairro
from clientes as clientes
inner join enderecos as enderecos on clientes.fk_id_endereco = enderecos.idEndereco
where clientes.nome like '%Teclaudio%';

# 12 Crie uma view que apresente qual endereco dos clientes que ja fizeram compras
create view endereco_clientes_compras (nome_cliente, logradouro_cliente, numero_logradouro) as 
select clientes.nome, enderecos.Logradouro, enderecos.numero
from clientes as clientes
inner join enderecos as enderecos on clientes.fk_id_endereco = enderecos.idEndereco
inner join pedidos as pedidos on clientes.idCliente = pedidos.fk_id_Cliente;

# 13 Crie uma view que apresente quais pedidos foram pagos em pix
create view pedidos_pix (id_pedido, forma_pagamento) as 
select pedidos.idPedido, pagamentos.forma_pagamento
from pedidos as pedidos 
inner join pagamentos as pagamentos on pedidos.fk_id_pagamento = pagamentos.idPagamento
where forma_pagamento like '%PIX%';

# 14 Crie uma view que apresente quais pedidos foram pagos em cartao
create view pedidos_cartao (id_pedido, forma_pagamento) as 
select pedidos.idPedido, pagamentos.forma_pagamento
from pedidos as pedidos 
inner join pagamentos as pagamentos on pedidos.fk_id_pagamento = pagamentos.idPagamento
where forma_pagamento like '%CARTAO_CREDITO%';

# 15 Crie uma view que apresente quais itens foram pedidos no pedido do Marta Castro
create view marta_produto(nome_cliente, produto_cliente ) as
select clientes.nome, produtos.descricao
from clientes as clientes
inner join pedidos as pedidos on clientes.idCliente = pedidos.fk_id_Cliente
inner join itemspedidos as itemspedidos on pedidos.idPedido = itemspedidos.fk_id_Pedido
inner join produtos as produtos on itemspedidos.fk_id_Produto = produtos.idProduto 
where clientes.nome like '%Marta Castro%';

# 16 Crie uma view que apresente qual fornecedor fabricou os produtos do pedido da Helena Carla
create view cliente_produto_fornecedor (nome_cliente, produto_cliente, fornecedor_nome) as 
select clientes.nome, produtos.descricao, fornecedores.nome
from clientes as clientes 
inner join pedidos as pedidos on clientes.idCliente = pedidos.fk_id_Cliente
inner join itemspedidos as itemspedidos on pedidos.idPedido = itemspedidos.fk_id_pedido
inner join produtos as produtos on itemspedidos.fk_id_produto = produtos.idProduto
inner join fornecedores as fornecedores on produtos.fk_id_fornecedor = fornecedores.idFornecedor
where clientes.nome like '%Helena Carla%';

# 17 Crie uma view que apresente qual fornecedor fabrica as Camisas comercializadas
create view camisas_fornecedor (camisas, fornecedor) as 
select produtos.descricao, fornecedores.nome
from produtos as produtos
inner join fornecedores as fornecedores on produtos.fk_id_fornecedor = fornecedores.idFornecedor
where descricao like '%Camisa%';

# 18 Crie uma view que apresente qual a quantidade em estoque do produto comprado pela Maria de Almeida
create view produtos_estoque (nome_cliente, descricao_produto, qtd_estoque) as 
select clientes.nome, produtos.descricao, produtos.estoque
from clientes as clientes
inner join pedidos as pedidos on clientes.idCliente = pedidos.fk_id_Cliente
inner join itemspedidos as itemspedidos on pedidos.idPedido = itemspedidos.fk_id_pedido
inner join produtos as produtos on itemspedidos.fk_id_Produto = produtos.idProduto
where clientes.nome like '%Maria de Almeida%';

# 19 Crie uma view que apresente o total de produtos fabricados pela Marte Roupas
create view marte_produtos(qtd_produtos) as 
select count(produtos.idProduto)
from produtos as produtos
inner join fornecedores as fornecedores on produtos.fk_id_fornecedor = fornecedores.idFornecedor
where fornecedores.nome like '%Marte Roupas%';

