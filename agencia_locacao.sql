create database agencia_locacao;
use agencia_locacao;
create table clientes (
cadastro int primary key not null auto_increment,
nome varchar (40) not null,
endereco int not null,
email varchar (40) not null,
telefone1 varchar (15) not null,
telefone2 varchar (15)
);
create table enderecos (
id int primary key not null auto_increment,
logradouro varchar (50) not null,
numero int,
complemento varchar (10),
cep varchar (8) not null,
cidade varchar (30) not null,
estado enum ("AC", "AL", "AM", "AP", "BA", "CE", "DF", "ES", "GO", "MA", "MG", "MS", "MT", "PA", "PB", "PE" , "PI", "PR", "RJ", "RN", "RO", "RR", "RS", "SC", "SE", "SP", "TO")
);
create table veiculos (
chassi varchar (17) primary key not null,
placa varchar (7) not null,
modelo varchar (10) not null,
ano year not null,
cor varchar (15) not null,
tamanho varchar (12) not null,
disponivel bit
);
create table funcionarios (
registro int primary key not null auto_increment,
nome varchar (40) not null,
funcao varchar (20) not null,
endereco int
);
create table movimento (
protocolo_movimento int primary key not null auto_increment,
data_retirada date not null,
data_devolucao date,
valor decimal (6, 2),
cliente int,
veiculo varchar (17),
funcionario int
);
create table oficina (
protocolo_oficina int primary key not null auto_increment,
servico enum ("lavagem", "manutenção"),
data_saida date not null,
data_volta date,
custo decimal (6, 2),
veiculo varchar (17),
funcionario int
);
alter table clientes add foreign key (endereco) references enderecos(id);
alter table funcionarios add foreign key(endereco) references enderecos(id);
alter table oficina add foreign key(veiculo) references veiculos(chassi);
alter table oficina add foreign key(funcionario) references funcionarios(registro);
alter table movimento add foreign key (cliente) references clientes(cadastro);
alter table movimento add foreign key (veiculo) references veiculos(chassi);
alter table movimento add foreign key (funcionario) references funcionarios(registro);
insert into enderecos (logradouro, numero, complemento, cep, cidade, estado) values
("Avenida José Maria Salgado", 556, null, "04587662", "São Loredo dos Pinhais", "SE"),
("Travessa Firmino Pimpão", 12, "B", "38629552", "Vilarroyal", "AC"),
("Praça Visconde Baboso", null, "S/N", "84632754", "Cabrobó do Norte", "RS"),
("Rua das Ovelhas", 3401, "Apto 5C", "25478558", "Nova Mirassol", "PR"),
("Rua Trancoso Fielpe", 99, null, "45879665", "Silmaria", "AP"),
("Alameda Sargento Felisberto", 557, "B", "01328791", "Valência do Sul", "SC"),
("Avenida Sassafrás", 72, null, "38568442", "Ilhamedia", "SP"),
("Rua Bijú", 144, "Fundos", "02185666", "Salto do Pica-Pau", "RJ"),
("Alameda dos Anjos", 37, "Bloco A", "07542123", "Pirassuviba", "MA"); 
insert into clientes (nome, endereco, email, telefone1, telefone2) values
("Raul Glória", 1, "orialraul@yuppii.com", "(11)99857-4213","(11)2274-6983"),
("Stefanie Aguirre Lima", 2, "s_a_l@gmail.com", "(21)98857-1123", null),
("Gilson Leite", 3, "g.milk@hometail.com.ar", "(81)5479-1775", null),
("Sven Kaffemensch", 4, "co-hi-@server.com", "(28)97854-6635", "(28)4421-8880"),
("Glória Glória", 1, "gloriagloria_iknowright@yuppii.com", "(17)97841-0051", "(11)2274-6983");
insert into funcionarios (nome, funcao, endereco) values
("Romildo Suárez de la Mancha Ruiz y López", "Supervisor geral", 5),
("Sandra Bivouac", "TI", 6),
("Arlindo Barata", "Gerente de RH", 7),
("Sildra Vila Salgado", "Motorista", 8),
("Orlando Hortêncio Fulô", "Atendente", 9);
insert into veiculos values
("8BRPGTRCVS5788457", "HRT0063", "Corsa", 2017, "Branco", "Médio", 1),
("4BRYTHDBWW2315488", "DBG5T65", "Celta", 2020, "Preto", "Compacto", 0),
("2BRUOJNNES8871142", "CDZ1288", "Voyage", 2019, "Prata", "Esportivo", 1),
("9BROOPAACE5563733", "KOF1997", "Chrysler", 2022, "Azul escuro", "Grande", 1),
("7BRNUFISYB0018149", "JOJ8O05", "Montana", 2018, "Vermelho vivo", "Pickup", 0);
insert into oficina (servico, data_saida, data_volta, custo, veiculo, funcionario) values
("lavagem", "2021-12-01", "2021-12-03", 70.5, "2BRUOJNNES8871142", 4),
("manutenção", "2021-12-12", "2021-12-21", 324.84, "7BRNUFISYB0018149", 1),
("lavagem", "2022-01-10", "2022-01-12", 41.39, "8BRPGTRCVS5788457", 5),
("lavagem", "2022-02-02", "2022-02-06", 51.8, "9BROOPAACE5563733", 4),
("manutenção", "2022-06-20", null, 280.77, "4BRYTHDBWW2315488", 1);
insert into movimento (data_retirada, data_devolucao, valor, cliente, veiculo, funcionario) values
("2022-06-01", "2022-06-16", 400.12, 2, "7BRNUFISYB0018149", 4),
("2022-06-02", null, 600.40, 1, "4BRYTHDBWW2315488", 5),
("2022-06-04", "2022-06-20", 240.85, 3, "2BRUOJNNES8871142", 4),
("2022-06-18", null, 340.18, 2, "7BRNUFISYB0018149", 4),
("2022-06-18", "2022-06-21", 101.2, 4, "9BROOPAACE5563733", 5);
create view lista_de_clientes as
select clientes.cadastro, clientes.nome, enderecos.logradouro, enderecos.numero, enderecos.complemento, enderecos.cep
from clientes inner join enderecos where clientes.endereco = enderecos.id;
create view lista_de_funcionarios as
select funcionarios.registro, funcionarios.nome, funcionarios.funcao, enderecos.logradouro, enderecos.numero, enderecos.complemento, enderecos.cep
from funcionarios
inner join enderecos where funcionarios.endereco=enderecos.id;
create view lista_de_movimentos as
select movimento.protocolo_movimento as protocolo, clientes.nome as cliente, veiculos.modelo, veiculos.placa, 
movimento.data_retirada, movimento.data_devolucao, funcionarios.nome as funcionario
from movimento inner join clientes on movimento.cliente = clientes.cadastro
inner join veiculos on movimento.veiculo = veiculos.chassi
inner join funcionarios on movimento.funcionario = funcionarios.registro;
create view servicos_oficina as
select oficina.protocolo_oficina as protocolo, veiculos.modelo, veiculos.placa, 
oficina.servico, oficina.data_saida, oficina.data_volta, oficina.custo, funcionarios.nome as responsavel
from oficina inner join veiculos on oficina.veiculo = veiculos.chassi
inner join funcionarios on oficina.funcionario = funcionarios.registro;
create user "sys_admin" identified by "senhaforte";
grant all privileges on *.* to "sys_admin";
create user "atendente_janine" identified by "senhadajanine";
grant insert, select, update, delete on clientes.* to "atendente_janine";
create user "bola_do_rh" identified by "senhadobola";
grant all privileges on funcionarios.* to "bola_do_rh";
create user "atendente_nilberto" identified by "senhanilba";
grant select on veiculos.* to "atendente_nilberto";
grant select, insert, update on movimento.* to "atendente_nilberto";
grant select, insert, update on oficina.* to "atendente_nilberto";
create user "fafa_aquisicoes" identified by "fafasenhafafa";
grant insert, delete, select on veiculos.* to "fafa_aquisicoes";