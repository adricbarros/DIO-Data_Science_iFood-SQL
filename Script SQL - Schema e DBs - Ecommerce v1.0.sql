-- criação de banco de dados para o cenáro de e-commerce
create database ecommerce;
use ecommerce;

-- criar tabela cliente
create table clients (
	idClient int auto_increment primary key,
	Fname varchar(10),
    Minit char(3),
    Lname varchar(20),
    CPF char(11) not null,
    Address varchar(255),
    constraint unique_cpf_client unique (CPF)
    );
desc clients;
-- criar tabela produto
-- size refere-se dimensão do produto
create table product (
	idProduct int auto_increment primary key,
	Pname varchar(50) not null,
	Classification_kids bool  default false,
	category enum ('Eletronico','Vestuario','Brinquedos','Alimentos','Moveis') not null, 
    avaliacao float default 0,
    size varchar(10)
);

-- criar tabela pagamento
-- para ser continuado no desafio: termine de implementar a tabela e crie a conexao com as tabelas necessarias
-- alem disso reflita essa modificação no diagrama de equema relacional
-- criar constraint relacionadas ao pagamento
create table payments(
idClient int,
idPayment int,
typePayment enum ('Boleto', 'Cartao', 'Dois Cartões'),
limiteAvailable float, 
primary key (idClient, idPayment)
);

-- criar tabela pedido
create table orders (
	idOrder int auto_increment primary key,
	idOrderClient int,
	orderStatus enum('Cancelado', 'Confirmado', 'Em Processamento') default 'Em Processamento',
	orderDescription varchar(255),
    sendValue float default 10,
    paymentCash boolean default false,
    constraint fk_orders_client foreign key (idOrderClient) references clients(idClient)
);
desc orders;

-- criar tabela estoque
create table productStorage (
idProdStorage int auto_increment primary key,
storageLocation varchar (255),
quantity int default 0
);
desc productstorage;

-- criar tabela fornecedor
create table Supplier (
idSupplier int auto_increment primary key,
CNPJ char(14) not null, 
socialName varchar(255) not null,
contact char(11) not null,
constraint unique_supplier unique (CNPJ)
);
desc supplier;

-- criar tabela vendedor
create table seller (
	idSeller int auto_increment primary key,
	CNPJ char(14),
	CPF char(11),
	SocialName varchar(255) not null,
	AbstName varchar(255),
	location varchar(255),
	contact char(11) not null,
	constraint unique_seller_cnpj unique (cnpj),
    constraint unique_seller_cpf unique (CPF)
	);
desc seller;

-- criar tabela Produtos_vendedor
create table productSeller(
idPseller int, 
idProduct int,
prodQuantity int default 1,
primary key (idPseller, idProduct),
constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
constraint fk_product_produtct foreign key (idProduct) references product(idProduct)
);
desc productseller;

-- criar tabela Produto_pedido
create table productOrder(
idPOproduct int,
idPOorder int,
poQuantity int default 1,
poStatus enum ('Disponivel', 'Sem Estoque') default 'Disponivel',
primary key (idPOProduct, iDPOorder),
constraint fk_productorder_seller foreign key (idPoproduct) references product(idProduct),
constraint fk_productorder_product foreign key (idPOorder) references orders(idOrder)
);
desc productorder;

-- criar tabela Produto_em_estoque
create table storageLocation (
	idLproduct int,
	idLstorage int,
	location varchar(255) not null,
	primary key (idLproduct, idLstorage),
	constraint fk_storage_location_product foreign key (idLProduct) references product(idProduct),
	constraint fk_storage_location_storage foreign key (idLStorage) references productStorage(idProdStorage)
);
desc storagelocation;

-- criar tabela Produto_Fornecedor
create table productSupplier (
idPsSupplier int, 
idPsProduct int,
Quantity int not null,
primary key (idPsSupplier, idPsProduct),
constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct)
);

-- show databases;
-- use information_schema;
show tables;
-- desc referential_constraints;
-- select * from referential_constraints where constraint_schema = 'ecommerce';
