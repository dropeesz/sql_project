<div align="center">

# 🗄️ SQL Project

![SQL](https://img.shields.io/badge/SQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![Status](https://img.shields.io/badge/Status-Conclu%C3%ADdo-success?style=for-the-badge)
![Project](https://img.shields.io/badge/Type-Database%20Project-blue?style=for-the-badge)

Projeto de banco de dados com SQL e modelo relacional.

</div>

---

## 📌 Sobre o Projeto

Este é um projeto focado no desenvolvimento de **modelagem e estruturação de banco de dados SQL**.  
Ele contém scripts para criação de tabelas, definição de relacionamentos e consultas que exemplificam uso de chaves primárias/estrangeiras, normalização e manipulação de dados.

O projeto demonstra:

- Modelagem de um banco de dados realista  
- Criação de tabelas e relações  
- Inserção de dados  
- Consultas avançadas (joins, filtros, ordenação)  
- Organização de scripts SQL

---

## 🚀 O que este projeto contém

✔️ Modelagem do banco de dados  
✔️ Scripts de criação de tabelas  
✔️ Scripts de inserção de dados  
✔️ Consultas SQL de exemplo  
✔️ Relacionamentos entre entidades

---

## 📂 Estrutura Completa

```
sql_project/
├── create_tables.sql      # Cria todas as tabelas
├── insert_data.sql        # Insere dados de exemplo
├── queries.sql            # Exemplos de consultas
├── README.md              # Documentação do projeto
```

---

## 🛠️ Tecnologias Utilizadas

| Ferramenta | Uso |
|------------|------|
| **SQL**     | Linguagem de consultas e manipulação de dados |
| **MySQL** *(ou outro SGBD)* | Gerenciador de banco de dados para execução dos scripts |
| **Workbench / DBeaver / HeidiSQL** | Ferramentas recomendadas para visualização |

---

## 🧠 O que foi aplicado

Este projeto serve para demonstrar:

📌 Criação de tabelas com chaves primárias  
📌 Definição de chaves estrangeiras  
📌 Normalização de dados  
📌 Inserção de dados em massa  
📌 Consultas com filtros, ordenação e join  
📌 Visão prática de fluxo de dados em banco relacional

---

## 🧩 Como Usar

1. Abra seu SGBD (MySQL, MariaDB, PostgreSQL etc.)
2. Crie um novo database (ex: `sql_project_db`)
3. Rode o script de criação de tabelas:

```sql
SOURCE create_tables.sql;
```

4. Insira dados:

```sql
SOURCE insert_data.sql;
```

5. Teste as consultas:

```sql
SOURCE queries.sql;
```

---

## 📝 Exemplo de Consulta

Aqui vai um exemplo de um SELECT com JOIN extraído do `queries.sql`:

```sql
SELECT
    aluno.nome AS Nome,
    curso.nome AS Curso
FROM
    aluno
JOIN
    matricula ON aluno.id = matricula.aluno_id
JOIN
    curso ON curso.id = matricula.curso_id;
```

---

## 👨‍💻 Autor

**Pedro Henrique**  
Desenvolvedor focado em qualidade, organização e evolução contínua 🚀
