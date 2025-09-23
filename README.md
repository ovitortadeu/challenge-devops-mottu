# Challenge Java Mottu - Aplicação de Gerenciamento Web e API

## Visão Geral do Projeto

Este projeto consiste no desenvolvimento de uma aplicação completa para dar suporte à solução do Challenge Mottu. A solução inclui:
1.  Uma **API REST** robusta para gerenciar entidades cruciais como `Usuários` e `Veículos`.
2.  Uma **Aplicação Web** com interface visual para interação e gerenciamento dos dados, construída com Thymeleaf e protegida por Spring Security.

Nesta 3ª Sprint, o foco foi transformar a API base em uma aplicação web funcional, com autenticação, versionamento de banco de dados e uma interface para o CRUD de Veículos.

---

## Aluno(s)

*   VITOR TADEU SOARES DE SOUSA - RM559105
*   GIOVANNI DE SOUZA LIMA - RM5566536

---

## Tecnologias Utilizadas (3ª Sprint)

*   **Linguagem:** Java 21
*   **Framework Principal:** Spring Boot 3.2.5
    *   Spring Web
    *   Spring Data JPA
    *   Spring Security
    *   Spring Validation
*   **Frontend:**
    *   **Thymeleaf** com Fragmentos (Layout Engine)
*   **Banco de Dados:**
    *   Oracle (Ambiente principal)
    *   **Flyway (Versionamento de Schema)**
*   **Mapeamento Objeto-Relacional (ORM):** Hibernate
*   **Mapeamento DTO-Entidade:** MapStruct
*   **Documentação da API:** SpringDoc OpenAPI (Swagger)
*   **Autenticação:** Formulário (Web) e JSON Web Tokens (JWT para a API)
*   **Build Tool:** Apache Maven

---

## Funcionalidades Implementadas (Até a 3ª Sprint)

### Aplicação Web (Foco da 3ª Sprint)
*   **Interface de Gerenciamento de Veículos:** Páginas para Listar, Criar, Editar e Excluir veículos.
*   **Autenticação Segura:** Sistema de login e logout via formulário.
*   **Controle de Acesso por Papel:**
    *   **ADMIN:** Acesso total ao CRUD de veículos e a um dashboard de indicadores.
    *   **USER:** Acesso de apenas leitura aos seus próprios veículos.
*   **Fluxos Não-CRUD:**
    1.  **Dashboard de Indicadores:** Página que exibe o total de usuários e veículos cadastrados.
    2.  **Visualização Condicional:** A lista de veículos é filtrada automaticamente com base no perfil do usuário logado.
*   **Validação de Formulários:** Mensagens de erro são exibidas ao usuário caso os dados inseridos no formulário de veículos sejam inválidos.
*   **Layout Padronizado:** Uso de fragmentos Thymeleaf para garantir uma experiência visual consistente (cabeçalho, rodapé e menu) e evitar repetição de código (DRY).

### API REST (Funcionalidades da 1ª Sprint - Ainda Ativas)
*   **CRUD Completo para Usuários e Veículos** via endpoints REST.
*   **Segurança via JWT** para todos os endpoints da API.
*   **Documentação completa com Swagger/OpenAPI.**

---

## Instruções para Execução do Projeto

### Pré-requisitos

*   JDK 21 ou superior instalado.
*   Apache Maven 3.6.+ instalado.
*   Acesso a um schema Oracle. As credenciais devem ser ajustadas no arquivo `src/main/resources/application.properties`.

### Passos para Executar

1.  **Clone o Repositório:**
    ```bash
    git clone https://github.com/ovitortadeu/challenge-java-springboot
    cd ChallengeJavaMottu
    ```

2.  **Configure o Banco de Dados:**
    *   Abra o arquivo `src/main/resources/application.properties`.
    *   Altere as propriedades `spring.datasource.username` e `spring.datasource.password` para as suas credenciais do Oracle.

3.  **Execute a Aplicação:**
    *   O Flyway criará e populará o banco de dados automaticamente na primeira inicialização.
    ```bash
    mvn spring-boot:run
    ```

---

## Como Usar a Aplicação Web

1.  **Acesse a Página de Login:**
    *   Abra seu navegador e acesse: [http://localhost:8080/](http://localhost:8080/)

2.  **Credenciais de Acesso (pré-cadastradas pelo Flyway):**

    *   **Perfil Administrador:**
        *   **Usuário:** `admin`
        *   **Senha:** `admin123`
        *   **Permissões:** Acesso total ao CRUD de veículos e ao Dashboard.

    *   **Perfil Usuário Comum:**
        *   **Usuário:** `user`
        *   **Senha:** `user123`
        *   **Permissões:** Apenas visualização dos seus próprios veículos.

---

## Como Implementamos os Requisitos da 3ª Sprint

### 1. Thymeleaf (Frontend)
*   **CRUD Completo:** O `VeiculoWebController` possui métodos (`@GetMapping`, `@PostMapping`) que direcionam para as páginas `veiculos/list.html` e `veiculos/form.html`. Essas páginas usam `th:each` para listar, `th:object` para vincular formulários e `th:href` para construir links dinâmicos de edição e exclusão.
*   **Fragmentos (DRY):** Criamos um arquivo `layout.html` que define um cabeçalho (`th:fragment="header"`) e um rodapé (`th:fragment="footer"`). Todas as outras páginas, como `list.html` e `dashboard.html`, incluem esses fragmentos usando `th:replace="~{layout :: header}"`, garantindo consistência visual e evitando repetição de código HTML.

### 2. Flyway (Versionamento de Banco)
*   **Configuração:** Adicionamos a dependência do Flyway no `pom.xml`. O Spring Boot o detecta e executa automaticamente na inicialização, lendo os scripts da pasta `src/main/resources/db/migration`.
*   **4+ Migrações:** Criamos quatro scripts SQL versionados:
    *   `V1__create_tables.sql`: Cria todas as tabelas da aplicação.
    *   `V2__add_foreign_keys.sql`: Adiciona os relacionamentos.
    *   `V3__create_unique_indexes.sql`: Cria os índices.
    *   `V4__insert_sample_data.sql`: Popula o banco com dados iniciais, incluindo os usuários `admin` e `user` com senhas criptografadas.

### 3. Spring Security (Autenticação e Acesso)
*   **Autenticação via Formulário:** Na classe `SecurityConfig`, o método `webSecurityFilterChain` utiliza `.formLogin()` para configurar uma página de login personalizada em `/login` e um processo de logout.
*   **Dois Tipos de Usuário:** A entidade `Usuario` possui um campo `role` do tipo `enum (ADMIN, USER)`. O script do Flyway insere um usuário de cada tipo no banco.
*   **Proteção de Rotas:**
    *   **Por URL:** Usamos `.requestMatchers("/veiculos/new", ...).hasRole("ADMIN")` para garantir que apenas administradores possam acessar as URLs de criação/edição/exclusão.
    *   **Visual:** Nas páginas Thymeleaf, usamos o dialeto de segurança com `sec:authorize="hasRole('ADMIN')"` para exibir ou ocultar botões e links de acordo com o perfil do usuário logado.

### 4. Funcionalidades Completas (Não-CRUD)
*   **Dois Fluxos:**
    1.  **Dashboard de Indicadores:** Criamos o `DashboardController` que busca a contagem de registros nos repositórios (`usuarioRepository.count()`, `veiculoRepository.count()`) e os exibe na página `dashboard.html`.
    2.  **Filtragem de Dados por Perfil:** O método `veiculoService.buscarVeiculosPorPerfil()` verifica o papel do usuário autenticado no `SecurityContextHolder`. Se for `ADMIN`, retorna `findAll()`; se for `USER`, executa uma query customizada (`findByUsuarioUsername`) para retornar apenas os veículos daquele usuário.
*   **Validações:** A entidade `Veiculo` utiliza anotações do Jakarta Bean Validation (`@NotBlank`, `@NotNull`, `@Size`). No `VeiculoWebController`, o método de salvar utiliza a anotação `@Valid`, e a view `form.html` exibe as mensagens de erro com `th:if="${#fields.hasErrors(...)` e `th:errors`.

---

## Desafios e Soluções ("Problemas Possíveis")

Durante a integração do Flyway com um schema Oracle pré-existente e a configuração do Spring Security, encontramos alguns desafios comuns que foram solucionados:

*   **Problema:** Incompatibilidade do hash BCrypt. A senha criptografada inicial não era compatível com a implementação do `PasswordEncoder` do Spring.
    *   **Solução:** Geramos um novo hash diretamente a partir do código da aplicação, garantindo 100% de compatibilidade, e o salvamos no script de migração do Flyway. Isso assegura que qualquer nova instalação do projeto funcionará corretamente.

*   **Problema:** Conflitos na ordem de inicialização entre Flyway e Hibernate, causando erros de "tabela não encontrada" ou "schema não vazio".
    *   **Solução:** Após vários ajustes, a solução definitiva foi garantir que o banco estivesse completamente limpo e usar a configuração padrão do Spring Boot, permitindo que o Flyway construísse o schema do zero sem interferências.

*   **Problema:** Erros de "Mapeamento Ambíguo" entre controllers da API e da Web.
    *   **Solução:** Adotamos a prática de prefixar todos os endpoints da API REST com `/api` (ex: `/api/veiculos`), diferenciando-os claramente das rotas da aplicação web (`/veiculos`).
