/* ATIVIDADE 3 */


/* PARTE 1 */

/* APLICANDO MD5 NO CAMPO SENHA PARA AS CLIENTES */
UPDATE cliente SET senha= md5('RoseLene2023') WHERE idCliente = 1;
UPDATE cliente SET senha= md5('Rose4054') WHERE idCliente = 2;
UPDATE cliente SET senha= md5('J5438O*') WHERE idCliente = 3;
UPDATE cliente SET senha= md5('RoseLenM76548Ae2023') WHERE idCliente = 4;
UPDATE cliente SET senha= md5('L67543A') WHERE idCliente = 5;
UPDATE cliente SET senha= md5('R87533A') WHERE idCliente = 6;
UPDATE cliente SET senha= md5('R294765A') WHERE idCliente = 7;
UPDATE cliente SET senha= md5('L59347A') WHERE idCliente = 8;

/* CRIANDO USUARIOS E ATRIBUINDO PERMISSÕES E ROLES */

CREATE USER 'WesleiProgramador'@'localhost' IDENTIFIED BY '7654321';
CREATE ROLE 'Programador';
GRANT SELECT, INSERT, UPDATE 
ON manicure.* TO 'Programador';
GRANT 'Programador' TO 'WesleiProgramador'@'localhost';
SET DEFAULT ROLE 'Programador' TO 'WesleiProgramador'@'localhost';


/* TRIGGER CRIADA PARA NOVOS REGISTROS DE SENHA ENTRAREM COM MD5() */
DELIMITER // 
CREATE TRIGGER aplica_MD5 BEFORE INSERT 
ON cliente
FOR EACH ROW
BEGIN

SET NEW.senha = md5(NEW.senha);

END//
DELIMITER ;

/* CONFERENCIA */
INSERT INTO cliente (nome, endereco, cpf, rg, email, celular,senha, Pacote_id,Assinatura_id)
VALUES ('Rebeca','Rua.Ariel Brandao','34587610234',null,null,'11 956739212','DeusEterno',null,null);



/* PARTE 2 */

/* VIEW CRIADA PARA SABER TODOS OS AGENDAMENTOS FEITOS */
CREATE VIEW Agendamentos AS SELECT a.Data_Agendamento, o.frete+p.valor as ValorTotalComFrete, c.nome,co.CoresDisponiveis As CorEscolhida
FROM agendamento as a JOIN orcamento as o ON a.Orcamento_id=o.idOrcamento
JOIN cliente_procedimento as cp ON o.Cliente_Procedimento_id=cp.idCliente_Procedimento
JOIN procedimento as p ON cp.Procedimento_id=p.idProcedimento
JOIN cliente_coresmalte as cc ON a.Cliente_CorEsmalte_id=cc.idCliente_CorEsmalte
JOIN coresmalte as co ON cc.CorEsmalte_id=co.idCorEsmalte
JOIN cliente c ON cc.Cliente_id=c.idCliente;

/* CONFÊRENCIA */
SELECT* FROM Agendamentos;


/* ALTERANDO COLUNA NOME NA TABELA PROCEDIMENTO, POIS NÃO ACEITA CRIAÇÃO DE VIEW COM COLUNAS DE NOMES IGUAIS*/
ALTER TABLE pacotes
CHANGE nome nomeP VARCHAR(55) NOT NULL;

/* VIEW PARA SABER CLIENTES QUE ADERIRAM AOS PACOTES */
CREATE VIEW ClienteCPacote AS SELECT c.idCliente, c.nome, c.celular, p.nomeP, p.valor
FROM cliente as c JOIN pacotes as p ON C.Pacote_id=p.idPacote
WHERE c.Pacote_id IS NOT NULL;

/* TESTE */
SELECT* FROM ClienteCPacote;


/* ALTERANDO COLUNA NOME NA TABELA ASSINATURA, POIS NÃO ACEITA CRIAÇÃO DE VIEW COM COLUNAS DE NOMES IGUAIS */
ALTER TABLE Assinatura
CHANGE nome nomeA VARCHAR(55) NOT NULL;

/* VIEW CRIADA PARA SABER AS CLIENTES QUE ADERIRAM A ASSINATURA */
CREATE VIEW ClienteAssinatura AS SELECT c.idCliente, c.nome, c.celular, a.nomeA, a.valor
FROM cliente as c JOIN assinatura as a ON C.Assinatura_id=a.idAssinatura
WHERE c.Assinatura_id IS NOT NULL;

/* TESTE */
SELECT* FROM ClienteAssinatura;



/* Parte 3 */

/* FUNCTION QUE APLICA DESCONTO OU NÃO,
A CLIENTE TEM DESCONTO SE O PAGAMENTO FOR A VISTA (OU SEJA SE NÃO FOR NO CARTÃO) */

DELIMITER // 
CREATE FUNCTION desconto (idClientes INT)
RETURNS DECIMAL(11,2) DETERMINISTIC
BEGIN 
DECLARE Vfrete DECIMAL(9.2);
DECLARE valortotal DECIMAL(9.2);
DECLARE Valor DECIMAL(9.2);
DECLARE pgtCartao INT;

SELECT o.frete, p.valor,o.Cartao_Credito_id
INTO Vfrete, Valor,pgtCartao
FROM orcamento AS o JOIN cliente_procedimento AS cp ON o.Cliente_Procedimento_id=cp.idCliente_Procedimento
JOIN procedimento AS p ON cp.Procedimento_id=p.idProcedimento
JOIN cliente AS c ON cp.Cliente_id=c.idCliente
WHERE o.idOrcamento = idClientes;

IF pgtCartao IS NULL THEN
SET valortotal := Valor*0.95;
ELSE 
SET valortotal := Valor; 
END IF;

RETURN valortotal;
END //
DELIMITER ;
 
 
/* CONFÊRENCIA */
SELECT desconto(6) AS DescontoCalculado;
SELECT o.idOrcamento, o.Cartao_Credito_id, p.valor
FROM orcamento o JOIN cliente_procedimento cp ON o.Cliente_Procedimento_id=cp.idCliente_Procedimento
JOIN procedimento p ON cp.Procedimento_id=p.idProcedimento;



/* PARTE 4 */ 

/* INDEX COMPOSTA CRIADA PARA AJUDAR NA VIEW AGENDAMENTOS */

CREATE INDEX idx_orcamento ON agendamento(Orcamento_id);
SHOW INDEX FROM agendamento;
CREATE INDEX idx_esmalte ON agendamento(Cliente_Coresmalte_id);

/* TESTE */
EXPLAIN SELECT* FROM Agendamentos;






