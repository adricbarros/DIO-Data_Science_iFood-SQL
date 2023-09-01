-- Queries simples para verificação da persistência dos dados
select * from clientes;
select * from fornecedores;
select * from funcionarios;
select * from produtos;
select * from servicos;
select * from orcamentos;
select * from item_orcamentos;
select * from ordemservico;
select * from item_ordemservico;
select * from vendas;
select * from item_vendas;

-- Pergunta: Quais são os clientes que não residem no estado do Rio de Janeiro ?
select c.nome_cli as 'Nome do Cliente', c.cidade as 'Cidade', c.uf as 'Estado' from clientes c 
	where c.uf <> 'rj' order by c.nome_cli limit 5;


-- Quais são os nomes, telefones e emails dos clientes que são Pessoa-Juridica ?
select c.nome_cli as 'Nome do Cliente', c.telefone as 'Telefone', c.email as 'E-mail' from clientes c 
	where character_length(c.cpf_cnpj) > 11 order by c.nome_cli;


-- Qual a quantidade de Clientes ?
select count(*) as ' Quantidade de Clientes' from clientes ;


-- Quais são os veiculos cujos serviços foram concluidos, o responsavel pelo serviço e que estão aguardando faturamento ?
select  o.placa_veiculo as 'Veículo', f.nome_func as 'Responsável Técnico', o.status as 'Status da OS' from ordemservico o
	join funcionarios f
    on o.id_funcionario_resp_os = id_funcionario 
    where o.status = 'Fechada'
    order by o.placa_veiculo;


-- Quais são os veiculos cujos serviços sofreram atrasos, seus status e o responsavel pelo serviço ?
select  o.placa_veiculo as 'Veículo', f.nome_func as 'Responsável Técnico', o.status as 'Status da OS', o.data_entrega - prazo_entrega as
	'Dias de Atraso' from ordemservico o join funcionarios f
    on o.id_funcionario_resp_os = id_funcionario where o.data_entrega > prazo_entrega
    order by o.placa_veiculo;


-- Quais são os funcionários da empresa, suas idades, funções e setor de atuação ?
select nome_func as 'Funcionário', timestampdiff (year, data_nasc, now()) as 'Idade', funcao as 'Função', lotacao as 'Setor' from funcionarios
	order by nome_func ;
select * from funcionarios; 


-- Quantos funcionários a empresa possui por setor e quais são suas Funções ?
select funcao as 'Função', lotacao as 'Setor', count(funcao) as 'Funcionários por Setor'
	from funcionarios group by funcao 
	having count(funcao) >= 1;
