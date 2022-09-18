CREATE DATABASE Manicure;

USE Manicure;

CREATE TABLE Cliente (
idCliente int NOT NULL AUTO_INCREMENT PRIMARY KEY,
nome varchar(200) NOT NULL,
endereco varchar(255) NOT NULL,
cpf varchar(11) UNIQUE,
rg varchar(15) UNIQUE,
email varchar(45) UNIQUE,
celular varchar(45) UNIQUE,
senha varchar(200) UNIQUE,
Pacote_id int,
Assinatura_id int,
FOREIGN KEY (Pacote_id) REFERENCES Pacotes(idPacote),
FOREIGN KEY (Assinatura_id) REFERENCES Assinatura(idAssinatura)
);


CREATE TABLE Procedimento (
idProcedimento int NOT NULL AUTO_INCREMENT PRIMARY KEY,
nome varchar(255) NOT NULL,
valor decimal(9,2) NOT NULL
); 




CREATE TABLE Cliente_Procedimento (
idCliente_Procedimento int NOT NULL AUTO_INCREMENT PRIMARY KEY,
Cliente_id int,
Procedimento_id int,
FOREIGN KEY (Cliente_id) REFERENCES Cliente(idCliente),
FOREIGN KEY (Procedimento_id) REFERENCES Procedimento(idProcedimento)
);

CREATE TABLE CorEsmalte (
idCorEsmalte int NOT NULL AUTO_INCREMENT PRIMARY KEY,
CoresDisponiveis varchar(255)
);


CREATE TABLE Cliente_CorEsmalte (
idCliente_CorEsmalte int NOT NULL AUTO_INCREMENT PRIMARY KEY,
Cliente_id int,
CorEsmalte_id int,
FOREIGN KEY (Cliente_id) REFERENCES Cliente(idCliente),
FOREIGN KEY (CorEsmalte_id) REFERENCES CorEsmalte(idCorEsmalte)
);

CREATE TABLE Assinatura (
idAssinatura int NOT NULL AUTO_INCREMENT PRIMARY KEY,
nome varchar(50) NOT NULL,
valor decimal(9,2) NOT NULL,
credito decimal(9,2) NOT NULL,
descricao text(500)
);


CREATE TABLE Pacotes (
idPacote int NOT NULL AUTO_INCREMENT PRIMARY KEY,
nome varchar(255) NOT NULL,
valor decimal(9,2) NOT NULL,
descricao text(500),
data_atendimento datetime NOT NULL
);


CREATE TABLE Cartao_Credito (
idCartao_Credito int NOT NULL AUTO_INCREMENT PRIMARY KEY,
n_cartao varchar(255) NOT NULL UNIQUE,
validade date NOT NULL,
cvv varchar(3) NOT NULL,
Cliente_Procedimento_id int,
FOREIGN KEY (Cliente_Procedimento_id) REFERENCES Cliente_Procedimento(idCliente_Procedimento)
);



CREATE TABLE Orcamento (
idOrcamento int NOT NULL AUTO_INCREMENT PRIMARY KEY,
frete decimal(9,2),
desconto decimal(9,2),
Cliente_Procedimento_id int,
Cliente_id int,
Cartao_Credito_id int,
FOREIGN KEY (Cliente_Procedimento_id) REFERENCES Cliente_Procedimento(idCliente_Procedimento),
FOREIGN KEY(Cliente_id) REFERENCES Cliente(idCliente),
FOREIGN KEY(Cartao_Credito_id) REFERENCES Cartao_Credito(idCartao_Credito)
);



CREATE TABLE Agendamento (
idAgendamento int NOT NULL AUTO_INCREMENT PRIMARY KEY,
Data_Agendamento datetime NOT NULL,
Cliente_CorEsmalte_id int,
Orcamento_id int,
FOREIGN KEY (Cliente_CorEsmalte_id) REFERENCES Cliente_CorEsmalte(idCliente_CorEsmalte),
FOREIGN KEY (Orcamento_id) REFERENCES Orcamento(idOrcamento)
);



CREATE TABLE Balanco (
idBalanco int NOT NULL AUTO_INCREMENT PRIMARY KEY,
entrada_manual decimal(9,2),
saida_manual decimal(9,2),
dataEntrada date NOT NULL,
dataSaida date NOT NULL,
Orcamento_id int,
FOREIGN KEY (Orcamento_id) REFERENCES Orcamento(idOrcamento)
);



    INSERT INTO Assinatura (nome,valor,credito,descricao)
	VALUES ('Plano Bronze',68.00,88.00,'Pague 68 reais e usufrua 88 reais de Crédito Mensalmente'),
		   ('Plano Prata',192.00,240.00,'Pague 192 reais e usufrua 240 reais de Crédito Mensalmente'),
		   ('Plano Ouro',230.00,300.00,'Pague 230 reais e usufrua 300 reais de Crédito Mensalmente'),
		   ('Plano Diamante',350.00,440.00,'Pague 350 reais e usufrua 440 reais de Crédito Mensalmente');
         
         SELECT* FROM Assinatura;
            
	 INSERT INTO Pacotes (nome,valor,descricao,data_atendimento)
	 VALUES ('Pacote Essencial',190.00,'Pacote promocional com 4 serviços de pé e mão com data limite,Pagamento em 1X','2022-08-25'),
			('Pacote Chique',330.00,'Pacote promocional com 8 serviços de pé e mão com data limite, pagamento em 2X','2022-09-25'),
			('Pacote Poderosa',210.00,'Pacote promocional com 2 serviços de pé e mão e 2 serviços de esmaltação em gel,com data limite, pagamento em 2X','2022-09-25'),
			('Pacote Rainha',350.00,'Pacote promocional com 2 serviços de Alogamento de fibra de vidro 
			 2 serviços de Spa dos pés 2 serviços de esmaltação simples,com data limite, pagamento em 2X','2022-09-25');
        
          SELECT* FROM Pacotes;
        
	INSERT INTO Cliente (nome,endereco,cpf,rg,email,celular,senha,Pacote_id,Assinatura_id)
	VALUES ('Jô','Rua Vicente de Souza Junior','98778934532',null,'josiane.freitas@gmail.com','(11) 984237681','J5438O*',null,4),
		   ('Mônica','Av. Rodrigo de Freitas Junior',null,null,'monica_2022@outlook.com','(11) 967892678','M76548A',null,null),
		   ('Lidia','Rua. Cornélio de Arzão',null,null,'lidiamaria234@outlook.com','(11) 934678945','L67543A',null,null),
		   ('Rosana','Estrada. Dom João Nery','56790246789',null,'rosanadeandrade@gmail.com','(11  956789234','R87533A',null,null),
		   ('Renata','Rua Wilson Garambeu','67894592134',null,'renatadeandrade@outlook.com','(11) 974356782','R294765A',null,null),
		   ('Leticia','Rua. Manoel da silva bras',null,null,'leticiamaria124@outlook.com','(11) 945789265','L59347A',4,null);
           
           SELECT* FROM Cliente;
    
			
	 INSERT INTO Procedimento (nome,valor)
	 VALUES ('Pé',30.00),
			('Mão',30.00),
			('Pé e Mão',60.00),
			('Esmaltação simples',20.00),
			( 'Spa dos Pés',30.00),
			('Esmaltação em Gel',80.00),
			('Alongamento de fibra de vidro',150.00);
		
		 SELECT* FROM Procedimento;
 
	INSERT INTO Cliente_Procedimento (Cliente_id,Procedimento_id)
	VALUES (1,3),(2,6),(3,2),(4,7),(5,3),(5,6),(6,1);
    
	      SELECT* FROM Cliente_Procedimento;
          
	INSERT INTO CorEsmalte (CoresDisponiveis)
	VALUES ('Vermelho'),('Rosa'),('Verde'),('Nude'),('Preto'),('Ouro Nude'),('Melissa'),('Tamara'),('Rose'),
			 ('Escarlate'),('Carmim'),('Amarelo'),('Rubi'),('Condesa'),('Cristal'),('Lavanda'),('Love');
			
		  SELECT* FROM CorEsmalte;

	INSERT iNTO  Cliente_CorEsmalte (Cliente_id,CorEsmalte_id) 
	VALUES (1,3),(2,1),(3,11),(3,12),(4,null),(5,4),(5,7),(6,15),(6,8);
    
          SELECT* FROM Cliente_CorEsmalte;
   
	INSERT INTO Cartao_Credito (n_cartao,validade,cvv,Cliente_Procedimento_id)
	VALUES ('5271 8482 2343 7863','2028-12-31','347',6),
		   ('2756 8921 4673 2275','2029-08-29','768',2),
		   ('3567 9847 0215 5432','2030-11-30','561',7);
           
          SELECT* FROM Carta_Credito;
             
     INSERT INTO Orcamento (frete,desconto,Cliente_Procedimento_id,Cliente_id,Cartao_Credito_id)
     VALUES (15.00,null,1,1,null),
			(10.00,0.5,2,null,null),
			(10.00,0.5,3,null,null),
			(null,null,4,null,1),
			(null,null,5,null,2),
			(null,null,6,null,2),
			(10.00,null,7,6,3);
		
      
            SELECT* FROM Orcamento;
                
	 INSERT INTO Agendamento (Data_Agendamento,Cliente_CorEsmalte_id,Orcamento_id)
     VALUES  ('2022-08-02 10:00:00',1,1),
             ('2022-08-05 15:00:00',2,2),
             ('2022-08-10 16:00:00',3,3),
			 ('2022-08-10 16:00:00',4,3),
             ('2022-08-17 9:00:00',5,4),
			 ('2022-08-20 8:00:00',6,5),
             ('2022-08-20 8:00:00',7,5),
             ('2022-08-25 17:00:00',8,7),
             ('2022-08-25 17:00:00',9,7);
             
             SELECT* FROM Agendamento;
             
             
	  INSERT INTO Balanco (entrada_manual,saida_manual,dataEntrada,dataSaida,Orcamento_id)
      VALUES  (null,null,'2022-08-02',null,1),
              (null,null,'2022-08-05',null,2),
              (40.00,10.00,'2022-08-10','2022-08-10',3),
              (null,null,'2022-08-10',null,3),
              (null,null,'2022-08-17',null,4),
              (null,null,'2022-08-20',null,5),
              (20.00,null,'2022-08-20',null,5),
              (null,null,'2022-08-25',null,7),
              (null,null,'2022-08-25',null,7);
               
               
               
               
               USE Manicure;
               SELECT* FROM Balanco;
               SELECT* FROM Agendamento;
               SELECT* FROM Assinatura;
               SELECT* FROM Cartao_Credito;
               SELECT* FROM Cliente;
               SELECT* FROM Cliente_CorEsmalte;
               SELECT* FROM Cliente_Procedimento;
               SELECT* FROM CorEsmalte;
               SELECT* FROM Orcamento;
               SELECT* FROM Pacotes;
               SELECT* FROM Procedimento;
                
                
         













