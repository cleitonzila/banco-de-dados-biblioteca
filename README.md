# 📚 Sistema de Banco de Dados para Biblioteca

Este projeto tem como objetivo implementar um banco de dados relacional eficiente para um sistema de biblioteca, permitindo o gerenciamento de empréstimos, devoluções, categorias, multas e visualizações de dados importantes sobre o acervo.

## 🎯 Objetivo

Facilitar o controle de livros em uma biblioteca, permitindo operações como:

- Registro de usuários, livros, autores e categorias;
- Empréstimos e devoluções;
- Controle de multas por atraso;
- Consultas e visualizações de dados relevantes.

## 🧱 Entidades do Banco de Dados

O banco de dados foi modelado com as seguintes entidades:

- **Usuário**: `user_id`, `user_name`, `address`, `phone`
- **Livro**: `isbn`, `title`, `author_id`, `category_id`, `publication_date`
- **Autor**: `author_id`, `author_name`
- **Categoria**: `category_id`, `category_name`
- **Empréstimo**: `loan_id`, `user_id`, `isbn`, `loan_date`, `return_date`, `status`
- **Multa**: `fine_id`, `loan_id`, `fine_amount`, `issued_date`, `paid`
- **Registro de Empréstimo**: `log_id`, `loan_id`, `action_type`, `session_user`, `session_date`, `session_time`
- **Registro de Multa**: `log_id`, `fine_id`, `action_type`, `session_user`, `session_date`, `session_time`

## 🔄 Relacionamentos

- Um **usuário** pode realizar múltiplos **empréstimos**;
- Um **livro** pode estar associado a muitos **empréstimos**;
- Um **autor** pode escrever vários **livros**;
- Um **livro** pertence a uma única **categoria**;
- Um **empréstimo** pode gerar várias **multas** e **registros**;
- Uma **multa** pode ter vários **registros**.

## 👁️ Visualizações

- **numberOfBooksPerAuthor**: total de livros por autor.
- **booksAndCategories**: livros com suas categorias.
- **borrowedBooks**: livros emprestados ainda não devolvidos.
- **unpaidFines**: multas em aberto por usuário.
- **numberOfLoans**: número de empréstimos por usuário.

## 🧮 Funções

- `totalUserFine(user_id)`: retorna o total de multas não pagas de um usuário.
- `totalUserBooksHolding(user_id)`: retorna o número de livros ainda emprestados por um usuário.

## ⚙️ Procedimentos Armazenados

- `OrderByParameterInTable(tableName, columnName, sortOrder)`: ordena qualquer tabela.
- `AddBook(isbn, title, author_id, category_id, publication_date)`: insere um novo livro.
- `PayFine(user_id)`: marca multas pendentes de um usuário como pagas.

## 👤 Gerenciamento de Usuários

- **Atendente**: possui somente leitura (`SELECT`) nas tabelas.
- **Gerente**: possui leitura, inserção e atualização (`SELECT`, `INSERT`, `UPDATE`).

```sql
-- Criação do usuário atendente
CREATE USER 'atendente'@'localhost' IDENTIFIED BY 'senha';
GRANT SELECT ON library.* TO 'atendente'@'localhost';

-- Criação do usuário gerente
CREATE USER 'gerente'@'localhost' IDENTIFIED BY 'senhaMelhor';
GRANT SELECT, INSERT, UPDATE ON library.* TO 'gerente'@'localhost';
