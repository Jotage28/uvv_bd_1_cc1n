CREATE DATABASE uvv 
    owner  'joao'
    template  'template0'
    encoding  'UTF8'
    lc_collate  'pt_BR.UTF-8'
    lc_ctype  'pt_BR.UTF-8'
    allow_connections 'true'
;
\c uvv;
CREATE SCHEMA IF NOT EXISTS hr
    AUTHORIZATION joao;	
CREATE TABLE hr.regioes (
                id_regiao INTEGER NOT NULL,
                nome VARCHAR(25) NOT NULL,
                CONSTRAINT id_regiao PRIMARY KEY (id_regiao)
);
COMMENT ON TABLE hr.regioes IS 'Contém número e nome das regiões';
COMMENT ON COLUMN hr.regioes.id_regiao IS 'Chave primária da tabela regiões.';
COMMENT ON COLUMN hr.regioes.nome IS 'Nome da regiões';


CREATE UNIQUE INDEX nome
 ON hr.regioes
 ( nome );

CREATE TABLE hr.paises (
                id_pais CHAR(2) NOT NULL,
                nome VARCHAR(50) NOT NULL,
                id_regiao INTEGER NOT NULL,
                CONSTRAINT id_pais_ PRIMARY KEY (id_pais)
);
COMMENT ON TABLE hr.paises IS 'Contém as informações dos países';
COMMENT ON COLUMN hr.paises.id_pais IS 'Chave primária da tabela países.';
COMMENT ON COLUMN hr.paises.nome IS 'Nome de cada país';
COMMENT ON COLUMN hr.paises.id_regiao IS 'Chave primária da tabela regiões.';


CREATE UNIQUE INDEX paises__idx
 ON hr.paises
 ( nome );

CREATE TABLE hr.localizacoes (
                id_localizacao INTEGER NOT NULL,
                endereco VARCHAR(50),
                cep VARCHAR(12),
                cidade VARCHAR(50),
                uf VARCHAR(25),
                id_pais CHAR(2) NOT NULL,
                CONSTRAINT id_localizacao PRIMARY KEY (id_localizacao)
);
COMMENT ON TABLE hr.localizacoes IS 'Tabela localizaçõs. Contém os endereços de diversos escritórios e facilidades
da empresa. Não armazena endereços de clientes.';
COMMENT ON COLUMN hr.localizacoes.id_localizacao IS 'Chave primária da tabela.';
COMMENT ON COLUMN hr.localizacoes.endereco IS 'Endereço de um escritório ou facilidade da empresa.';
COMMENT ON COLUMN hr.localizacoes.cep IS 'CEP de um escritório ou facilidade da empresa';
COMMENT ON COLUMN hr.localizacoes.cidade IS 'Cidade que se localiza o escritório ou facilidade da empresa';
COMMENT ON COLUMN hr.localizacoes.uf IS 'UF que se localiza um escritório ou facilidade da empresa';
COMMENT ON COLUMN hr.localizacoes.id_pais IS 'Chave primária da tabela países.';


CREATE TABLE hr.cargos (
                id_cargo VARCHAR(10) NOT NULL,
                cargo VARCHAR(35) NOT NULL,
                salario_minimo NUMERIC(8,2),
                salario_maximo NUMERIC(8,2),
                CONSTRAINT id_cargo PRIMARY KEY (id_cargo)
);
COMMENT ON TABLE hr.cargos IS 'Tabela que armazena cargos e faixa salarial, contendo mínimo e máximo para cada cargo';
COMMENT ON COLUMN hr.cargos.id_cargo IS 'chave primaria da tabela';
COMMENT ON COLUMN hr.cargos.cargo IS 'nomde do cargo';
COMMENT ON COLUMN hr.cargos.salario_minimo IS 'menor salário possivel para um cargo';
COMMENT ON COLUMN hr.cargos.salario_maximo IS 'maior salario possivel para um cargo';


CREATE UNIQUE INDEX cargos_idx
 ON hr.cargos
 ( cargo );

CREATE TABLE hr.empregados (
                id_empregado INTEGER NOT NULL,
                nome VARCHAR(75) NOT NULL,
                email VARCHAR(35) NOT NULL,
                telefone VARCHAR(20),
                data_contratacao DATE NOT NULL,
                id_cargo VARCHAR(10) NOT NULL,
                salario NUMERIC(8,2),
                comissao NUMERIC(4,2),
                id_supervisor INTEGER,
                id_departamento INTEGER NOT NULL,
                CONSTRAINT id_empregado_ PRIMARY KEY (id_empregado)
);

COMMENT ON TABLE hr.empregados IS 'Tabela que contém as informações dos empregados.';
COMMENT ON COLUMN hr.empregados.id_empregado IS 'Chave primária da tabela.';
COMMENT ON COLUMN hr.empregados.nome IS 'Nome completo do empregado.';
COMMENT ON COLUMN hr.empregados.email IS 'Parte inicial do email do empregado (antes do @).';
COMMENT ON COLUMN hr.empregados.telefone IS 'Telefone do empregado';
COMMENT ON COLUMN hr.empregados.data_contratacao IS 'Data que o empregado iniciou no cargo atual.';
COMMENT ON COLUMN hr.empregados.id_cargo IS 'do empregado.';
COMMENT ON COLUMN hr.empregados.salario IS 'Salário mensal atual do empregado.';
COMMENT ON COLUMN hr.empregados.comissao IS 's quem trabalha no departamento de vendas';
COMMENT ON COLUMN hr.empregados.id_supervisor IS 'Chave primária da tabela.';
COMMENT ON COLUMN hr.empregados.id_departamento IS 'chave primária da tabela departamentos';


CREATE UNIQUE INDEX empregados_idx
 ON hr.empregados
 ( email );

CREATE TABLE hr.departamentos (
                id_departamento INTEGER NOT NULL,
                nome VARCHAR(20) NOT NULL,
                id_localizacao INTEGER NOT NULL,
                id_gerente INTEGER,
                CONSTRAINT id_departamento_ PRIMARY KEY (id_departamento)
);
COMMENT ON TABLE hr.departamentos IS 'Tabela que mostra s departamentos existentes na empresa';
COMMENT ON COLUMN hr.departamentos.id_departamento IS 'chave primária da tabela departamentos';
COMMENT ON COLUMN hr.departamentos.nome IS 'Nome do departamento';
COMMENT ON COLUMN hr.departamentos.id_localizacao IS 'Chave primária da tabela.';
COMMENT ON COLUMN hr.departamentos.id_gerente IS 'Chave primária da tabela.';


CREATE UNIQUE INDEX departamentos_idx
 ON hr.departamentos
 ( nome );

CREATE TABLE hr.historico_cargos (
                data_inicial DATE NOT NULL,
                id_empregado INTEGER NOT NULL,
                data_final DATE NOT NULL,
                id_departamento INTEGER NOT NULL,
                id_cargo VARCHAR(10) NOT NULL,
                CONSTRAINT id_empregado_e_data_inicial PRIMARY KEY (data_inicial, id_empregado)
);
COMMENT ON TABLE hr.historico_cargos IS 'Tabela que armazena o histórico de cargos de um empregado. Se um empregado
mudar de departamento dentro de um cargo ou mudar de cargo dentro de um
departamento, novas linhas devem ser inseridas nesta tabela com a informação
antiga do empregado.';
COMMENT ON COLUMN hr.historico_cargos.id_empregado IS 'Chave primária da tabela.';
COMMENT ON COLUMN hr.historico_cargos.data_final IS 'e a data inicial.';
COMMENT ON COLUMN hr.historico_cargos.id_departamento IS 'chave primária';
COMMENT ON COLUMN hr.historico_cargos.id_cargo IS 'chave primaria da tabela';
INSERT INTO hr.regioes(
	id_regiao, nome)
	VALUES (1, 'Europe');
	INSERT INTO hr.regioes (
	id_regiao, nome) VALUES (2, 'Americas');
	INSERT INTO hr.regioes(
	id_regiao, nome)
	VALUES (3, 'Asia');
	INSERT INTO hr.regioes(
	id_regiao, nome)
	VALUES (4, 'Middle East and Africa');
	INSERT INTO hr.cargos(
	id_cargo, cargo, salario_minimo, salario_maximo)
	VALUES ('AD_PRES', 'President', 20080, 40000);
INSERT INTO hr.cargos(
	id_cargo, cargo, salario_minimo, salario_maximo)
	VALUES ('AD_VP', 'Administration Vice President', 15000, 30000);
INSERT INTO hr.cargos (id_cargo, cargo, salario_minimo,
  salario_maximo) VALUES ('AD_ASST', 'Administration Assistant', 3000, 6000);
INSERT INTO hr.cargos (id_cargo, cargo, salario_minimo,
  salario_maximo) VALUES ('FI_MGR', 'Finance Manager', 8200, 16000);
INSERT INTO hr.cargos (id_cargo, cargo, salario_minimo,
  salario_maximo) VALUES ('FI_ACCOUNT', 'Accountant', 4200, 9000);
INSERT INTO hr.cargos (id_cargo, cargo, salario_minimo,
  salario_maximo) VALUES ('AC_MGR', 'Accounting Manager', 8200, 16000);
INSERT INTO hr.cargos (id_cargo, cargo, salario_minimo,
  salario_maximo) VALUES ('AC_ACCOUNT', 'Public Accountant', 4200, 9000);
INSERT INTO hr.cargos (id_cargo, cargo, salario_minimo,
  salario_maximo) VALUES ('SA_MAN', 'Sales Manager', 10000, 20080);
INSERT INTO hr.cargos (id_cargo, cargo, salario_minimo,
  salario_maximo) VALUES ('SA_REP', 'Sales Representative', 6000, 12008);
INSERT INTO hr.cargos (id_cargo, cargo, salario_minimo,
  salario_maximo) VALUES ('PU_MAN', 'Purchasing Manager', 8000, 15000);
INSERT INTO hr.cargos (id_cargo, cargo, salario_minimo,
  salario_maximo) VALUES ('PU_CLERK', 'Purchasing Clerk', 2500, 5500);
INSERT INTO hr.cargos (id_cargo, cargo, salario_minimo,
  salario_maximo) VALUES ('ST_MAN', 'Stock Manager', 5500, 8500);
INSERT INTO hr.cargos (id_cargo, cargo, salario_minimo,
  salario_maximo) VALUES ('ST_CLERK', 'Stock Clerk', 2008, 5000);
INSERT INTO hr.cargos (id_cargo, cargo, salario_minimo,
  salario_maximo) VALUES ('SH_CLERK', 'Shipping Clerk', 2500, 5500);
INSERT INTO hr.cargos (id_cargo, cargo, salario_minimo,
  salario_maximo) VALUES ('IT_PROG', 'Programmer', 4000, 10000);
INSERT INTO hr.cargos (id_cargo, cargo, salario_minimo,
  salario_maximo) VALUES ('MK_MAN', 'Marketing Manager', 9000, 15000);
INSERT INTO hr.cargos (id_cargo, cargo, salario_minimo,
  salario_maximo) VALUES ('MK_REP', 'Marketing Representative', 4000, 9000);
INSERT INTO hr.cargos (id_cargo, cargo, salario_minimo,
  salario_maximo) VALUES ('HR_REP', 'Human Resources Representative', 4000, 9000);
INSERT INTO hr.cargos (id_cargo, cargo, salario_minimo,
  salario_maximo) VALUES ('PR_REP', 'Public Relations Representative', 4500, 10500);
  INSERT INTO hr.departamentos (id_departamento, nome, id_localizacao, id_gerente) VALUES (10, 'Administration', 1700, 200);
INSERT INTO hr.departamentos (id_departamento, nome, id_localizacao, id_gerente) VALUES (20, 'Marketing', 1800, 201);
INSERT INTO hr.departamentos (id_departamento, nome, id_localizacao, id_gerente) VALUES (30, 'Purchasing', 1700, 114);
INSERT INTO hr.departamentos (id_departamento, nome, id_localizacao, id_gerente) VALUES (40, 'Human Resources', 2400, 203);
INSERT INTO hr.departamentos (id_departamento, nome, id_localizacao, id_gerente) VALUES (50, 'Shipping', 1500, 121);
INSERT INTO hr.departamentos (id_departamento, nome, id_localizacao, id_gerente) VALUES (60, 'IT', 1400, 103);
INSERT INTO hr.departamentos (id_departamento, nome, id_localizacao, id_gerente) VALUES (70, 'Public Relations', 2700, 204);
INSERT INTO hr.departamentos (id_departamento, nome, id_localizacao, id_gerente) VALUES (80, 'Sales', 2500, 145);
INSERT INTO hr.departamentos (id_departamento, nome, id_localizacao, id_gerente) VALUES (90, 'Executive', 1700, 100);
INSERT INTO hr.departamentos (id_departamento, nome, id_localizacao, id_gerente) VALUES (100, 'Finance', 1700, 108);
INSERT INTO hr.departamentos (id_departamento, nome, id_localizacao, id_gerente) VALUES (110, 'Accounting', 1700, 205);
INSERT INTO hr.departamentos (id_departamento, nome, id_localizacao, id_gerente) VALUES (120, 'Treasury', 1700, null);
INSERT INTO hr.departamentos (id_departamento, nome, id_localizacao, id_gerente) VALUES (130, 'Corporate Tax', 1700, null);
INSERT INTO hr.departamentos (id_departamento, nome, id_localizacao, id_gerente) VALUES (140, 'Control And Credit', 1700, null);
INSERT INTO hr.departamentos (id_departamento, nome, id_localizacao, id_gerente) VALUES (150, 'Shareholder Services', 1700, null);
INSERT INTO hr.departamentos (id_departamento, nome, id_localizacao, id_gerente) VALUES (160, 'Benefits', 1700, null);
INSERT INTO hr.departamentos (id_departamento, nome, id_localizacao, id_gerente) VALUES (170, 'Manufacturing', 1700, null);
INSERT INTO hr.departamentos (id_departamento, nome, id_localizacao, id_gerente) VALUES (180, 'Construction', 1700, null);
INSERT INTO hr.departamentos (id_departamento, nome, id_localizacao, id_gerente) VALUES (190, 'Contracting', 1700, null);
INSERT INTO hr.departamentos (id_departamento, nome, id_localizacao, id_gerente) VALUES (200, 'Operations', 1700, null);
INSERT INTO hr.departamentos (id_departamento, nome, id_localizacao, id_gerente) VALUES (210, 'IT Support', 1700, null);
INSERT INTO hr.departamentos (id_departamento, nome, id_localizacao, id_gerente) VALUES (220, 'NOC', 1700, null);
INSERT INTO hr.departamentos (id_departamento, nome, id_localizacao, id_gerente) VALUES (230, 'IT Helpdesk', 1700, null);
INSERT INTO hr.departamentos (id_departamento, nome, id_localizacao, id_gerente) VALUES (240, 'Government Sales', 1700, null);
INSERT INTO hr.departamentos (id_departamento, nome, id_localizacao, id_gerente) VALUES (250, 'Retail Sales', 1700, null);
INSERT INTO hr.departamentos (id_departamento, nome, id_localizacao, id_gerente) VALUES (260, 'Recruiting', 1700, null);
INSERT INTO hr.departamentos (id_departamento, nome, id_localizacao, id_gerente) VALUES (270, 'Payroll', 1700, null);
INSERT INTO hr.historico_cargos (data_inicial, id_empregado, data_final, id_departamento, id_cargo) VALUES ('2001-01-13', '102', '2006-07-24', 60, 'IT_PROG');
INSERT INTO hr.historico_cargos (data_inicial, id_empregado, data_final, id_departamento, id_cargo) VALUES ('2001-10-28', '101', '2005-03-15', 110, 'AC_MGR');
INSERT INTO hr.historico_cargos (data_inicial, id_empregado, data_final, id_departamento, id_cargo) VALUES ('2004-02-17', '201', '2007-12-19', 20, 'MK_REP');
INSERT INTO hr.historico_cargos (data_inicial, id_empregado, data_final, id_departamento, id_cargo) VALUES ('2006-03-24', '114', '2007-12-31', 50, 'ST_CLERK');
INSERT INTO hr.historico_cargos (data_inicial, id_empregado, data_final, id_departamento, id_cargo) VALUES ('2007-01-01', '122', '2007-12-31', 50, 'ST_CLERK');
INSERT INTO hr.historico_cargos (data_inicial, id_empregado, data_final, id_departamento, id_cargo) VALUES ('1995-09-17', '200', '2001-06-17', 90, 'AD_ASST');
INSERT INTO hr.historico_cargos (data_inicial, id_empregado, data_final, id_departamento, id_cargo) VALUES ('2006-03-24', '176', '2006-12-31', 80, 'SA_REP');
INSERT INTO hr.historico_cargos (data_inicial, id_empregado, data_final, id_departamento, id_cargo) VALUES ('2007-01-01', '176', '2007-12-31', 80, 'SA_MAN');
INSERT INTO hr.historico_cargos (data_inicial, id_empregado, data_final, id_departamento, id_cargo) VALUES ('2002-07-01', '200', '2006-12-31', 90, 'AC_ACCOUNT');
INSERT INTO hr.paises (id_pais, id_regiao, nome) VALUES ('AR', 2, 'Argentina');
INSERT INTO hr.paises (id_pais, id_regiao, nome) VALUES ('AU', 3, 'Australia');
INSERT INTO hr.paises (id_pais, id_regiao, nome) VALUES ('BE', 1, 'Belgium');
INSERT INTO hr.paises (id_pais, id_regiao, nome) VALUES ('BR', 2, 'Brazil');
INSERT INTO hr.paises (id_pais, id_regiao, nome) VALUES ('CA', 2, 'Canada');
INSERT INTO hr.paises (id_pais, id_regiao, nome) VALUES ('CH', 1, 'Switzerland');
INSERT INTO hr.paises (id_pais, id_regiao, nome) VALUES ('CN', 3, 'China');
INSERT INTO hr.paises (id_pais, id_regiao, nome) VALUES ('DE', 1, 'Germany');
INSERT INTO hr.paises (id_pais, id_regiao, nome) VALUES ('DK', 1, 'Denmark');
INSERT INTO hr.paises (id_pais, id_regiao, nome) VALUES ('EG', 4, 'Egypt');
INSERT INTO hr.paises (id_pais, id_regiao, nome) VALUES ('FR', 1, 'France');
INSERT INTO hr.paises (id_pais, id_regiao, nome) VALUES ('IL', 4, 'Israel');
INSERT INTO hr.paises (id_pais, id_regiao, nome) VALUES ('IN', 3, 'India');
INSERT INTO hr.paises (id_pais, id_regiao, nome) VALUES ('IT', 1, 'Italy');
INSERT INTO hr.paises (id_pais, id_regiao, nome) VALUES ('JP', 3, 'Japan');
INSERT INTO hr.paises (id_pais, id_regiao, nome) VALUES ('KW', 4, 'Kuwait');
INSERT INTO hr.paises (id_pais, id_regiao, nome) VALUES ('ML', 3, 'Malaysia');
INSERT INTO hr.paises (id_pais, id_regiao, nome) VALUES ('MX', 2, 'Mexico');
INSERT INTO hr.paises (id_pais, id_regiao, nome) VALUES ('NG', 4, 'Nigeria');
INSERT INTO hr.paises (id_pais, id_regiao, nome) VALUES ('NL', 1, 'Netherlands');
INSERT INTO hr.paises (id_pais, id_regiao, nome) VALUES ('SG', 3, 'Singapore');
INSERT INTO hr.paises (id_pais, id_regiao, nome) VALUES ('UK', 1, 'United Kingdom');
INSERT INTO hr.paises (id_pais, id_regiao, nome) VALUES ('US', 2, 'United States of America');
INSERT INTO hr.paises (id_pais, id_regiao, nome) VALUES ('ZM', 4, 'Zambia');
INSERT INTO hr.paises (id_pais, id_regiao, nome) VALUES ('ZW', 4, 'Zimbabwe');
INSERT INTO hr.localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais) VALUES (1000, '1297 Via Cola di Rie', '00989', 'Roma', '', 'IT');
INSERT INTO hr.localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais) VALUES (1100, '93091 Calle della Testa', '10934', 'Venice', '', 'IT');
INSERT INTO hr.localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais) VALUES (1200, '2017 Shinjuku-ku', '1689', 'Tokyo', 'Tokyo Prefecture', 'JP');
INSERT INTO hr.localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais) VALUES (1300, '9450 Kamiya-cho', '6823', 'Hiroshima', '', 'JP');
INSERT INTO hr.localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais) VALUES (1400, '2014 Jabberwocky Rd', '26192', 'Southlake', 'Texas', 'US');
INSERT INTO hr.localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais) VALUES (1500, '2011 Interiors Blvd', '99236', 'South San Francisco', 'California', 'US');
INSERT INTO hr.localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais) VALUES (1600, '2007 Zagora St', '50090', 'South Brunswick', 'New Jersey', 'US');
INSERT INTO hr.localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais) VALUES (1700, '2004 Charade Rd', '98199', 'Seattle', 'Washington', 'US');
INSERT INTO hr.localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais) VALUES (1800, '147 Spadina Ave', 'M5V 2L7', 'Toronto', 'Ontario', 'CA');
INSERT INTO hr.localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais) VALUES (1900, '6092 Boxwood St', 'YSW 9T2', 'Whitehorse', 'Yukon', 'CA');
INSERT INTO hr.localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais) VALUES (2000, '40-5-12 Laogianggen', '190518', 'Beijing', '', 'CN');
INSERT INTO hr.localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais) VALUES (2100, '1298 Vileparle (E)', '490231', 'Bombay', 'Maharashtra', 'IN');
INSERT INTO hr.localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais) VALUES (2200, '12-98 Victoria Street', '2901', 'Sydney', 'New South Wales', 'AU');
INSERT INTO hr.localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais) VALUES (2300, '198 Clementi North', '540198', 'Singapore', '', 'SG');
INSERT INTO hr.localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais) VALUES (2400, '8204 Arthur St', '', 'London', '', 'UK');
INSERT INTO hr.localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais) VALUES (2500, 'Magdalen Centre, The Oxford Science Park', 'OX9 9ZB', 'Oxford', 'Oxford', 'UK');
INSERT INTO hr.localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais) VALUES (2600, '9702 Chester Road', '09629850293', 'Stretford', 'Manchester', 'UK');
INSERT INTO hr.localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais) VALUES (2700, 'Schwanthalerstr. 7031', '80925', 'Munich', 'Bavaria', 'DE');
INSERT INTO hr.localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais) VALUES (2800, 'Rua Frei Caneca 1360 ', '01307-002', 'Sao Paulo', 'Sao Paulo', 'BR');
INSERT INTO hr.localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais) VALUES (2900, '20 Rue des Corps-Saints', '1730', 'Geneva', 'Geneve', 'CH');
INSERT INTO hr.localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais) VALUES (3000, 'Murtenstrasse 921', '3095', 'Bern', 'BE', 'CH');
INSERT INTO hr.localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais) VALUES (3100, 'Pieter Breughelstraat 837', '3029SK', 'Utrecht', 'Utrecht', 'NL');
INSERT INTO hr.localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais) VALUES (3201, 'Mariano Escobedo 9991', '11932', 'Mexico City', 'Distrito Federal,', 'MX');
INSERT INTO hr.empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(100, 'Steven King', 'SKING', '515.123.4567', '2003-06-17', 'AD_PRES', 24000, null, null, 90);
INSERT INTO hr.empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(101, 'Neena Kochhar', 'NKOCHHAR', '515.123.4568', '2005-09-21', 'AD_VP', 17000, null, 100, 90);
INSERT INTO hr.empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(102, 'Lex De Haan', 'LDEHAAN', '515.123.4569', '2001-01-13', 'AD_VP', 17000, null, 100, 90);
INSERT INTO hr.empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(103, 'Alexander Hunold', 'AHUNOLD', '590.423.4567', '2006-01-03', 'IT_PROG', 9000, null, 102, 60);
INSERT INTO hr.empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(104, 'Bruce Ernst', 'BERNST', '590.423.4568', '2007-05-21', 'IT_PROG', 6000, null, 103, 60);
INSERT INTO hr.empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(105, 'David Austin', 'DAUSTIN', '590.423.4569', '2005-06-25', 'IT_PROG', 4800, null, 103, 60);
INSERT INTO hr.empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(106, 'Valli Pataballa', 'VPATABAL', '590.423.4560', '2006-02-05', 'IT_PROG', 4800, null, 103, 60);
INSERT INTO hr.empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(107, 'Diana Lorentz', 'DLORENTZ', '590.423.5567', '2007-02-07', 'IT_PROG', 4200, null, 103, 60);
INSERT INTO hr.empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(108, 'Nancy Greenberg', 'NGREENBE', '515.124.4569', '2002-08-17', 'FI_MGR', 12008, null, 101, 100);
INSERT INTO hr.empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(109, 'Daniel Faviet', 'DFAVIET', '515.124.4169', '2002-08-16', 'FI_ACCOUNT', 9000, null, 108, 100);
INSERT INTO hr.empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(110, 'John Chen', 'JCHEN', '515.124.4269', '2005-09-28', 'FI_ACCOUNT', 8200, null, 108, 100);
INSERT INTO hr.empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(111, 'Ismael Sciarra', 'ISCIARRA', '515.124.4369', '2005-09-30', 'FI_ACCOUNT', 7700, null, 108, 100);
INSERT INTO hr.empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(112, 'Jose Manuel Urman', 'JMURMAN', '515.124.4469', '2006-03-07', 'FI_ACCOUNT', 7800, null, 108, 100);
INSERT INTO hr.empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(113, 'Luis Popp', 'LPOPP', '515.124.4567', '2007-12-07', 'FI_ACCOUNT', 6900, null, 108, 100);
INSERT INTO hr.empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(114, 'Den Raphaely', 'DRAPHEAL', '515.127.4561', '2002-12-07', 'PU_MAN', 11000, null, 100, 30);
INSERT INTO hr.empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(115, 'Alexander Khoo', 'AKHOO', '515.127.4562', '2003-05-18', 'PU_CLERK', 3100, null, 114, 30);
INSERT INTO hr.empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(116, 'Shelli Baida', 'SBAIDA', '515.127.4563', '2005-12-24', 'PU_CLERK', 2900, null, 114, 30);
INSERT INTO hr.empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(117, 'Sigal Tobias', 'STOBIAS', '515.127.4564', '2005-07-24', 'PU_CLERK', 2800, null, 114, 30);
INSERT INTO hr.empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(118, 'Guy Himuro', 'GHIMURO', '515.127.4565', '2006-11-15', 'PU_CLERK', 2600, null, 114, 30);
INSERT INTO hr.empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(119, 'Karen Colmenares', 'KCOLMENA', '515.127.4566', '2007-08-10', 'PU_CLERK', 2500, null, 114, 30);
INSERT INTO hr.empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(120, 'Matthew Weiss', 'MWEISS', '650.123.1234', '2004-07-18', 'ST_MAN', 8000, null, 100, 50);
INSERT INTO hr.empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(121, 'Adam Fripp', 'AFRIPP', '650.123.2234', '2005-04-10', 'ST_MAN', 8200, null, 100, 50);
INSERT INTO hr.empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(122, 'Payam Kaufling', 'PKAUFLIN', '650.123.3234', '2003-05-01', 'ST_MAN', 7900, null, 100, 50);
INSERT INTO hr.empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(123, 'Shanta Vollman', 'SVOLLMAN', '650.123.4234', '2005-10-10', 'ST_MAN', 6500, null, 100, 50);
INSERT INTO hr.empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(124, 'Kevin Mourgos', 'KMOURGOS', '650.123.5234', '2007-11-16', 'ST_MAN', 5800, null, 100, 50);
INSERT INTO hr.empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(125, 'Julia Nayer', 'JNAYER', '650.124.1214', '2005-07-16', 'ST_CLERK', 3200, null, 120, 50);
INSERT INTO hr.empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(126, 'Irene Mikkilineni', 'IMIKKILI', '650.124.1224', '2006-09-28', 'ST_CLERK', 2700, null, 120, 50);
INSERT INTO hr.empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(127, 'James Landry', 'JLANDRY', '650.124.1334', '2007-01-14', 'ST_CLERK', 2400, null, 120, 50);
INSERT INTO hr.empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(128, 'Steven Markle', 'SMARKLE', '650.124.1434', '2008-03-08', 'ST_CLERK', 2200, null, 120, 50);
INSERT INTO hr.empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(129, 'Laura Bissot', 'LBISSOT', '650.124.5234', '2005-08-20', 'ST_CLERK', 3300, null, 121, 50);
INSERT INTO hr.empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(130, 'Mozhe Atkinson', 'MATKINSO', '650.124.6234', '2005-10-30', 'ST_CLERK', 2800, null, 121, 50);
INSERT INTO hr.empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(131, 'James Marlow', 'JAMRLOW', '650.124.7234', '2005-02-16', 'ST_CLERK', 2500, null, 121, 50);
INSERT INTO hr.empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(132, 'TJ Olson', 'TJOLSON', '650.124.8234', '2007-04-10', 'ST_CLERK', 2100, null, 121, 50);
INSERT INTO hr.empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(133, 'Jason Mallin', 'JMALLIN', '650.127.1934', '2004-06-14', 'ST_CLERK', 3300, null, 122, 50);
INSERT INTO hr.empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(134, 'Michael Rogers', 'MROGERS', '650.127.1834', '2006-08-26', 'ST_CLERK', 2900, null, 122, 50);
INSERT INTO hr.empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(135, 'Ki Gee', 'KGEE', '650.127.1734', '2007-12-12', 'ST_CLERK', 2400, null, 122, 50);
INSERT INTO hr.empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(136, 'Hazel Philtanker', 'HPHILTAN', '650.127.1634', '2008-02-06', 'ST_CLERK', 2200, null, 122, 50);
INSERT INTO hr.empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(137, 'Renske Ladwig', 'RLADWIG', '650.121.1234', '2003-07-14', 'ST_CLERK', 3600, null, 123, 50);
INSERT INTO hr.empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(138, 'Stephen Stiles', 'SSTILES', '650.121.2034', '2005-10-26', 'ST_CLERK', 3200, null, 123, 50);
INSERT INTO hr.empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(139, 'John Seo', 'JSEO', '650.121.2019', '2006-02-12', 'ST_CLERK', 2700, null, 123, 50);
INSERT INTO hr.empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(140, 'Joshua Patel', 'JPATEL', '650.121.1834', '2006-04-06', 'ST_CLERK', 2500, null, 123, 50);
INSERT INTO hr.empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(141, 'Trenna Rajs', 'TRAJS', '650.121.8009', '2003-10-17', 'ST_CLERK', 3500, null, 124, 50);
INSERT INTO hr.empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(142, 'Curtis Davies', 'CDAVIES', '650.121.2994', '2005-01-29', 'ST_CLERK', 3100, null, 124, 50);
INSERT INTO hr.empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(143, 'Randall Matos', 'RMATOS', '650.121.2874', '2006-03-15', 'ST_CLERK', 2600, null, 124, 50);
INSERT INTO hr.empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(144, 'Peter Vargas', 'PVARGAS', '650.121.2004', '2006-07-09', 'ST_CLERK', 2500, null, 124, 50);
INSERT INTO hr.empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(145, 'John Russell', 'JRUSSEL', '011.44.1344.429268', '2004-10-01', 'SA_MAN', 14000, .4, 100, 80);
INSERT INTO hr.empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(146, 'Karen Partners', 'KPARTNER', '011.44.1344.467268', '2005-01-05', 'SA_MAN', 13500, .3, 100, 80);
INSERT INTO hr.empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(147, 'Alberto Errazuriz', 'AERRAZUR', '011.44.1344.429278', '2005-03-10', 'SA_MAN', 12000, .3, 100, 80);
INSERT INTO hr.empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(148, 'Gerald Cambrault', 'GCAMBRAU', '011.44.1344.619268', '2007-10-15', 'SA_MAN', 11000, .3, 100, 80);
INSERT INTO hr.empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(149, 'Eleni Zlotkey', 'EZLOTKEY', '011.44.1344.429018', '2008-01-29', 'SA_MAN', 10500, .2, 100, 80);
ALTER TABLE hr.paises ADD CONSTRAINT regioes__paises__fk
FOREIGN KEY (id_regiao)
REFERENCES hr.regioes (id_regiao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.localizacoes ADD CONSTRAINT paises__localizacoes_fk
FOREIGN KEY (id_pais)
REFERENCES hr.paises (id_pais)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.departamentos ADD CONSTRAINT localizacoes_departamentos_fk
FOREIGN KEY (id_localizacao)
REFERENCES hr.localizacoes (id_localizacao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.empregados ADD CONSTRAINT cargos_empregados_fk
FOREIGN KEY (id_cargo)
REFERENCES hr.cargos (id_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.historico_cargos ADD CONSTRAINT cargos_historico_cargos__fk
FOREIGN KEY (id_cargo)
REFERENCES hr.cargos (id_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.historico_cargos ADD CONSTRAINT empregados_historico_cargos_fk
FOREIGN KEY (id_empregado)
REFERENCES hr.empregados (id_empregado)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.empregados ADD CONSTRAINT empregados_empregados_fk
FOREIGN KEY (id_supervisor)
REFERENCES hr.empregados (id_empregado)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.departamentos ADD CONSTRAINT empregados_departamentos_fk
FOREIGN KEY (id_gerente)
REFERENCES hr.empregados (id_empregado)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.historico_cargos ADD CONSTRAINT departamentos_historico_cargos__fk
FOREIGN KEY (id_departamento)
REFERENCES hr.departamentos (id_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.empregados ADD CONSTRAINT departamentos_empregados_fk
FOREIGN KEY (id_departamento)
REFERENCES hr.departamentos (id_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;