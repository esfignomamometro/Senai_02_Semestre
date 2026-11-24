drop database if exists retro_games;
create database retro_games;
use retro_games;

create table jogos(
    id int not null primary key auto_increment,
    nome varchar(50) not null,
    desenvolvedora varchar(50) not null,
    genero varchar(50) not null,
    imagem text(500) not null,
    preco decimal(10,2) not null
);

insert into jogos (nome, desenvolvedora, genero, imagem, preco) values
("Zelda Ocarina of Time", "Nintendo", "Aventura", "https://upload.wikimedia.org/wikipedia/pt/d/db/The_Legend_of_Zelda_Ocarina_of_Time_3D_arte...", 88.00),
("Pokémon FireRed", "GameFreak", "RPG de turnos", "https://m.media-amazon.com/images/I/71iLh5opvHL._AC_UF1000,1000_QL80_.jpg", 88.00),
("Kirby & the Amazing Mirror", "HAL Laboratory", "Plataforma", "https://upload.wikimedia.org/wikipedia/en/0/0b/Kirby_%26_the_Amazing_Mirror.jpg", 88.00);

select * from jogos;