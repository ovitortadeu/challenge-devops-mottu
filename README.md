# Challenge Java Mottu - Aplicação de Gerenciamento Web e API

## Visão Geral do Projeto

Este projeto consiste no desenvolvimento de uma aplicação completa para dar suporte à solução do Challenge Mottu. A solução inclui uma **API REST** robusta para gerenciar entidades como `Usuários` e `Veículos`, e uma **Aplicação Web** com interface visual para interação e gerenciamento dos dados, construída com Thymeleaf e protegida por Spring Security.

Nesta 3ª Sprint, o foco foi transformar a API base em uma aplicação web funcional, com autenticação, versionamento de banco de dados e uma interface para o CRUD de Veículos.

## Benefícios para o Negócio

A implementação desta solução de gerenciamento de frotas traz benefícios diretos para a Mottu, tais como:

* **Centralização da Gestão:** Unifica o controle de todos os veículos e usuários em uma única plataforma, eliminando planilhas e sistemas descentralizados.
* **Eficiência Operacional:** Automatiza o cadastro, a atualização e a consulta de dados da frota, reduzindo o tempo gasto em tarefas manuais e a probabilidade de erros.
* **Segurança da Informação:** Garante que apenas usuários autorizados acessem os dados, com diferentes níveis de permissão (ADMIN e USER), protegendo informações sensíveis.
* **Tomada de Decisão Baseada em Dados:** Oferece um dashboard com indicadores-chave (total de veículos e usuários), permitindo uma visão rápida e estratégica da operação.
* **Escalabilidade:** Por ser construída sobre serviços de nuvem PaaS da Azure, a solução pode crescer de forma flexível conforme a demanda do negócio aumenta, sem a necessidade de grandes investimentos em infraestrutura física.

## Arquitetura da Solução Proposta

A arquitetura foi desenhada utilizando serviços PaaS (Plataforma como Serviço) na Azure para garantir alta disponibilidade, escalabilidade e um ciclo de desenvolvimento ágil.

```
+-------------------+      +--------------------------------+      +------------------------+
|                   |      |                                |      |                        |
|  Usuário (Admin)  |----->|     Azure App Service          |----->|    Azure SQL Database  |
|                   |      |  (app-mottu-rm559105)          |      |    (mottu-db)          |
+-------------------+      |                                |      |                        |
                         |  - Aplicação Java (Spring Boot)  |      +------------------------+
                         |  - Endpoints REST API (/api)     |
                         |  - Interface Web (Thymeleaf)     |
                         +--------------------------------+
                                       ^
                                       | Deploy Automatizado (CI/CD)
                                       |
                         +--------------------------------+
                         |                                |
                         |        GitHub & Actions        |
                         | (Repositório com Código-Fonte) |
                         +--------------------------------+
```

**Fluxo de Funcionamento:**

1.  **Desenvolvimento e Versionamento:** O código-fonte da aplicação é mantido em um repositório no GitHub.
2.  **CI/CD (Integração e Entrega Contínua):** Qualquer alteração na branch `main` aciona um workflow do GitHub Actions. Esse workflow compila a aplicação Java, gera o artefato `.jar` e o publica automaticamente no Azure App Service.
3.  **Hospedagem da Aplicação:** O **Azure App Service** executa a aplicação Spring Boot, tornando a interface web e a API REST acessíveis pela internet.
4.  **Armazenamento de Dados:** A aplicação se conecta a um **Azure SQL Database**, um serviço de banco de dados gerenciado na nuvem, onde todos os dados de usuários e veículos são armazenados de forma segura e persistente.
5.  **Interação do Usuário:** O usuário final acessa a aplicação web através de um navegador. As operações de CRUD realizadas na interface são processadas pela aplicação no App Service, que por sua vez, interage com o banco de dados para ler ou escrever os dados.

---

## Aluno(s)

* VITOR TADEU SOARES DE SOUSA - RM559105
* GIOVANNI DE SOUZA LIMA - RM5566536

---

## Tecnologias Utilizadas

* **Linguagem:** Java 21
* **Framework Principal:** Spring Boot 3.2.5
    * Spring Web, Spring Data JPA, Spring Security, Spring Validation
* **Frontend:** Thymeleaf
* **Banco de Dados:** Azure SQL (Cloud) e Flyway (Versionamento)
* **Cloud:** Microsoft Azure (App Service, Azure SQL)
* **CI/CD:** GitHub Actions
* **Infraestrutura como Código:** Azure CLI
* **Documentação da API:** SpringDoc OpenAPI (Swagger)

---

## Instruções para Deploy e Execução

### Pré-requisitos

* Conta ativa na Microsoft Azure.
* [Azure CLI](https://docs.microsoft.com/pt-br/cli/azure/install-azure-cli) instalado e logado (`az login`).
* Conta no GitHub.

### Passo a Passo para o Deploy na Nuvem

1.  **Clone o Repositório:**
    ```bash
    git clone [https://github.com/ovitortadeu/challenge-devops-mottu](https://github.com/ovitortadeu/challenge-devops-mottu)
    cd challenge-devops-mottu
    ```

2.  **Execute o Script de Criação de Recursos:**
    O script `deploy-mottu.sh` criará todos os recursos necessários na Azure (App Service, SQL Database, etc.) e configurará o pipeline de CI/CD com o GitHub Actions.

    *Atenção: O script pode solicitar autenticação com o GitHub no seu navegador para configurar o deploy.*
    ```bash
    chmod +x "challenge java/demo/deploy-mottu.sh"
    ./challenge java/demo/deploy-mottu.sh
    ```

3.  **Aguarde o Fim do Workflow:**
    Após a execução do script, acesse a aba "Actions" do seu repositório no GitHub. Um workflow chamado "Build and deploy JAR app to Azure Web App" terá sido iniciado. Aguarde sua conclusão.

4.  **Acesse a Aplicação:**
    A URL da sua aplicação será exibida ao final da execução do script, no formato: `http://app-mottu-rm559105.azurewebsites.net`

### Credenciais de Acesso

A migração do banco de dados (Flyway) cria dois usuários padrão:

* **Perfil Administrador:**
    * **Usuário:** `admin`
    * **Senha:** `admin123`
* **Perfil Usuário Comum:**
    * **Usuário:** `user`
    * **Senha:** `user123`

### Testando a API (Exemplos)

Após o deploy, você pode testar os endpoints da API usando uma ferramenta como o `curl` ou o Postman.

1.  **Obter Token de Autenticação (Login):**
    ```bash
    curl -X POST [http://app-mottu-rm559105.azurewebsites.net/api/auth/login](http://app-mottu-rm559105.azurewebsites.net/api/auth/login) \
    -H "Content-Type: application/json" \
    -d '{
        "username": "admin",
        "password": "admin123"
    }'
    ```
    *Copie o token retornado para usar nos próximos requests.*

2.  **Listar Veículos (GET):**
    ```bash
    curl -X GET [http://app-mottu-rm559105.azurewebsites.net/api/veiculos](http://app-mottu-rm559105.azurewebsites.net/api/veiculos) \
    -H "Authorization: Bearer SEU_TOKEN_AQUI"
    ```

3.  **Criar um Novo Veículo (POST):**
    *Primeiro, obtenha o ID de um usuário existente (ex: user = 2, flima = 3).*
    ```bash
    curl -X POST [http://app-mottu-rm559105.azurewebsites.net/api/veiculos](http://app-mottu-rm559105.azurewebsites.net/api/veiculos) \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer SEU_TOKEN_AQUI" \
    -d '{
        "usuarioId": 3,
        "placaNova": "XYZ1A23",
        "tipoVeiculo": "Motocicleta de Teste"
    }'
    ```
