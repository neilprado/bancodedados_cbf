CREATE DATABASE bd_cbfProjeto
GO

USE bd_cbfProjeto
GO

CREATE TABLE Confederacao
(
	nome varchar(5)								NOT NULL,
	presidente varchar(30)						NOT NULL,
	endereco_rua varchar(45)					NOT NULL,
	endereco_bairro varchar(45)					NOT NULL,
	endereco_cidade varchar(45)					NOT NULL,
	endereco_estado varchar (2)					NOT NULL,
	CONSTRAINT PK_nome							PRIMARY KEY (nome),
	CONSTRAINT AK_conf_nome						UNIQUE (nome),
	CONSTRAINT CK_Conf_estado					CHECK (LEN(endereco_estado)=2)
) 

CREATE TABLE Telefone_Confederacao
(
	nome_confederacao varchar(5)				NOT NULL,
	numero_confederacao varchar(15)				NOT NULL,
	CONSTRAINT PK_numero_telefoneConf			PRIMARY KEY (nome_confederacao, numero_confederacao),
	CONSTRAINT FK_numero_telConf_Conf			FOREIGN KEY (nome_confederacao) REFERENCES Confederacao,
	CONSTRAINT CK_numeroTelConf					CHECK(numero_confederacao LIKE '([0-9][0-9])[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')
)

CREATE TABLE Arbitro
(
	matricula smallint IDENTITY					NOT NULL,
	nome varchar(45)							NOT NULL,
	nome_confederacao varchar(5)				NOT NULL,
	dtnasc date									NOT NULL,
	subs_matricula smallint						NOT NULL,
	CONSTRAINT PK_matricula_arbitro				PRIMARY KEY(matricula),
	CONSTRAINT FK_nome_confederacao				FOREIGN KEY(nome_confederacao) REFERENCES Confederacao,
	CONSTRAINT FK_matricula_arbitro_sub			FOREIGN KEY(matricula) REFERENCES Arbitro
)

CREATE TABLE Clube
(
	cnpj smallint								NOT NULL,
	nome varchar(30)							NOT NULL,
	estadio varchar(30)							NULL,
	presidente varchar(30)						NOT NULL,
	endereco_rua varchar(45)					NOT NULL,
	endereco_bairro varchar(45)					NOT NULL,
	endereco_cidade varchar(45)					NOT NULL,
	endereco_estado varchar (2)					NOT NULL,
	conf_nome varchar(5)						NOT NULL
	CONSTRAINT PK_cnpj							PRIMARY KEY (cnpj),
	CONSTRAINT CK_Clube_estado					CHECK (LEN(endereco_estado)=2),
	CONSTRAINT FK_Conf_nome						FOREIGN KEY (conf_nome) REFERENCES Confederacao
)

CREATE TABLE Telefone_Clube
(
	clube_cnpj smallint							NOT NULL,
	numero varchar(15)							NOT NULL,
	CONSTRAINT PK_clube_cnpj					PRIMARY KEY(clube_cnpj, numero),
	CONSTRAINT FK_clube_cnpj					FOREIGN KEY(clube_cnpj) REFERENCES Clube,
	CONSTRAINT CK_TelefoneClube					CHECK(numero LIKE '([0-9][0-9])[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')
)

CREATE TABLE Torcedor
(
	codtorcedor smallint IDENTITY				NOT NULL,
	nome varchar(60)							NOT NULL,
	cpf	varchar(12)								NOT NULL,
	rg  varchar(15)								NOT NULL,
	clube_cnpj smallint							NOT NULL,
	CONSTRAINT PK_codtorcedor					PRIMARY KEY (codtorcedor),
	CONSTRAINT AK_torcedor_cpf					UNIQUE(cpf),
	CONSTRAINT AK_torcedor_rg					UNIQUE(rg),
	CONSTRAINT CK_torcedor_cpf					CHECK(cpf LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]-[0-9][0-9]'),
	CONSTRAINT FK_torcedor_clube_cnpj			FOREIGN KEY (clube_cnpj) REFERENCES Clube
)

CREATE TABLE Profissional
(
	matricula smallint							NOT NULL,
	nome varchar(45)							NOT NULL,
	endereco_rua varchar(45)					NOT NULL,
	endereco_bairro varchar(45)					NOT NULL,
	endereco_cidade varchar(30)					NOT NULL,
	endereco_estado varchar (2)					NOT NULL,
	clube_cnpj smallint							NOT NULL,
	CONSTRAINT PK_matricula						PRIMARY KEY (matricula),
	CONSTRAINT CK_Profissional_estado			CHECK (LEN(endereco_estado)=2),
	CONSTRAINT FK_profissional_clube_cnpj		FOREIGN KEY (clube_cnpj) REFERENCES Clube
)

CREATE TABLE Telefone_Profissional
(
	matricula_profissional smallint				NOT NULL,
	numero varchar(15)							NOT NULL,
	CONSTRAINT PK_telefone_profissional			PRIMARY KEY(matricula_profissional, numero),
	CONSTRAINT FK_telefone_profissional			FOREIGN KEY(matricula_profissional) REFERENCES Profissional,
	CONSTRAINT CK_telefone_profissional_numero	CHECK(numero LIKE '([0-9][0-9])[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')
)

CREATE TABLE Medico
(
	matricula_profissional smallint				NOT NULL,
	crm varchar(10)								NOT NULL,
	especialidade varchar(20)					NOT NULL,
	CONSTRAINT PK_matricula_medico				PRIMARY KEY(matricula_profissional),
	CONSTRAINT FK_matricula_medico				FOREIGN KEY(matricula_profissional) REFERENCES Profissional,
	CONSTRAINT AK_medico_crm					UNIQUE(crm)
)

CREATE TABLE Tecnico
(
	matricula_profissional smallint				NOT NULL,
	licenca varchar(5)							NOT NULL,
	CONSTRAINT PK_matricula_tecnico				PRIMARY KEY(matricula_profissional),
	CONSTRAINT FK_matricula_tecnico				FOREIGN KEY(matricula_profissional) REFERENCES Profissional,
	CONSTRAINT CK_técnico_licenca				CHECK(LEN(licenca)>=2)
)

CREATE TABLE Fisioterapeuta
(
	matricula_profissional smallint				NOT NULL,
	crf varchar(10)								NOT NULL,
	CONSTRAINT PK_matricula_fisio				PRIMARY KEY(matricula_profissional),
	CONSTRAINT FK_matricula_fisio				FOREIGN KEY(matricula_profissional) REFERENCES Profissional,
	CONSTRAINT AK_fisio_crf						UNIQUE(crf)
)


CREATE TABLE Jogador
(
	cpf varchar(12)								NOT NULL,
	nome varchar (45)							NOT NULL,
	dtnascimento date							NOT NULL,
	altura decimal(4, 2)						NOT NULL,
	endereco_rua varchar(45)					NOT NULL,
	endereco_bairro varchar(20)					NOT NULL,
	endereco_cidade varchar(30)					NOT NULL,
	endereco_estado varchar (2)					NULL,
	pais varchar(20)							NOT NULL,
	email varchar(60)							NULL,
	CONSTRAINT PK_JogadorCPF					PRIMARY KEY (cpf),
	CONSTRAINT CK_Jogador_estado				CHECK (LEN(endereco_estado)=2),
	CONSTRAINT CK_jogador_cpf					CHECK(cpf LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]-[0-9][0-9]'),
	CONSTRAINT CK_altura_jogador				CHECK((altura) > 1.50)
)

CREATE TABLE Agente
(
	matricula smallint							NOT NULL,
	nome varchar(60)							NOT NULL,
	CONSTRAINT PK_matriculaAgente				PRIMARY KEY(matricula)
)

CREATE TABLE Telefone_Agente
(
	telefone_agente smallint					NOT NULL,
	numero varchar(15)							NOT NULL,
	CONSTRAINT PK_telefone_agente_contato		PRIMARY KEY(telefone_agente, numero),
	CONSTRAINT FK_telefone_agente				FOREIGN KEY(telefone_agente) REFERENCES Agente,
	CONSTRAINT CK_Telefone_Agente				CHECK(numero LIKE '([0-9][0-9])[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')
)

CREATE TABLE Telefone_Jogador
(
	jogador_telefone varchar(12)				NOT NULL,
	numero varchar(15)							NOT NULL,
	CONSTRAINT PK_jogador_telefone				PRIMARY KEY(jogador_telefone, numero),
	CONSTRAINT FK_telefone_jogador_res			FOREIGN KEY(jogador_telefone) REFERENCES Jogador,
	CONSTRAINT CK_Telefone_Jogador				CHECK(numero LIKE '([0-9][0-9])[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')
)

CREATE TABLE Dependente
(
	codDependente smallint IDENTITY				NOT NULL,
	nome varchar(45)							NOT NULL,
	telefone varchar(15)						NOT NULL,
	rg varchar(15)								NOT NULL,
	cpf varchar (12)							NOT NULL,
	descricao varchar(60)						NULL,
	jogador_cpf varchar (12)					NOT NULL,
	CONSTRAINT PK_codDependente					PRIMARY KEY (codDependente, jogador_cpf),
	CONSTRAINT FK_jogador_cpf					FOREIGN KEY (jogador_cpf) REFERENCES Jogador,
	CONSTRAINT AK_dependente_cpf				UNIQUE(cpf),
	CONSTRAINT AK_dependente_rg					UNIQUE(rg),
	CONSTRAINT CK_Dependente_telefone			CHECK(telefone LIKE '([0-9][0-9])[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')
)

CREATE TABLE Contrata
(
	cnpj_clube smallint							NOT NULL,
	jogador_cpf varchar(12)						NOT NULL,
	dtinicio date								NOT NULL,
	dtfinal date								NOT NULL,
	salario money								NOT NULL,
	CONSTRAINT PK_cnpj_contrato_clube			PRIMARY KEY(cnpj_clube, jogador_cpf),
	CONSTRAINT FK_cnpj_contrato_clube			FOREIGN KEY(cnpj_clube) REFERENCES Clube,
	CONSTRAINT FK_jogador_contrato_cpf			FOREIGN KEY(jogador_cpf) REFERENCES Jogador
)

CREATE TABLE Contrato
(
	contrata_clube smallint						NOT NULL,
	contrata_jogador_cpf varchar(12)			NOT NULL,
	agente_matricula smallint					NOT NULL,
	CONSTRAINT PK_contrata_clube				PRIMARY KEY(contrata_clube, contrata_jogador_cpf,agente_matricula),
	CONSTRAINT FK_contrata_clube				FOREIGN KEY(contrata_clube) REFERENCES Clube,
	CONSTRAINT FK_contrata_jogador_cpf			FOREIGN KEY(contrata_jogador_cpf) REFERENCES Jogador,
	CONSTRAINT FK_agente_matricula				FOREIGN KEY(agente_matricula) REFERENCES Agente
)

CREATE TABLE Campeonato 
(
	codCampeonato smallint IDENTITY				NOT NULL,
	numRodadas smallint							NOT NULL,
	nome varchar(25)							NOT NULL,
	premiacao money								NOT NULL,
	dtinicio date								NOT NULL,
	dtfinal date								NOT NULL,
	participantes smallint						NOT NULL,
	confederacao_nome varchar(5)				NOT NULL,
	CONSTRAINT PK_cod_campeonato				PRIMARY KEY(codCampeonato),
	CONSTRAINT FK_conf_nomeCampeonato			FOREIGN KEY(confederacao_nome) REFERENCES Confederacao
)

CREATE TABLE Patrocinio
(
	codPatrocinador smallint IDENTITY			NOT NULL,
	nome varchar(30)							NOT NULL,
	cnpj smallint								NOT NULL,
	valor money									NULL,
	CONSTRAINT PK_cod_patrocinador				PRIMARY KEY(codPatrocinador),
	CONSTRAINT AK_patrocinador_cnpj				UNIQUE(cnpj)
)

CREATE TABLE Telefone_Patrocinador
(
	telPatrocinador smallint					NOT NULL,
	numero varchar(15)							NOT NULL,
	CONSTRAINT PK_telefone_patrocinador			PRIMARY KEY(telPatrocinador, numero),
	CONSTRAINT FK_telefone_codPatrocinador		FOREIGN KEY(telPatrocinador) REFERENCES Patrocinio,
	CONSTRAINT CK_numeroPatrocinador			CHECK(numero LIKE '([0-9][0-9])[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')
)

CREATE TABLE Emissora
(
	cnpj smallint								NOT NULL,
	nome varchar(45)							NOT NULL,
	endereco_rua varchar(45)					NOT NULL,
	endereco_bairro varchar(20)					NOT NULL,
	endereco_cidade varchar(30)					NOT NULL,
	endereco_estado varchar (2)					NOT NULL,
	CONSTRAINT PK_cnpjEmissora					PRIMARY KEY(cnpj),
	CONSTRAINT CK_emissora_estado				CHECK (LEN(endereco_estado)=2)
)

CREATE TABLE Telefone_Emissora
(
	emissora_telefone smallint					NOT NULL,
	numero varchar(15)							NOT NULL,
	CONSTRAINT PK_emissora_telefone				PRIMARY KEY(emissora_telefone, numero),
	CONSTRAINT FK_telefone_emissora				FOREIGN KEY(emissora_telefone) REFERENCES Emissora,
	CONSTRAINT CK_TelefoneEmissora				CHECK(numero LIKE '([0-9][0-9])[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')
)

CREATE TABLE CampTemPatrocinio
(
	codCampeonato smallint						NOT NULL,
	codPatrocinador smallint					NOT NULL,
	cnpj_emissora smallint						NOT NULL,
	CONSTRAINT PK_codCampPatr					PRIMARY KEY (codCampeonato, codPatrocinador, cnpj_emissora),
	CONSTRAINT FK_codCampeonato					FOREIGN KEY (codCampeonato) REFERENCES Campeonato,			
	CONSTRAINT FK_codPatrocinador				FOREIGN KEY (codPatrocinador) REFERENCES Patrocinio,
	CONSTRAINT FK_cnpj_emissora					FOREIGN KEY (cnpj_emissora) REFERENCES Emissora
)

SET DATEFORMAT 'DMY'

/* Inserção de valores na tabela CONFEDERAÇÃO */
INSERT INTO Confederacao VALUES ('FERJ', 'Rubens Lopes', 'Avenida das Américas, 219', 'Barra da Tijuca', 'Rio de Janeiro', 'RJ')
INSERT INTO Confederacao VALUES ('FPF', 'Reinaldo Carneiro Bastos', 'Avenida Paulista, 2210', 'Bela Vista', 'São Paulo', 'SP')
INSERT INTO Confederacao VALUES ('FMF', 'Castellar Modesto Neto', 'Rua Piauí, 1977', 'Funcionários', 'Belo Horizonte', 'MG')
INSERT INTO Confederacao VALUES ('FGF', 'Francisco Novelletto Neto', 'Avenida Ipiranga, 10', 'Praia de Belas', 'Porto Alegre', 'RS')
INSERT INTO Confederacao VALUES ('FCF', 'Rubens Angelotti', 'Sexta Avenida, 2102', 'Municípios', 'Balneário Camboriú', 'SC')
INSERT INTO Confederacao VALUES ('FPE', 'Evandro Carvalho', 'Rua Dom Bôsco, 871', 'Boa Vista', 'Recife', 'PE')
INSERT INTO Confederacao VALUES ('FPR', 'Hélio Pereira Cury', 'Avenida República Argentina, 2153', 'Portão', 'Curitiba', 'PR')

/* Inserção de valores na tabela Telefone_Confederação */ 
INSERT INTO Telefone_Confederacao VALUES ('FERJ', '(21)7898-6787')
INSERT INTO Telefone_Confederacao VALUES ('FPF', '(11)7893-2770')
INSERT INTO Telefone_Confederacao VALUES ('FMF', '(31)2732-3811')
INSERT INTO Telefone_Confederacao VALUES ('FGF', '(51)2378-2221')
INSERT INTO Telefone_Confederacao VALUES ('FPR', '(41)4854-7331')
INSERT INTO Telefone_Confederacao VALUES ('FCF', '(48)3049-8341')
INSERT INTO Telefone_Confederacao VALUES ('FPE', '(81)2732-8110')

/* Inserção de valores na tabela ÁRBITRO */

INSERT INTO Arbitro VALUES ('Bruno Mota Correia', 'FERJ', '22/04/1982', 5)
INSERT INTO Arbitro VALUES ('Anderson Costa de Farias', 'FPE', '20/04/1973', 7)
INSERT INTO Arbitro VALUES ('Rafael Acácio Toledo', 'FPF', '21/08/1984', 6)
INSERT INTO Arbitro VALUES ('Raphael Claus', 'FPF', '08/03/1971', 3)
INSERT INTO Arbitro VALUES ('Grazianni Maciel Rocha', 'FERJ', '10/12/1981', 1)
INSERT INTO Arbitro VALUES ('Rogerio Fernando Alves Jr.', 'FPF', '08/07/1997', 4)
INSERT INTO Arbitro VALUES ('Anderson Daronco', 'FPE', '05/01/1981', 2)
INSERT INTO Arbitro VALUES ('Eleno Gonzalez Todeschini', 'FGF', '18/02/1981', 9)
INSERT INTO Arbitro VALUES ('Vinícius Gomes do Amaral', 'FGF', '02/07/1987', 8)
INSERT INTO Arbitro VALUES ('Fabio Filipus', 'FPR', '15/12/1978', 14)
INSERT INTO Arbitro VALUES ('Pierluigi Collina', 'FCF', '22/09/1967', 12)
INSERT INTO Arbitro VALUES ('Lubos Michál', 'FCF', '12/12/1983', 11)
INSERT INTO Arbitro VALUES ('Kridens Meta', 'FMF', '01/05/1977', 10)
INSERT INTO Arbitro VALUES ('Petr Brabec', 'FMF', '21/09/1987', 13)

/* Inserção de valores na tabela CLUBE */

INSERT INTO Clube VALUES (1, 'Flamengo', 'Maracanã', 'Eduardo Bandeira de Melo', 'Av. Borges de Medeiros, 997', 'Lagoa', 'Rio de Janeiro', 'RJ', 'FERJ')
INSERT INTO Clube VALUES (2, 'Vasco da Gama', 'São Januário', 'Alexandre Campello', 'R. General Almério de Moura', 'Vasco da Gama', 'Rio de Janeiro', 'RJ', 'FERJ')
INSERT INTO Clube VALUES (3, 'Fluminense', 'Maracanã', 'Pedro Abad', 'Rua Álvaro Chaves, 41', 'Laranjeiras', 'Rio de Janeiro', 'RJ', 'FERJ')
INSERT INTO Clube VALUES (4, 'Botafogo', 'Nilton Santos', 'Nelson Mufarrej', 'Av. Venceslau Brás, 72', 'Botafogo', 'Rio de Janeiro', 'RJ', 'FERJ')
INSERT INTO Clube VALUES (5, 'Corinthians', 'Arena Corinthians', 'Andrés Sánchez', 'Av. Miguel Ignácio Curi, 111', 'Artur Alvim', 'São Paulo', 'SP', 'FPF')
INSERT INTO Clube VALUES (6, 'Palmeiras', 'Allianz Parque', 'Maurício Galiotte', 'Rua Palestra Itália, 214', 'Perdizes', 'São Paulo', 'SP', 'FPF')
INSERT INTO Clube VALUES (7, 'São Paulo', 'Morumbi', 'Carlos Augusto de B. e Silva', 'Pç. Roberto Gomes Pedrosa, 1', 'Morumbi', 'São Paulo', 'SP', 'FPF')
INSERT INTO Clube VALUES (8, 'Santos FC', 'Vila Belmiro', 'José Carlos Peres', 'Rua Princesa Isabel, 0', 'Vila Belmiro', 'Santos', 'SP', 'FPF')
INSERT INTO Clube VALUES (9, 'Cruzeiro', 'Mineirão', 'Wagner Pires de Sá', 'Rua Timbiras, 2903', 'Barro Preto', 'Belo Horizonte', 'MG', 'FMF')
INSERT INTO Clube VALUES (10, 'Atlético Mineiro', 'Mineirão', 'Sérgio Sette Câmara', 'Rodovia MG 424, Km 21', 'Jardim da Glória', 'Vespasiano', 'MG', 'FMF')
INSERT INTO Clube VALUES (11, 'América Mineiro', 'Independência', 'Alencar da Silveira Jr.', 'Rua Mantena, 80', 'Ouro Preto', 'Belo Horizonte', 'MG', 'FMF')
INSERT INTO Clube VALUES (12, 'Paraná Clube', 'Vila Capanema', 'Leonardo de Oliveira', 'Av. Presidente Kennedy, 2377', 'Guaíra', 'Curitiba', 'PR', 'FPR')
INSERT INTO Clube VALUES (13, 'Coritiba FC', 'Couto Pereira', 'Samir Namur', 'R. Ubaldino do Amaral, 37', 'Alto da Glória', 'Curitiba', 'PR', 'FPR')
INSERT INTO Clube VALUES (14, 'Atlético Paranaense', 'Arena da Baixada', 'Luiz Sallim Emed', 'R. Dep. Valdomiro Pedroso, 676', 'Novo Mundo', 'Curitiba', 'PR', 'FPR')
INSERT INTO Clube VALUES (15, 'Grêmio FBPA', 'Arena do Grêmio', 'Romildo Bolzan', 'Av. Padre Leopoldo Brentano, 110', 'Humaitá', 'Porto Alegre', 'RS', 'FGF')
INSERT INTO Clube VALUES (16, 'Internacional', 'Beira Rio', 'Marcelo Feijó de Medeiros', 'Av. Padre Cacique, 891', 'Praia de Belas', 'Porto Alegre', 'RS', 'FGF')
INSERT INTO Clube VALUES (17, 'Chapecoense', 'Arena Condá', 'Plínio David de Nes Filho', 'Rodovia SC-157, 28978', 'Seminário', 'Chapecó', 'SC', 'FCF')
INSERT INTO Clube VALUES (18, 'Figueirense', 'Orlando Scarpelli', 'Cláudio César Varnalha', 'Rua Humaitá', 'Estreito', 'Florianópolis', 'SC', 'FCF')
INSERT INTO Clube VALUES (19, 'Sport', 'Ilha do Retiro', 'Arnaldo Barros', 'Av. Sport Clube do Recife, 0', 'Ilha do Retiro', 'Recife', 'PE', 'FPE')
INSERT INTO Clube VALUES (20, 'Santa Cruz', 'Arruda', 'Constantino Júnior', 'Av. Beberibe, 1285', 'Arruda', 'Recife', 'PE', 'FPE')


/* Inserção na Tabela TELEFONE_CLUBE */
INSERT INTO Telefone_Clube VALUES (1, '(21)8234-1244')
INSERT INTO Telefone_Clube VALUES (1, '(21)2391-8231')
INSERT INTO Telefone_Clube VALUES (2, '(21)3214-9527')
INSERT INTO Telefone_Clube VALUES (2, '(21)3214-9528')
INSERT INTO Telefone_Clube VALUES (3, '(21)5218-9128')
INSERT INTO Telefone_Clube VALUES (3, '(21)3719-5271')
INSERT INTO Telefone_Clube VALUES (4, '(21)8219-0013')
INSERT INTO Telefone_Clube VALUES (5, '(11)8229-1938')
INSERT INTO Telefone_Clube VALUES (5, '(11)8888-1111')
INSERT INTO Telefone_Clube VALUES (6, '(11)4212-0182')
INSERT INTO Telefone_Clube VALUES (6, '(11)5241-9281')
INSERT INTO Telefone_Clube VALUES (7, '(11)2181-9182')
INSERT INTO Telefone_Clube VALUES (7, '(11)8371-6271')
INSERT INTO Telefone_Clube VALUES (8, '(13)3812-1085')
INSERT INTO Telefone_Clube VALUES (9, '(31)2819-8819')
INSERT INTO Telefone_Clube VALUES (9, '(31)8210-1891')
INSERT INTO Telefone_Clube VALUES (10, '(31)7281-1911')
INSERT INTO Telefone_Clube VALUES (11, '(31)2782-0032')
INSERT INTO Telefone_Clube VALUES (12, '(41)7361-9921')
INSERT INTO Telefone_Clube VALUES (12, '(41)2781-3192')
INSERT INTO Telefone_Clube VALUES (13, '(41)2819-5514')
INSERT INTO Telefone_Clube VALUES (14, '(41)8217-5590')
INSERT INTO Telefone_Clube VALUES (15, '(51)7319-0018')
INSERT INTO Telefone_Clube VALUES (15, '(51)7281-2219')
INSERT INTO Telefone_Clube VALUES (16, '(51)8172-9911')
INSERT INTO Telefone_Clube VALUES (16, '(51)6371-2119')
INSERT INTO Telefone_Clube VALUES (17, '(48)2281-5511')
INSERT INTO Telefone_Clube VALUES (18, '(48)4498-3336')
INSERT INTO Telefone_Clube VALUES (19, '(81)7381-2828')
INSERT INTO Telefone_Clube VALUES (19, '(81)2810-4444')
INSERT INTO Telefone_Clube VALUES (20, '(81)3119-4921')

/*Inserção de valores na tabela Torcedor */
INSERT INTO Torcedor VALUES ('Chafundifórnio da Silva', '028918228-23', '1829221 SSP-RJ', 1)
INSERT INTO Torcedor VALUES ('Raul Jimenez da Cruz', '239291310-31', '21819201 SSP-RJ', 1)
INSERT INTO Torcedor VALUES ('Bruna da Cruz Vieira', '837193011-77', '3298372 SSP-RJ', 2)
INSERT INTO Torcedor VALUES ('José Luiz Melo', '372983722-09', '2783298 SSP-ES', 3)
INSERT INTO Torcedor VALUES ('Piotr Nikolaievich', '123456789-82', '23723821 SSP-SP', 3)
INSERT INTO Torcedor VALUES ('Marko Polansky', '892809321-70', '938133 SSP-RS', 3)
INSERT INTO Torcedor VALUES ('Bruna da Cruz Vieira', '837123018-77', '3298372 SSP-RN', 4)
INSERT INTO Torcedor VALUES ('Roman Polansky', '928732389-00', '23179837 SSP-RJ', 4)
INSERT INTO Torcedor VALUES ('Valo Yössä', '273982135-11', '3237982 SSP-SP', 5)
INSERT INTO Torcedor VALUES ('Nicholas Sparks', '239823128-04', '28397287 SSP-SP', 6)
INSERT INTO Torcedor VALUES ('Eddard Stark', '290832091-62', '27398123 SSP-SP', 6)
INSERT INTO Torcedor VALUES ('Jamie Lannister', '237928312-36', '28397257 SSP-SP', 7)
INSERT INTO Torcedor VALUES ('Piotr Emelianenko', '181271918-92', '2837222 SSP-PB', 8)
INSERT INTO Torcedor VALUES ('Justin Timberlake', '212798113-99', '2387873 SSP-MG', 9)
INSERT INTO Torcedor VALUES ('Harry Potter', '372893791-02', '8273892 SSP-MS', 10)
INSERT INTO Torcedor VALUES ('Peter Crouch', '372839711-36', '323822 SSP-MG', 10)
INSERT INTO Torcedor VALUES ('Bruce Wayne', '382732873-12', '2932823 SSP-MG', 11)
INSERT INTO Torcedor VALUES ('Heinrich Himmler', '372937237-63', '2739821 SSP-PR', 12)
INSERT INTO Torcedor VALUES ('Margaret Thatcher', '323782282-91', '2837238 SSP-PR', 12)
INSERT INTO Torcedor VALUES ('Paulo Bento', '232987389-23', '2837211 SSP-PR', 13)
INSERT INTO Torcedor VALUES ('Pedro Henrique Souza', '872893178-73', '1234567 SSP-PR', 14)
INSERT INTO Torcedor VALUES ('Neil Armstrong', '237298722-91', '7293729 SSP-RS', 15)
INSERT INTO Torcedor VALUES ('Oleg Ostapenko', '327932922-10', '2873278 SSP-PB', 16)
INSERT INTO Torcedor VALUES ('Tai Chi Chuan', '229872387-19', '2329038 SSP-RN', 17)
INSERT INTO Torcedor VALUES ('Kurt Wagner', '237978231-71', '3273823 SSP-SC', 18)
INSERT INTO Torcedor VALUES ('Emma Frost', '872893712-28', '8237287 SSP-PE', 19)
INSERT INTO Torcedor VALUES ('Harley Quinn', '238972311-72', '233893 SSP-PE', 20)

/* Inserção de Valores na tabela Profissional */
INSERT INTO Profissional VALUES (1, 'Aleksei Mammukov', 'Rua Jacó Schneider, 373', 'Taquara', 'Rio de Janeiro', 'RJ', 1)
INSERT INTO Profissional VALUES (2, 'Anthony Marcos Pereira', 'Rua Emb. Joaquim de Souza Leão, 473', 'Portuguesa', 'Rio de Janeiro', 'RJ', 1)
INSERT INTO Profissional VALUES (3, 'Joaquim Matheus Pietro Araújo', 'Rua Dois, 691', 'Campo Grande', 'Rio de Janeiro', 'RJ', 1)
INSERT INTO Profissional VALUES (4, 'Alexandre Lorenzo Calebe Almeida', 'Travessa Enora, 147', 'Acari', 'Rio de Janeiro', 'RJ', 1)
INSERT INTO Profissional VALUES (5, 'Joaquim Cauê Souza', 'Beco Central, 949', 'Bangu', 'Rio de Janeiro', 'RJ', 1)
INSERT INTO Profissional VALUES (6, 'Gabriel Renan dos Santos', 'Rua Nelson da Fonseca, 240', 'Senador Camará', 'Rio de Janeiro', 'RJ', 2)
INSERT INTO Profissional VALUES (7, 'Benício Iago Carvalho', 'Rua Alexandrina, 288', 'Santa Cruz', 'Rio de Janeiro', 'RJ', 2)
INSERT INTO Profissional VALUES (8, 'Alice Juliana Castro', 'Rua Álvaro e Albuquerque, 912', 'Parque Anchieta', 'Rio de Janeiro', 'RJ', 2)
INSERT INTO Profissional VALUES (9, 'Fernando Nascimento', 'Travessa Barros Sobrinho, 447', 'Santo Cristo', 'Rio de Janeiro', 'RJ', 2)
INSERT INTO Profissional VALUES (10, 'Raul Fernando Castro', 'Beco E, 423', 'Campo Grande', 'Rio de Janeiro', 'RJ', 3)
INSERT INTO Profissional VALUES (11, 'Renan Luan Cavalcanti', 'Rua da Graça, 673', 'Campo Grande', 'Rio de Janeiro', 'RJ', 3)
INSERT INTO Profissional VALUES (12, 'Yuri Raul Cardoso', 'Travessa Colorado, 563', 'Bangu', 'Rio de Janeiro', 'RJ', 3)
INSERT INTO Profissional VALUES (13, 'Luan Carvalho', 'Rua Quinze de Agosto, 866', 'Jacaré', 'Rio de Janeiro', 'RJ', 3)
INSERT INTO Profissional VALUES (14, 'Hugo Kaique Barbosa', 'Avenida Rio Branco 128, 515', 'Centro', 'Rio de Janeiro', 'RJ', 4)
INSERT INTO Profissional VALUES (15, 'Lucas Renan Alves', 'Rua Jorge de Lima, 746', 'Jardim Guanabara', 'Rio de Janeiro', 'RJ', 4)
INSERT INTO Profissional VALUES (16, 'Kevin Caio Cardoso', 'Rua Monsenhor Castelo Branco, 171', 'Jardim América', 'Rio de Janeiro', 'RJ', 4)
INSERT INTO Profissional VALUES (17, 'Theo Luan Martins', 'Rua Iguaba Grande, 711', 'Pavuna', 'Rio de Janeiro', 'RJ', 4)
INSERT INTO Profissional VALUES (18, 'Igor Fernando Barbosa', 'Rua Guanambi, 959', 'Vila Bozzini', 'São Paulo', 'SP', 5)
INSERT INTO Profissional VALUES (19, 'Henry Lucca Cavalcanti', 'Avenida Vila Ema, 164', 'Vila Ema', 'São Paulo', 'SP', 5)
INSERT INTO Profissional VALUES (20, 'Marcos Vinicius Barbosa', 'Rua Itacarambi, 398', 'Vila Zelina', 'São Paulo', 'SP', 5)
INSERT INTO Profissional VALUES (21, 'João Caio Felipe Barbosa', 'Rua Verbo Divino 1400, 707', 'Chácara Santo Antônio', 'São Paulo', 'SP', 6)
INSERT INTO Profissional VALUES (22, 'Fernando Thales de Paula', 'Rua Benedito Raposo, 121', 'Vila Nova Curuçá', 'São Paulo', 'SP', 6)
INSERT INTO Profissional VALUES (23, 'Paulo Anthony Costa', 'Rua Paolo Porpora, 904', 'Parque Independência', 'São Paulo', 'SP', 6)
INSERT INTO Profissional VALUES (24, 'Marcos Vinicius Castro', 'Tv. Rio Pericumã, 722', 'Jardim Varginha', 'São Paulo', 'SP', 7)
INSERT INTO Profissional VALUES (25, 'Fernando Leonardo Rocha', 'Av. Francisco Glicério, 149', 'José Menino', 'Santos', 'SP', 8)
INSERT INTO Profissional VALUES (26, 'Rafael Cauê Carvalho', 'Rua Capitão João Salermo, 108', 'Ponta da Praia', 'Santos', 'SP', 8)
INSERT INTO Profissional VALUES (27, 'Benjamin Pedro Mendes', 'Rua Visconde de Taunay, 463', 'Santa Mônica', 'Belo Horizonte', 'MG', 9)
INSERT INTO Profissional VALUES (28, 'Pedro Henrique Pinto', 'Rua Ernesto Austin, 563', 'Boa Vista', 'Belo Horizonte', 'MG', 9)
INSERT INTO Profissional VALUES (29, 'Pedro Eduardo Martins', 'Rua Salomão Rodrigues da Silva, 796', 'Paquetá', 'Belo Horizonte', 'MG', 11)
INSERT INTO Profissional VALUES (30, 'Bryan Mendes', 'Rua Santo Antônio de Lisboa, 126', 'Venda Nova', 'Belo Horizonte', 'MG', 11)
INSERT INTO Profissional VALUES (31, 'Kevin Freitas', 'Rua Santo Antônio de Lisboa, 126', 'Venda Nova', 'Curitiba', 'PR', 12)
INSERT INTO Profissional VALUES (32, 'Ryan Enrico Cardoso', 'Rua Boanerges M. Sobrinho, 732', 'Tatuquara', 'Curitiba', 'PR', 12)
INSERT INTO Profissional VALUES (33, 'Breno Fernandes', 'Travessa Itamar Cortes, 543', 'Butiatuvinha', 'Curitiba', 'PR', 12)
INSERT INTO Profissional VALUES (34, 'João Guilherme Freitas', 'Rua José Francisco Pereira, 126', 'Campo de Santana', 'Curitiba', 'PR', 13)
INSERT INTO Profissional VALUES (35, 'Lucca Martins', 'Rua Mateus Leme, 295', 'São Francisco', 'Curitiba', 'PR', 13)
INSERT INTO Profissional VALUES (36, 'Alexandre Henrique de Paula', 'Rua Luiz Muraro, 821', 'Abranches', 'Curitiba', 'PR', 14)
INSERT INTO Profissional VALUES (37, 'André Pietro Ribeiro', 'Acesso A Um, 858', 'Mário Quintana', 'Porto Alegre', 'RS', 15)
INSERT INTO Profissional VALUES (38, 'Thiago Fernandes', 'Rua Gervázio Braga Pinheiro, 702', 'Lomba do Pinheiro', 'Porto Alegre', 'RS', 15)
INSERT INTO Profissional VALUES (39, 'Diego Emanuel Souza', 'Rua Antônio Morandini, 315', 'SAIC', 'Porto Alegre', 'RS', 15)
INSERT INTO Profissional VALUES (40, 'Julio Bruno Fernandes', 'Rua Corrêa de Mello, 191', 'Sarandi', 'Chapecó', 'SC', 17)
INSERT INTO Profissional VALUES (41, 'Joaquim Danilo de Paula', 'Rua Félix Kleis, 702', 'Santa Mônica', 'Chapecó', 'SC', 17)
INSERT INTO Profissional VALUES (42, 'Gustavo Matheus Alves', 'Domingos Monteiro da Silva, 272', 'Vargem do Bom Jesus', 'Florianópolis', 'SC', 18)
INSERT INTO Profissional VALUES (43, 'Felipe Martins', 'Travessa das Azuritas, 748', 'Tamarineira', 'Recife', 'PE', 19)
INSERT INTO Profissional VALUES (44, 'Guilherme Mendes', 'Rua Professor Costa Pinto, 105', 'Cidade Universitária', 'Recife', 'PE', 19)
INSERT INTO Profissional VALUES (45, 'Bernardo Barbosa', 'Rua Presidente Washington Luiz, 120', 'Engenho do Meio', 'Recife', 'PE', 19)
INSERT INTO Profissional VALUES (46, 'Bernardo Davi Freitas', 'Travessa Nazaré da Mata, 457', 'Morro da Conceição', 'Recife', 'PE', 19)
INSERT INTO Profissional VALUES (47, 'Iago Cavalcanti', 'Rua Itabira, 180', 'COHAB', 'Recife', 'PE', 20)
INSERT INTO Profissional VALUES (48, 'Francisco Pedro Moura', '2ª Travessa Flávio Guerra, 992', 'Macaxeira', 'Recife', 'PE', 20)
INSERT INTO Profissional VALUES (49, 'Bryan Pereira', 'Rua D, 358', 'Totó', 'Recife', 'PE', 20)

/* Inserção na tabela Telefone_Profissional */
INSERT INTO Telefone_Profissional VALUES (1,'(21)3622-6407')
INSERT INTO Telefone_Profissional VALUES (2, '(21)3760-4644')
INSERT INTO Telefone_Profissional VALUES (3,'(21)3956-5380')
INSERT INTO Telefone_Profissional VALUES (3, '(21)3523-9988')
INSERT INTO Telefone_Profissional VALUES (4, '(21)3777-1298')
INSERT INTO Telefone_Profissional VALUES (5, '(21)2631-6677')
INSERT INTO Telefone_Profissional VALUES (6, '(21)3809-8257')
INSERT INTO Telefone_Profissional VALUES (7, '(21)3969-5372')
INSERT INTO Telefone_Profissional VALUES (7, '(21)2640-4845')
INSERT INTO Telefone_Profissional VALUES (8, '(21)2642-4497')
INSERT INTO Telefone_Profissional VALUES (9, '(21)3711-3046')
INSERT INTO Telefone_Profissional VALUES (10, '(21)3639-3863')
INSERT INTO Telefone_Profissional VALUES (11, '(21)3518-4452')
INSERT INTO Telefone_Profissional VALUES (12, '(21)2869-0627')
INSERT INTO Telefone_Profissional VALUES (13, '(21)3545-6440')
INSERT INTO Telefone_Profissional VALUES (14, '(21)2531-0134')
INSERT INTO Telefone_Profissional VALUES (17, '(21)2662-4053')
INSERT INTO Telefone_Profissional VALUES (18, '(11)3544-4389')
INSERT INTO Telefone_Profissional VALUES (18, '(11)3526-8536')
INSERT INTO Telefone_Profissional VALUES (19, '(11)3516-3059')
INSERT INTO Telefone_Profissional VALUES (20, '(11)2987-2243')
INSERT INTO Telefone_Profissional VALUES (21, '(11)2910-2456')
INSERT INTO Telefone_Profissional VALUES (22, '(11)2907-0235')
INSERT INTO Telefone_Profissional VALUES (22, '(11)2740-8941')
INSERT INTO Telefone_Profissional VALUES (23, '(11)3813-0437')
INSERT INTO Telefone_Profissional VALUES (24, '(11)3516-3059')
INSERT INTO Telefone_Profissional VALUES (26, '(13)2747-1685')
INSERT INTO Telefone_Profissional VALUES (27, '(31)2909-7671')
INSERT INTO Telefone_Profissional VALUES (27, '(31)3711-2126')
INSERT INTO Telefone_Profissional VALUES (28, '(31)3657-7099')
INSERT INTO Telefone_Profissional VALUES (29, '(31)3979-3097')
INSERT INTO Telefone_Profissional VALUES (30, '(31)2982-9063')
INSERT INTO Telefone_Profissional VALUES (32, '(41)2520-9468')
INSERT INTO Telefone_Profissional VALUES (33, '(41)3978-5273')
INSERT INTO Telefone_Profissional VALUES (33, '(41)3534-7053')
INSERT INTO Telefone_Profissional VALUES (34, '(41)2625-0022')
INSERT INTO Telefone_Profissional VALUES (35, '(41)3919-0186')
INSERT INTO Telefone_Profissional VALUES (37, '(51)2692-1776')
INSERT INTO Telefone_Profissional VALUES (38, '(51)3678-9680')
INSERT INTO Telefone_Profissional VALUES (39, '(51)2712-0640')
INSERT INTO Telefone_Profissional VALUES (40, '(49)3642-7832')
INSERT INTO Telefone_Profissional VALUES (42, '(48)2551-7302')
INSERT INTO Telefone_Profissional VALUES (43, '(81)2637-1247')
INSERT INTO Telefone_Profissional VALUES (44, '(81)3529-0386')
INSERT INTO Telefone_Profissional VALUES (45, '(81)3749-3424')
INSERT INTO Telefone_Profissional VALUES (46, '(81)3594-4569')
INSERT INTO Telefone_Profissional VALUES (46, '(81)2645-0592')
INSERT INTO Telefone_Profissional VALUES (49, '(81)2790-2566') 

/* Inserção de Valores na tabela Médico */

INSERT INTO Medico VALUES (2, '85469', 'Ortopedia')
INSERT INTO Medico VALUES (4, '96325', 'Neurologia')
INSERT INTO Medico VALUES (5, '73654', 'Angiologia')
INSERT INTO Medico VALUES (11,'12896', 'Radiologia')
INSERT INTO Medico VALUES (13, '36258', 'Medicina intensiva')
INSERT INTO Medico VALUES (22, '30298', 'Reumatologia')
INSERT INTO Medico VALUES (41, '28555', 'Traumatologia')
INSERT INTO Medico VALUES (34, '16974', 'Infectologia')
INSERT INTO Medico VALUES (8, '80035', 'Medicina intensiva')
INSERT INTO Medico VALUES (10, '54698', 'Traumatologia')
INSERT INTO Medico VALUES (21, '14302', 'Neurologia')
INSERT INTO Medico VALUES (49, '99612', 'Cardiologia')
INSERT INTO Medico VALUES (33, '69432', 'Ortopedia')
INSERT INTO Medico VALUES (44, '22847', 'Radiologia')
INSERT INTO Medico VALUES (29, '39410', 'Reumatologia')
INSERT INTO Medico VALUES (39, '15765', 'Ortopedia')

/* Inserção de Valores na tabela Técnico */

INSERT INTO Tecnico VALUES (1, 'PRO')
INSERT INTO Tecnico VALUES (6, 'PRO')
INSERT INTO Tecnico VALUES (12, 'AA')
INSERT INTO Tecnico VALUES (23, 'PRO')
INSERT INTO Tecnico VALUES (34, 'PRO')
INSERT INTO Tecnico VALUES (28, 'BB')
INSERT INTO Tecnico VALUES (32, 'AA')
INSERT INTO Tecnico VALUES (39,'PRO')
INSERT INTO Tecnico VALUES (48, 'PRO')
INSERT INTO Tecnico VALUES (21, 'PRO')
INSERT INTO Tecnico VALUES (15, 'BB')
INSERT INTO Tecnico VALUES (38, 'PRO')
INSERT INTO Tecnico VALUES (22, 'AA')
INSERT INTO Tecnico VALUES (20,'PRO')
INSERT INTO Tecnico VALUES (10, 'PRO')
INSERT INTO Tecnico VALUES (30, 'BB')

/* Inserção de Valores na tabela Fisioterapeuta */

INSERT INTO Fisioterapeuta VALUES (3, '576211')
INSERT INTO Fisioterapeuta VALUES (6, '214867')
INSERT INTO Fisioterapeuta VALUES (12, '100430')
INSERT INTO Fisioterapeuta VALUES (38, '364100')
INSERT INTO Fisioterapeuta VALUES (23, '495203')
INSERT INTO Fisioterapeuta VALUES (27, '341025')
INSERT INTO Fisioterapeuta VALUES (29, '114744')
INSERT INTO Fisioterapeuta VALUES (45, '207558')
INSERT INTO Fisioterapeuta VALUES (36, '111762')
INSERT INTO Fisioterapeuta VALUES (30, '546028')
INSERT INTO Fisioterapeuta VALUES (7, '306901')
INSERT INTO Fisioterapeuta VALUES (14, '205980')
INSERT INTO Fisioterapeuta VALUES (28, '325111')
INSERT INTO Fisioterapeuta VALUES (37, '254973')
INSERT INTO Fisioterapeuta VALUES (41, '390224')
INSERT INTO Fisioterapeuta VALUES (40, '281147')

/* Inserção de Valores na tabela Jogador */

INSERT INTO Jogador VALUES ('276646203-17', 'Levi Thales Oliveira', '11/06/1996', 1.85, 'Rua Cinqüenta, 508', 'Forno Velho', 'São Mateus', 'ES', 'Brasil', NULL)
INSERT INTO Jogador VALUES ('311757177-97', 'Guilherme Luiz de Paula', '22/09/1999',1.73,'Rua Projetada, 0', 'Centro', 'São João do Paraíso', 'RJ', 'Brasil', NULL)
INSERT INTO Jogador VALUES ('947836947-45', 'Tomás Otávio Alves', '21/08/1989',1.88, 'Travessa da Vala, 837', 'Coreia', 'Mesquita', 'RJ','Brasil', 'tomalves@gmail.com')
INSERT INTO Jogador VALUES ('179871306-30', 'Kevin de Paula', '09/07/1993',1.99, 'Rua Anêmona, 708', 'Cruzeiro do Sul', 'Betim', 'MG', 'Brasil', 'k3vinpaula@hotmail.com')
INSERT INTO Jogador VALUES ('297617688-48', 'Kaique Filipe Araújo', '25/11/1985',1.77, 'Rua Dezenove de Maio, 455', 'Balneário Mogiano', 'Bertioga', 'SP', 'Brasil', NULL)
INSERT INTO Jogador VALUES ('980267248-36', 'Pedro Henrique Oliveira', '03/07/1993',1.70, 'Rua João Vieira da Silva, 709', 'Vila Sabrina', 'São Paulo', 'SP', 'Brasil', 'pedrohenriquerauloliveira_@br.com.br')
INSERT INTO Jogador VALUES ('098418418-00', 'Isaac Francisco Cardoso', '09/11/1987',1.95, 'Rua Belmiro Ferreira da Silva', 'Jardim Silva Teles', 'São Paulo', 'SP', 'Brasil', NULL)
INSERT INTO Jogador VALUES ('025222273-35', 'Matheus Castro', '08/03/2000',1.63, 'Rua Blancar do Vale Cordeiro, 809', 'Parque Jacinta', 'Teresina', 'PI', 'Brasil', 'castromatheus@gmail.com')
INSERT INTO Jogador VALUES ('406669655-44', 'Ander Herrera Agüera', '14/08/1989',1.82, 'San Nikolas de Olabeaga Kalea, 95', 'Olabeaga', 'Bilbao', NULL, 'Espanha', 'herrera_ander@outlook.es')
INSERT INTO Jogador VALUES ('262627175-60', 'Abdoulay Konko', '09/03/1984',1.84, 'Avenue Fernandel, 3741', 'Les Trois-Lucs', 'Marseille', NULL, 'França', NULL)
INSERT INTO Jogador VALUES ('297617228-48', 'Enzo Guilherme Moura', '26/05/2000',1.80, 'Rua dos Artistas, 724', 'Banco da Vitória', 'Ilhéus', 'BA', 'Brasil', 'guienzo@gmail.com')
INSERT INTO Jogador VALUES ('199832185-18', 'Hakan Sükür', '01/09/1980',1.91, 'Eski Havalaani Cd, 2015', 'Bakirköy', 'Istanbul', NULL, 'Turquia', NULL)
INSERT INTO Jogador VALUES ('848343315-04', 'Diogo Calebe Dias', '22/07/2000',1.65, 'Avenida Contorno, 593', 'Primavera', 'Vitória da Conquista', 'BA', 'Brasil', 'cabdiogo@gmail.com')
INSERT INTO Jogador VALUES ('714398816-26', 'Renato Tomás Fernandes', '26/08/2000',1.88, 'Rua Manoel José Filho, 923', 'São Miguel', 'Arcoverde', 'PE', 'Brasil', NULL)
INSERT INTO Jogador VALUES ('556494466-60', 'Cauã Lucas Mendes', '09/12/1991',1.80, 'Rua Marquês de Sapucaia, 285', 'Flores', 'Manaus', 'AM', 'Brasil', 'caualucas@outlook.com')
INSERT INTO Jogador VALUES ('528240522-95', 'Vitor Cardoso', '20/10/1995',1.77, 'Rua Barão do Rio Grande, 632', 'Boa Vista', 'Porto Alegre', 'RS', 'Brasil', NULL)
INSERT INTO Jogador VALUES ('167223378-04', 'Murilo Renato Costa', '09/01/1985',1.89, 'Rua Maria Silva de Araujo, 475', 'Planalto', 'Arapiraca', 'AL', 'Brasil', 'murilorenato@gmail.com')
INSERT INTO Jogador VALUES ('967548082-33', 'Carlos Eduardo Ribeiro', '09/12/1990', 1.84, 'Rua Joaquim Izidio Pereira, 833', 'Nova Parnamirim', 'Parnamirim', 'RN', 'Brasil', 'caduribeiro@outlook.com')
INSERT INTO Jogador VALUES ('399774680-01', 'Keisuke Honda', '26/10/1986', 1.82, 'Tokaido Shinkansen, 918', 'Shinzaike', 'Osaka', NULL, 'Japão', NULL)
INSERT INTO Jogador VALUES ('449574568-95', 'Sergej Milinkovic-Savic', '27/02/1993', 1.99, 'Bulevar Kalja Petra, 931', 'Rotkvarija', 'Novi Sad', NULL, 'Sérvia', 'milinsavic@gmail.sr')
INSERT INTO Jogador VALUES ('396916796-09', 'Enrico Igor Mendes', '25/11/1985', 1.77, 'Travessa Jaguari, 231', 'Isaura Parente', 'Rio Branco', 'AC', 'Brasil', NULL)
INSERT INTO Jogador VALUES ('568533030-83', 'Pierre Emile Hojbjerg', '03/09/1995', 1.85, 'Oster Voldgade, 1350', 'Kobenhavn K', 'Copenhague', NULL, 'Dinamarca', NULL)
INSERT INTO Jogador VALUES ('293817688-48', 'Leonardo Barros', '12/06/1989', 1.68, 'Rua Amorim, 119', 'Banco de Areia', 'Mesquita', 'RJ', 'Brasil', NULL)
INSERT INTO Jogador VALUES ('323463079-80', 'Davi Nathan Arthur Dias', '01/12/1984', 1.80, 'Rua Salvador, 205', 'Jockey de Itaparica', 'Vila Velha', 'ES', 'Brasil', 'davinathanarthurdias@destaco.com')
INSERT INTO Jogador VALUES ('284910409-43', 'Marcelo Gustavo Gomes', '22/08/1989', 1.88, 'Beco 2, 962', 'Petrópolis', 'Manaus', 'AM', 'Brasil', 'marcelogustavogomes-95@ahlstrom.com')
INSERT INTO Jogador VALUES ('904110798-32', 'Rögnvaldur Sigurgeirsson', '09/05/1986', 1.73, 'Hverfisgata, 88', '801', 'Selfoss', NULL, 'Islândia', 'RognvaldurSigurgeirsson@armyspy.com')
INSERT INTO Jogador VALUES ('935102709-08', 'Söröss Tas', '17/07/1996', 1.81, 'Rudabnányácska, 3945', 'Hegyalja', 'Újpest', NULL, 'Hungria', 'SorossTas@jourrapide.com')
INSERT INTO Jogador VALUES ('808848030-23', 'Manu Hyytiä', '09/08/1984', 1.77, 'Skölvägen, 45', 'PERHO', 'Joensuu', NULL, 'Finlândia', 'ManuHyytia@dayrep.com')

/* Inserção de valores na tabela Agente */

INSERT INTO Agente VALUES (1, 'Mark R. Nilsson')
INSERT INTO Agente VALUES (2, 'Frantisek Kaderábek')
INSERT INTO Agente VALUES (3, 'Bernd Kluge')
INSERT INTO Agente VALUES (4, 'André Araujo Souza')
INSERT INTO Agente VALUES (5, 'Carlos Gomes Cardoso')
INSERT INTO Agente VALUES (6, 'Gerardo Boni')

/* Inserção de valores na tabela Telefone_Agente */

INSERT INTO Telefone_Agente VALUES (1, '(98)2614-9370')
INSERT INTO Telefone_Agente VALUES (1, '(98)2659-2130')
INSERT INTO Telefone_Agente VALUES (2, '(82)3978-9501')
INSERT INTO Telefone_Agente VALUES (3, '(49)3891-4258') 
INSERT INTO Telefone_Agente VALUES (3, '(49)9626-2323') 
INSERT INTO Telefone_Agente VALUES (4, '(31)2526-8213') 
INSERT INTO Telefone_Agente VALUES (5, '(82)2676-4914') 
INSERT INTO Telefone_Agente VALUES (5, '(82)8629-7723') 
INSERT INTO Telefone_Agente VALUES (6, '(69)3978-1284') 

/* Inserção de valores na tabela Telefone_Jogador */

INSERT INTO Telefone_Jogador VALUES ('276646203-17', '(68)3899-5414')
INSERT INTO Telefone_Jogador VALUES ('276646203-17', '(68)8584-6051')
INSERT INTO Telefone_Jogador VALUES ('848343315-04', '(98)2539-8243')
INSERT INTO Telefone_Jogador VALUES ('528240522-95', '(92)3669-5134') 
INSERT INTO Telefone_Jogador VALUES ('311757177-97', '(64)3887-3041') 
INSERT INTO Telefone_Jogador VALUES ('311757177-97', '(64)8454-5535') 
INSERT INTO Telefone_Jogador VALUES ('396916796-09', '(95)2847-1764') 
INSERT INTO Telefone_Jogador VALUES ('808848030-23', '(96)2753-8866') 
INSERT INTO Telefone_Jogador VALUES ('297617688-48', '(67)2586-0121') 

/* Inserção de valores na tabela Dependente */

INSERT INTO Dependente VALUES ('Thiago Bryan Carvalho', '(85)3719-9049', '226074572', '690475639-05', 'Dependente de Hakan Sukur, filho adotivo do mesmo','199832185-18')
INSERT INTO Dependente VALUES ('Emil Sukur', '(85)8260-4719', '412326498', '832888432-18', 'Esposa de Hakan Sukur','199832185-18')
INSERT INTO Dependente VALUES ('Pietro Caio Rocha', '(62)2650-6983', '169650261', '685799741-19', 'Dependente de Enrico Igor Mendes','396916796-09')  
INSERT INTO Dependente VALUES ('Isaac Herrera', '(92)2928-8342', '218390531', '572084507-06', 'Familiar dependendente de Ander Herrera','406669655-44')  
INSERT INTO Dependente VALUES ('Davi Moura', '(92)9734-7735', '45047709-5', '791449551-46', NULL,'323463079-80')  
INSERT INTO Dependente VALUES ('Enzo Hojberg', '(98)3538-3917', '35383894-9', '738483226-84', 'Filho de Pierre Hojberg','568533030-83')  
INSERT INTO Dependente VALUES ('Matheus da Silva', '(98)9848-5758', '13651870-9', '373638535-84', NULL,'297617688-48')  
INSERT INTO Dependente VALUES ('Mahmoud Sukur', '(85)8117-4519', '243442385', '304706201-37', 'Filho de Hakan Sukur','199832185-18')  
INSERT INTO Dependente VALUES ('Paulo Daniel Rodrigues', '(92)2925-3343', '28849482', '727157808-00', NULL,'025222273-35')  
INSERT INTO Dependente VALUES ('Vinicius Levi Oliveira', '(85)8260-4719', '207420506', '508400340-08', NULL,'297617688-48')

/* Inserção de valores na tabela Contrata */

INSERT INTO Contrata VALUES (1, '199832185-18', '20/06/18', '18/12/22', 200000)    
INSERT INTO Contrata VALUES (3, '297617688-48', '11/07/18', '18/12/19', 89000)
INSERT INTO Contrata VALUES (8, '399774680-01', '05/03/18', '22/10/23', 23000)
INSERT INTO Contrata VALUES (10, '449574568-95', '12/12/18', '18/12/22', 100000)
INSERT INTO Contrata VALUES (4, '848343315-04', '12/05/19', '01/12/22', 90000)
INSERT INTO Contrata VALUES (20, '323463079-80', '20/12/18', '20/12/20', 30000)
INSERT INTO Contrata VALUES (5, '904110798-32', '05/04/19', '01/07/20', 118000)
INSERT INTO Contrata VALUES (1, '297617688-48', '01/03/18', '18/12/22', 99000)
INSERT INTO Contrata VALUES (2, '311757177-97', '25/02/18', '19/11/22', 21000)
INSERT INTO Contrata VALUES (1, '568533030-83', '22/01/19', '20/07/21', 90000)

/* Inserção de valores na tabela Contrato */
INSERT INTO Contrato VALUES (2, '098418418-00', 1)
INSERT INTO Contrato VALUES (1, '199832185-18', 2)
INSERT INTO Contrato VALUES (4, '808848030-23', 5)
INSERT INTO Contrato VALUES (20, '406669655-44', 5)
INSERT INTO Contrato VALUES (18, '556494466-60', 3)

/* Inserção de valores na tabela Campeonato */

INSERT INTO Campeonato VALUES (19, 'Copa Brasileira', 1200000, '25/02/2018', '09/12/2018', 20, 'FERJ')
INSERT INTO Campeonato VALUES (11, 'Campeonato do Sudeste', 700000, '11/03/2018', '10/06/2018', 12, 'FPF')
INSERT INTO Campeonato VALUES (7, 'Copa das Areias', 982000, '20/05/2018', '20/09/2018', 20, 'FMF')
INSERT INTO Campeonato VALUES (4, 'Quadrangular PE-SC', 590000, '20/03/2018', '12/05/2018', 4, 'FPE')
INSERT INTO Campeonato VALUES (16, 'Copa Sudeste/Sul', 200000, '20/01/2019', '20/11/2019', 16, 'FGF')

/* Inserção de valores na tabela Patrocinador */

INSERT INTO Patrocinio VALUES ('Itaú', 2329, 100000)
INSERT INTO Patrocinio VALUES ('Unibanco', 23391, 382100)
INSERT INTO Patrocinio VALUES ('Unimed', 1244, 120000)
INSERT INTO Patrocinio VALUES ('CEF', 210, 281900)
INSERT INTO Patrocinio VALUES ('Crefisa', 49, 500000)
INSERT INTO Patrocinio VALUES ('Gazprom', 278, NULL)
INSERT INTO Patrocinio VALUES ('Tag Heuer', 2971, NULL)

/* Inserção de valores na tabela Telefone_Patrocinador */

INSERT INTO Telefone_Patrocinador VALUES (1, '(79)2994-5205')
INSERT INTO Telefone_Patrocinador VALUES (1, '(79)8320-3959')
INSERT INTO Telefone_Patrocinador VALUES (2, '(43)3582-3253')
INSERT INTO Telefone_Patrocinador VALUES (3, '(69)2552-7158')
INSERT INTO Telefone_Patrocinador VALUES (3, '(69)9565-8434')
INSERT INTO Telefone_Patrocinador VALUES (4, '(79)3520-3299')
INSERT INTO Telefone_Patrocinador VALUES (5, '(51)2513-5096')

/* Inserção de valores na tabela Emissora */

INSERT INTO Emissora VALUES (1, 'Globo', 'Rua das Acácias, 491', 'Vargem Grande', 'Rio de Janeiro', 'RJ') 
INSERT INTO Emissora VALUES (2, 'Esporte Interativo', 'Avenida Ministro Edgard Romero, 868', 'Madureira', 'Rio de Janeiro', 'RJ') 
INSERT INTO Emissora VALUES (3, 'SBT', 'Avenida Carlos Caldeira Filho, 798', 'Vila Andrade', 'São Paulo', 'SP')
INSERT INTO Emissora VALUES (4, 'Band', 'Rua Vereda do Sol, 543', 'Jardim Limoeiro', 'São Paulo', 'SP')
INSERT INTO Emissora VALUES (5, 'Rede TV', 'Avenida Rio Branco, 604', 'Campos Elíseos', 'São Paulo', 'SP')

/* Inserção de valores na tabela Telefone_Emissora */

INSERT INTO Telefone_Emissora VALUES (1, '(21)3999-6047')
INSERT INTO Telefone_Emissora VALUES (1, '(21)9541-7310')
INSERT INTO Telefone_Emissora VALUES (2, '(21)3917-2888')
INSERT INTO Telefone_Emissora VALUES (3, '(11)3915-1276')
INSERT INTO Telefone_Emissora VALUES (4, '(11)2629-5651')
INSERT INTO Telefone_Emissora VALUES (4, '(11)9761-8642')
INSERT INTO Telefone_Emissora VALUES (5, '(11)2819-5896')

/* Inserção de valores na tabela CampTemPatrocinio */

INSERT INTO CampTemPatrocinio VALUES (1, 1, 3)
INSERT INTO CampTemPatrocinio VALUES (1, 4, 2)
INSERT INTO CampTemPatrocinio VALUES (2, 1, 1)
INSERT INTO CampTemPatrocinio VALUES (3, 2, 4)
INSERT INTO CampTemPatrocinio VALUES (4, 2, 2)
INSERT INTO CampTemPatrocinio VALUES (5, 4, 5)
INSERT INTO CampTemPatrocinio VALUES (5, 3, 1)

/* Atualizações em duas tabelas diferentes em uma única coluna */
UPDATE Dependente
SET nome = 'Mehmet Carvalho Sukur'
where codDependente = 1

UPDATE Torcedor
set clube_cnpj = 13
where codtorcedor = 12

/* Atualizações em duas tabelas diferentes em mais de uma coluna */
UPDATE Emissora
set nome = 'SporTV', endereco_rua = 'Rua José Melo, 788', endereco_bairro = 'Sepetiba', endereco_cidade = 'Rio de Janeiro', endereco_estado = 'RJ'
where cnpj = 5

UPDATE Patrocinio
set nome = 'Parmalat', cnpj = 281, valor = 1200000
where codPatrocinador = 4

/* Exclusões em duas tabelas diferentes com condição */
DELETE from Jogador
where cpf = '947836947-45'

DELETE from Patrocinio
where valor IS NULL