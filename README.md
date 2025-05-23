# Challenge Java Mottu - API de Gerenciamento

## Visão Geral do Projeto

Este projeto consiste no desenvolvimento de uma API REST para dar suporte à solução do Challenge Mottu. A API visa gerenciar entidades cruciais para as operações da Mottu, como Usuários (clientes) e Veículos (motos). Nesta primeira sprint, focamos em estabelecer uma base robusta com funcionalidades de CRUD completas para essas duas entidades principais, além de implementar a infraestrutura de segurança e boas práticas de desenvolvimento.

---

## Aluno(s)

*  VITOR TADEU SOARES DE SOUSA - RM559105
*  PEDRO PAULO BARRETTA - RM556370
*  GIOVANNI DE SOUZA LIMA - RM5566536

---

## Relevância para o Challenge Mottu

A API de Gerenciamento Mottu é fundamental para otimizar e digitalizar os processos da empresa. Ao fornecer um sistema centralizado para:

*   **Cadastro e Autenticação de Usuários:** Permite que clientes e entregadores acessem a plataforma de forma segura, gerenciando seus perfis e interações.
*   **Gerenciamento de Veículos:** Facilita o registro, acompanhamento e manutenção da frota de motocicletas, essencial para a logística dos pátios da Mottu.

Esta infraestrutura inicial é o pilar para futuras funcionalidades como rastreamento, gerenciamento de filiais, e integração com dispositivos IoT, todas visando aumentar a eficiência operacional, melhorar a experiência do usuário e fornecer dados valiosos para a tomada de decisões estratégicas na Mottu.

---

## Inovação da Solução

A inovação desta solução reside na construção de uma plataforma escalável e modular, preparada para integrar tecnologias avançadas e otimizar a logística da Mottu:

*   **Foco na Experiência do Usuário:** Desde o início, a API é projetada pensando na facilidade de integração com aplicativos móveis e web, visando uma experiência fluida para entregadores e clientes.
*   **Preparação para Análise de Dados:** A estrutura de dados e os endpoints são pensados para facilitar a coleta e posterior análise de informações, permitindo à Mottu otimizar rotas, prever demandas e melhorar a alocação de recursos.
*   **Arquitetura Orientada a Serviços:** A API adota uma arquitetura que facilita a adição de novos microsserviços ou módulos no futuro (ex: serviço de geolocalização, serviço de notificação, etc.), garantindo a evolução contínua da plataforma sem grandes refatorações.
---

## Tecnologias Utilizadas

*   **Linguagem:** Java 21
*   **Framework Principal:** Spring Boot 3.2.5 
    *   Spring Web (Criação de API REST)
    *   Spring Data JPA (Acesso a dados)
    *   Spring Security (Autenticação e Autorização com JWT)
    *   Spring Validation (Bean Validation)
    *   Spring Cache (Otimização de requisições)
*   **Banco de Dados:**
    *   Oracle (Ambiente principal
*   **Mapeamento Objeto-Relacional (ORM):** Hibernate (via Spring Data JPA)
*   **Mapeamento DTO-Entidade:** MapStruct
*   **Utilitários:** Lombok
*   **Documentação da API:** SpringDoc OpenAPI (Swagger)
*   **Autenticação:** JSON Web Tokens (JWT)
*   **Build Tool:** Apache Maven

---

## Funcionalidades Implementadas (1ª Sprint)

Conforme os requisitos técnicos da sprint:

1.  **CRUD Completo para Usuários:**
    *   Registro de novos usuários (com hash de senha).
    *   Busca de usuário por ID.
    *   Listagem paginada e ordenada de usuários.
    *   Atualização de dados do usuário.
    *   Deleção de usuário.
    *   Autenticação de usuários (geração de token JWT).
2.  **CRUD Completo para Veículos:**
    *   Cadastro de novos veículos associados a um usuário.
    *   Busca de veículo por ID.
    *   Listagem paginada e ordenada de todos os veículos.
    *   Listagem de veículos por ID do usuário.
    *   Atualização de dados do veículo.
    *   Deleção de veículo.
3.  **Relacionamento entre Entidades:** `Veiculo` possui um relacionamento `@ManyToOne` com `Usuario`.
4.  **Validação de Campos:** Utilização de Bean Validation nos DTOs de entrada.
5.  **Paginação e Ordenação de Resultados:** Implementado nos endpoints de listagem de Usuários e Veículos.
6.  **Busca por Parâmetros:** Busca por ID e por ID do usuário (para veículos).
7.  **Cache para Otimização:** Implementado cache em métodos de busca por ID para as entidades `Usuario` e `Veiculo` para melhorar a performance.
8.  **Boas Práticas de Design REST:**
    *   Uso semântico de métodos HTTP (GET, POST, PUT, DELETE).
    *   URIs intuitivas e baseadas em recursos.
    *   Retorno de códigos de status HTTP apropriados.
9.  **Tratamento Centralizado de Erros:** Implementado com `@ControllerAdvice` para exceções personalizadas e erros comuns.
10. **Utilização de DTOs:** Para desacoplar a API da estrutura interna das entidades e para validação de dados de entrada/saída.
11. **Segurança:** Autenticação baseada em JWT para proteger os endpoints da API.

---

## Instruções para Execução do Projeto

### Pré-requisitos

*   JDK 21 ou superior instalado.
*   Apache Maven 3.6.+ instalado.
*   
### Passos para Executar

1.  **Clone o Repositório:**
    ```bash
    git clone https://github.com/ovitortadeu/challenge-java-springboot
    cd ChallengeJavaMottu
    ```

2.  **Compile e Execute a Aplicação com Maven:**
    ```bash
    mvn spring-boot:run
    ```
    A aplicação estará disponível, por padrão, em `http://localhost:8080`.

### Acessando a API e Documentação

*   **Documentação Swagger (OpenAPI):** Após iniciar a aplicação, acesse:
    `http://localhost:8080/swagger-ui.html`
*   **Endpoints Principais (requerem autenticação JWT após o login/registro):**
    *   **Autenticação:**
        *   `POST /usuarios` (para criar um novo usuário)
        *   `POST /auth/login` (para obter um token JWT)
    *   **Usuários:**
        *   `GET /usuarios`
        *   `GET /usuarios/{id}`
        *   `PUT /usuarios/{id}`
        *   `DELETE /usuarios/{id}`
    *   **Veículos:**
        *   `POST /veiculos`
        *   `GET /veiculos`
        *   `GET /veiculos/{id}`
        *   `GET /veiculos/usuario/{usuarioId}`
        *   `PUT /veiculos/{id}`
        *   `DELETE /veiculos/{id}`

    **Nota sobre Autenticação:** Para acessar os endpoints protegidos, primeiro obtenha um token JWT através do endpoint `/auth/login` com seu username e password. Inclua este token no header `Authorization` das suas requisições como `Bearer SEU_TOKEN_JWT`.

---

## Próximos Passos (Futuras Sprints)

Para as próximas sprints, planejamos expandir a API com as seguintes entidades e funcionalidades:

*   **Entidades Adicionais:** Implementação do CRUD e lógica de negócios para `Camera`, `Cidade`, `Estado`, `Filial`, `Iot`, e `Logradouro`.
*   **Funcionalidades de Negócio:**
    *   Associação de dispositivos IoT a veículos.
    *   Gerenciamento de endereços para usuários e filiais.
    *   Registro e monitoramento de câmeras em filiais.
*   **Testes:** Aumento da cobertura de testes unitários e de integração.
*   **Melhorias:** Refinamento do tratamento de erros, otimizações de performance adicionais.

---
