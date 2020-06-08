-- create database smartrun_tb
use  smartrun_db;

create table cliente_atleta_tb
(
id_cli_atlet int not null auto_increment,
nome varchar(45),
sobrenome varchar(45),
data_nascimento date,
sexo varchar(10),
peso double,
altura float,
cpf char(11) not null,
telefone varchar(12),
email varchar(20),
endereco varchar(45),
cidade varchar(10),
estado varchar(10),
pais varchar(10),

constraint PK_ATLETA
primary key (id_cli_atlet)
);

create table planos_assesoria_tb
(
id_plano int not null auto_increment,
descricao varchar(45),
valor decimal(12,2),
perido varchar(10),
beneficios varchar(45),

constraint PK_PLANO_ASSESSORIA
primary key (id_plano)
)auto_increment = 1000; 

create table forma_pagamento_tb
(
id_formpag int not null,
descricao varchar(45),

constraint PK_FORMPAG
primary key (id_formpag)
);

create table cliente_assessoria_tb
(
id_cli_asses int not null auto_increment,
nome varchar(45),
sobrenome varchar(45),
telefone varchar(12),
cpf char(11),
cnpj char(13),
sexo char (1),
email varchar (20),
fk_id_plano int not null,

constraint PK_ASSESSORIA
primary key (id_cli_asses),
constraint FK_PLANO_ASSESSORIA
foreign key (fk_id_plano)
references planos_assesoria_tb(id_plano)
);

create table sala_alunos_tb
(id_sala int not null auto_increment,
 descricao varchar(45),
 
 constraint PK_SALA
 primary key (id_sala)
);

create table treinos_tb
(
id_treino int not null auto_increment,
descricao varchar(200),
data_agendada date ,
local_agendado varchar(45),
cidade varchar(20),
estado varchar(20),
fk_id_cli_asses int not null,
fk_id_sala   int not null,

constraint PK_TREINO
primary key (id_treino),
constraint FK_CLI_ASSES
foreign key (fk_id_cli_asses)
references cliente_assessoria_tb(id_cli_asses),
constraint FK_SALA
foreign key (fk_id_sala)
references sala_alunos_tb(id_sala)

)auto_increment = 1000000;
 
alter table cliente_atleta_tb add column fk_id_sala int;
alter table cliente_atleta_tb add 
constraint FK_SALA_AULA
foreign key (fk_id_sala)
references sala_alunos_tb(id_sala);

alter table planos_assesoria_tb add column fk_id_formpag int;
alter table planos_assesoria_tb add 
constraint FK_FORMA_PAG
foreign key (fk_id_formpag)
references forma_pagamento_tb(id_formpag);


alter table treinos_tb add column descricao_part1 varchar(200);
alter table treinos_tb add column descricao_part2 varchar(200);


alter table planos_assesoria_tb add column qtd_alunos varchar(20);

create table fatura_andamento_tb
(
idFatura_and int not null auto_increment,
data_vencimento date ,
local_agendado varchar(45),
fk_id_cli_asses int not null,
fk_id_plan   int not null,
fk_id_formpag int not null,

constraint PK_FAT_AND
primary key (idFatura_and),
constraint FK_PLANO
foreign key (fk_id_plan)
references planos_assesoria_tb(id_plano),
constraint FK_FORM_PAG
foreign key (fk_id_formpag)
references forma_pagamento_tb(id_formpag)

)auto_increment = 1000;

create table fatura_concluida_tb
(
idFatura_conc int not null auto_increment,
data_pagamento date ,
valor_pago varchar(45),
fk_id_cli_asses int not null,
fk_id_plan   int not null,
fk_id_formpag int not null,

constraint PK_FAT_CON
primary key (idFatura_conc),
constraint FK_PLANO_FAT
foreign key (fk_id_plan)
references planos_assesoria_tb(id_plano),
constraint FK_FORM_PAG_FAT
foreign key (fk_id_formpag)
references forma_pagamento_tb(id_formpag)
)auto_increment = 10000;





