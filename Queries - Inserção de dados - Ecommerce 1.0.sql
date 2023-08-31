

insert into Clients (Fname, Minit, Lname, CPF, address)
	values ('Renata', 'J', 'Pinto', '00460110723', 'Rua da Quitanda 19, Cidade Nova - Vinhedo' ),
		   ('Matheus', 'M', 'Pimentel', '01850585706', 'Rua Bala de Prata 38, Transilvania - Cidade dos Morcegos' ),
           ('Nair', 'F', 'Belo', '01950485701', 'Av Cascadura 18, Rio Marinho - Vila Velha' ),
           ('Marcelo', 'P', 'Santos', '02103250594', 'Rua Cel. Moreira Cesar 35, Centro - São Gonçalo' ),
           ('Mariana', 'D', 'Cavalcante', '02799586601', 'Rua das Orquideas 22, Jardim Camburi - Vitoria' ),
           ('Magaly', 'N', 'Pereira', '01930335707', 'Rua das Margaridas 56, Laranjeiras - Serra' ),
           ('Paloma', 'B', 'Barrros', '04450585706', 'Rua Balao Magico 99, Cidade Nova - Itaperuna' ),
           ('Teofilo', 'C', 'Cerqueira', '02140490981', 'Rua Coronel Josino 22, Vila Pavão - Miracema' ),
           ('Tiara', 'D', 'Cabelo', '03378932101', 'Rua das Flores 44, Cehab - Santa Teresa' );
select * from clients;


insert into product (Pname, classification_kids, category, avaliacao, size) 
	values ('Fone de Ouvido', false, 'Eletronico','4', null),
		   ('Barbie Elsa', true, 'Brinquedos','3', null),
           ('Body Carters', true, 'Vestuario','5', null),
           ('Microfone Vedo - Youtuber', false, 'Eletronico','4', null),
           ('Sofa retrátil', false, 'Moveis','3', '220x90x80'),
           ('Monitor LED 24"', false, 'Eletronico', '4', null),
           ('Agua Mineral', false, 'Alimentos', '5', '500ml'),
		   ('Carabina Ar Comprimido 5,5mm', true, 'Brinquedos', '3', '6x8x120'),
           ('Camisa Polo MAsculina', true, 'Vestuario', '5', null),
           ('Teclado Gamer Mecanico LED', false, 'Eletronico', '4', null),
           ('Cadeira de escritorio giratoria"', false, 'Moveis', '3', '65x55x135');
select * from product;

 
insert into orders (idorderclient, orderstatus, orderdescription, sendvalue, paymentcash)
	values (1,default,'Compra via Aplicativo',null,1),
		   (2,default,'Compra via Aplicativo',50,0),
           (3,'Confirmado',null,null,1),
           (4,'Confirmado',null,null,1),
           (5,default,'Compra via Web Site',150,0);
select * from orders;

  
insert into productorder (idPOproduct, idPOorder, poQuantity, poStatus)
	values (1,1,2,null),
		   (2,1,1,null),
		   (3,1,1,null);
select * from productorder;


insert into productStorage (storageLocation, quantity)
	values ('Rio de Janeiro', 1000),
		   ('Rio de Janeiro', 500),
           ('São Paulo', 10),
           ('São Paulo', 100),
           ('São Paulo', 10),
           ('Brasilia', 10);
select * from productstorage;


insert into storagelocation (idLproduct, idLstorage, location)
	values (1,2,'RJ'),
		   (2,6,'GO');
select * from storagelocation;


insert into Supplier (SocialName, CNPJ, Contact)
	values ('Almeida e Filhos', '12345678901234', '21995739558'),
		   ('Eletronicos Silva', '43210987654321', '41998956758'),
           ('Eletronicos Valma', '87654321098765', '11996749558');
select * from supplier;


insert into productsupplier (idPsSupplier, idPsProduct, quantity)
	values (4,1,500), 
		   (4,2,400),
		   (5,4,633),
           (6,3,5),
           (5,5,10);
select * from productsupplier;


insert  into seller (Socialname, Abstname, cnpj, cpf, location, contact)
	values ('Tech Eletronics', null, 12345678901234, null, 'Rio de Janeiro', 21995718558),
		   ('Boutique Dunga', null, null, 12345678901, 'Rio de Janeiro', 21995893451),
           ('Tech Eletronics', null, 23456789012345, null, 'São Paulo', 1197618552);
select * from seller;


insert into productseller (idPseller, idProduct, prodQuantity)
	values (4,6,80),
           (5,7,10);
select * from productseller;           

select count(*) from clients;
select * from clients c, orders o where c.idclient = idorderclient;

select count(*) from clients c, orders o 
	where c.idclient = idorderclient;

select * from clients c inner join orders o on c.idclient = o.idorderclient
	inner join productorder p on p.idPoOrder = o.idorder;
    
    select * from orders;
    select * from productorder;