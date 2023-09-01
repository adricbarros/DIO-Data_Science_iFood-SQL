create database oficina;
use oficina;

-- Criação da tabela do Cadastro de Clientes
-- A aplicação deverá tratar os dados inseridos no atributo cpf_cnpj para validar o valor inserido
create table clientes(
	id_Cliente int auto_increment primary key,
	cpf_cnpj varchar(14) not null unique,
	nome_cli varchar(50) not null,
	nascimento date not null,
	data_cadastro date not null,
	endereco varchar(100) not null,
	cidade varchar(50) not null,
	uf char(2) not null,
    cep char(9) not null,
	telefone varchar(11) not null,
	email varchar(50) not null
    ) engine = InnoDB default charset = latin1;
create index idx_clientes_nome on clientes(nome_cli);

-- Criação da tabela do Cadastro de Fornecedores
-- A aplicação deverá tratar os dados inseridos no atributo cpf_cnpj para validar o valor inserido
create table fornecedores(
	id_Fornecedor int auto_increment primary key,
	cpf_cnpj varchar(14) not null unique,
	razao_social varchar(50) not null,
	nome_fantasia varchar(50),
	fund_nasc date not null,
	data_cadastro date not null,
	endereco varchar(100) not null,
	cidade varchar(50) not null,
    cep char(9) not null,
	uf char(2) not null,
	responsavel varchar(50) not null,
	telefone varchar(11) not null,
	email varchar(50) not null
    ) engine = InnoDB default charset = latin1;
create index idx_fornecedores_razao_social on fornecedores(razao_social);

-- Criação da tabela do Cadastro de Funcionarios
-- A aplicação deverá tratar os dados inseridos no atributo cpf para validar o valor inserido
create table funcionarios(
	id_funcionario int auto_increment primary key,
	CPF char(11) not null unique,
	nome_func varchar(50) not null,
	data_nasc date not null,
	telefone varchar(11) not null,
	email varchar(50) not null,
	endereco varchar(100) not null,
	cidade varchar(50) not null,
    cep char(9) not null,
	uf char(2) not null,
	funcao enum('Mecanico','Eletricista','Pintor', 'Funileiro','Lavador','Gerente', 'Recepcionista',
				'Estoquista','Vendedor','Administrativo') default 'Recepcionista' not null,
	lotacao enum('Oficina', 'Vendas', 'Estoque', 'Recepcao', 'Administrativo', 'Gerencia') default 'Administrativo' not null
	) engine = InnoDB default charset = latin1;
    
-- Criação da tabela do Cadastro de Produtos
create table produtos(
	id_produto int auto_increment primary key,
	nome_produto varchar(50) not null,
	fabricante varchar(50) not null,
	id_fornecedor_prod int,
	garantia_fabrica enum('3 meses','6 meses','12 meses') default '3 meses' not null, 
	garantia_oficina enum('3 meses','6 meses','12 meses') default '3 meses' not null, 
	quantidade int not null,
	valor float(9.2) not null,
	constraint fk_produtos_fornecedor 
		foreign key (id_fornecedor_prod) references fornecedores(id_fornecedor) 
	) engine = InnoDB default charset = latin1;
create index idx_produtos_nome on produtos(nome_produto);


-- Criação da tabela do Cadastro de Serviços (Oficina)
create table servicos( 
	id_servico int auto_increment primary key,
	nome_servico char(50) not null,
	tipo_servico enum('Orcamento', 'Estetico', 'Mecanico', 'Eletrico', 'Funilaria', 'Pintura') default 'Orcamento' not null,
	tipo_cobranca enum('Tarefa', 'Hora', 'Gratuito') default 'Tarefa' not null,
	garantia_oficina enum('3 meses','6 meses','12 meses') default '3 meses' not null,
	valor float(9.2)
	) engine = InnoDB default charset = latin1;


-- Criação da tabela do cadastro de Orçamentos de Peças e Serviços (Balcão e Oficina)
create table orcamentos(
	id_orcamento int auto_increment primary key,
	id_cliente_orcamento int not null,
	id_funcionario_orcamento int not null,
	data_emissao date not null,
	prazo_entrega date not null,
	data_entrega date not null,
	validade enum('10 dias', '30 dias', '180 dias') default '10 dias' not null ,
	valor_total float(9.2),
	constraint fk_orcamento_cliente 
		foreign key(id_cliente_orcamento) references clientes(id_cliente),
	constraint fk_orcamento_funcionario 
		foreign key(id_funcionario_orcamento) references funcionarios(id_funcionario)
	) engine = InnoDB default charset = latin1;
create index idx_orcamento_data_emissao on orcamentos(data_emissao);


-- Criação da tabela que receberá os itens da composição do orçamento
-- Aplicação precisa tratar para que os campos de id de produto e serviço não fiquem ambos vazios
create table item_orcamentos(
	id_item_orcamento int auto_increment primary key,
    id_orcamento int,
	id_produto_orcamento int,
	id_servico_orcamento int,
	qt_item int not null,
	valor_item float (9.2) not null,
	constraint fk_id_orcamento_item_orcamento 
		foreign key (id_orcamento) references orcamentos(id_orcamento),
	constraint fk_item_orcamento_prod 
		foreign key (id_produto_orcamento) references produtos(id_produto),
	constraint fk_item_orcamento_serv 	
		foreign key (id_servico_orcamento) references servicos(id_servico)
	) engine = InnoDB default charset = latin1;
	
    
-- Criação da tabela de cadastro de Ordens de Serviços (Oficina)
create table ordemservico(
	id_ordemservico int auto_increment primary key,
	id_cliente_os int not null, 
	id_funcionario_resp_os int not null, -- Funcionario responsavel pela abertura da OS
	placa_veiculo char(8) not null,
	data_abertura date not null,
	prazo_entrega date not null,
	data_entrega date not null,
	valor_total_os float(9.2) not null,
	status enum('Em Aberto','Autorizada', 'Cancelada','Em execução','Fechada','Faturada') default 'Em Aberto' not null,
	constraint fk_cliente_os 
		foreign key (id_cliente_os) references clientes(id_cliente),
	constraint fk_funcionario_os 
		foreign key(id_funcionario_resp_os) references funcionarios(id_funcionario)
) engine = InnoDB default charset = latin1;
create index idx_ordemservico_placa_veiculo on ordemservico(placa_veiculo);
create index idx_ordemservico_data_abertura on ordemservico(data_abertura);


-- Criação da tabela de cadastro dos itens quem compoem a Ordem de Serviço
-- Aplicação precisa tratar quando ambos os campos de id de produto e serviço ficarem vazios
create table item_ordemservico(
	id_item_ordemservico int auto_increment primary key,
    id_osOrigem int,
	id_produto_ordemservico int,
	id_servico_ordemservico int,
	id_funcionario_exec_os int not null, -- Funcionario que executou os serviços da OS
	qt_item_os int not null,
	valor_item_os float (9.2) not null,
	constraint fk_id_osOrigem 
		foreign key (id_osOrigem) references ordemservico(id_ordemservico),
	constraint fk_item_ordemservico_prod 
		foreign key (id_produto_ordemservico) references produtos(id_produto),
	constraint fk_item_ordemservico_serv 
		foreign key (id_servico_ordemservico) references servicos(id_servico)
	) engine = InnoDB default charset = latin1;


-- Criação da tabela de cadastro de Vendas de Peças no Balcão
create table vendas(
	id_venda int auto_increment primary key,
	id_cliente_venda int not null,
	id_funcionario_venda int not null, 
    data_venda date not null,
	tipo_cobranca enum('Dinheiro', 'Cartao Debito', 'Cartao Credito', 'Boleto') default 'Dinheiro' not null,
	valor_total_venda float(9.2) not null,
	situacao enum('Aguardando pagamento', 'Negada', 'Paga', 'Cancelada') default 'Aguardando Pagamento' not null,
	constraint fk_vendas_cliente 
		foreign key(id_cliente_venda) references clientes(id_cliente),
	constraint fk_vendas_funcionario 
		foreign key(id_funcionario_venda) references funcionarios(id_funcionario)
	) engine = InnoDB default charset = latin1; 
create index idx_vendas_data_venda on vendas(data_venda);


-- Cria tabela com os itens de composição da Venda em Balcão
create table item_vendas(
	id_item_venda int auto_increment primary key,
    id_venda int not null,
	id_produto_venda int not null,
	qt_item_venda int not null,
	valor_item_venda float (9.2) not null,
	constraint fk_id_venda_item_venda
		foreign key (id_venda) references vendas(id_venda),
	constraint fk_item_venda_prod 
		foreign key (id_produto_venda) references produtos(id_produto)
	) engine = InnoDB default charset = latin1;
