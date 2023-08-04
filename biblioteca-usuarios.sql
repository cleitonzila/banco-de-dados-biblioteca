-- Usuario atendete que so pode ler as tabelas
CREATE USER 'atendente'@'localhost' IDENTIFIED BY 'senha';
GRANT SELECT ON library.* TO 'atendente'@'localhost';
-- Usuario gerente que pode ler, inserir e modificar tabelas
CREATE USER 'gerente'@'localhost' IDENTIFIED BY 'senhaMelhor';
GRANT SELECT, INSERT, UPDATE ON library.* TO 'gerente'@'localhost';
