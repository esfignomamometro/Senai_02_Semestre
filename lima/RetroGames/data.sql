use langames;

insert into jogo (titulo, categoria, preco_hora, imagem_url) values
("Roller Coaster Tycoon", "Simulação / Estratégia", 5.00, "RollerCoaster.jpg"),
("Space Invaders", "Arcade / Shmup", 3.50, "SpaceInvaders.jpg"),
("Mortal Kombat", "Luta", 6.00, "MortalKombat.jpg");

insert into sessao_jogo (id_jogo, horas_jogadas, valor_hora) values
(1, 3, 5.00),
(2, 2, 3.50),
(3, 4, 6.00);

select * from jogo;
select * from sessao_jogo;