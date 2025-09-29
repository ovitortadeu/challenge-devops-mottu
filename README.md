# Challenge Java Mottu - Aplicação de Gerenciamento Web e API

## Visão Geral do Projeto (Descrição da Solução)

Este projeto consiste no desenvolvimento de uma aplicação completa para o Challenge Mottu. A solução inclui uma **API REST** robusta para gerenciar entidades como `Usuários` e `Veículos`, e uma **Aplicação Web** com interface visual para interação e gerenciamento dos dados, construída com Thymeleaf e protegida por Spring Security.

A infraestrutura é totalmente provisionada na nuvem **Microsoft Azure** através de scripts de automação (Infraestrutura como Código), e o deploy é contínuo via **GitHub Actions**, garantindo um ciclo de vida de desenvolvimento ágil e moderno.

## Benefícios para o Negócio

A implementação desta solução de gerenciamento de frotas traz benefícios diretos para a Mottu, tais como:

* **Centralização da Gestão:** Unifica o controle de todos os veículos e usuários em uma única plataforma, eliminando planilhas e sistemas descentralizados.
* **Eficiência Operacional:** Automatiza o cadastro, a atualização e a consulta de dados da frota, reduzindo o tempo gasto em tarefas manuais e a probabilidade de erros.
* **Segurança da Informação:** Garante que apenas usuários autorizados acessem os dados, com diferentes níveis de permissão (ADMIN e USER), protegendo informações sensíveis.
* **Tomada de Decisão Baseada em Dados:** Oferece um dashboard com indicadores-chave (total de veículos e usuários), permitindo uma visão rápida e estratégica da operação.
* **Escalabilidade e Agilidade:** Por ser construída sobre serviços PaaS da Azure e ter um pipeline de CI/CD, a solução pode crescer de forma flexível e receber novas funcionalidades de forma rápida e segura.

## Arquitetura da Solução Proposta

A arquitetura foi desenhada utilizando serviços PaaS (Plataforma como Serviço) na Azure para garantir alta disponibilidade, escalabilidade e um ciclo de desenvolvimento ágil.

```
<img width="548" height="611" alt="image" src="https://github.com/user-attachments/assets/2cbd9c29-eb9f-4b29-b4b9-55ffc14d402c" />

```

**Fluxo de Funcionamento:**

1.  **Desenvolvimento e Versionamento:** O código-fonte da aplicação é mantido neste repositório no GitHub.
2.  **CI/CD (Integração e Entrega Contínua):** Qualquer alteração na branch `main` aciona um workflow do GitHub Actions. Esse workflow compila a aplicação Java, gera o artefato `.jar` e o publica automaticamente no Azure App Service.
3.  **Hospedagem da Aplicação:** O **Azure App Service** executa a aplicação Spring Boot, tornando a interface web e a API REST acessíveis pela internet.
4.  **Armazenamento de Dados:** A aplicação se conecta a um **Azure SQL Database**, um serviço de banco de dados gerenciado, onde todos os dados de usuários e veículos são armazenados de forma segura e persistente.
5.  **Interação do Usuário:** O usuário final acessa a aplicação web através de um navegador. As operações de CRUD realizadas na interface são processadas pela aplicação no App Service, que, por sua vez, interage com o banco de dados.

---

## Alunos

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
* [Azure CLI](https://docs.microsoft.com/pt-br/cli/azure/install-azure-cli) instalado.
* Acesso a um terminal com `git` e `bash` (Git Bash no Windows, ou qualquer terminal no Linux/macOS).

### Passo a Passo para o Deploy na Nuvem

1.  **Login na Azure CLI:**
    Abra seu terminal e execute o comando abaixo. Uma janela do navegador será aberta para você fazer o login na sua conta Azure.
    ```bash
    az login
    ```

2.  **Clone o Repositório:**
    ```bash
    git clone [https://github.com/ovitortadeu/challenge-devops-mottu.git](https://github.com/ovitortadeu/challenge-devops-mottu.git)
    cd challenge-devops-mottu
    ```

3.  **Execute o Script de Criação de Recursos:**
    O script `deploy-mottu.sh` criará todos os recursos necessários na Azure (App Service, SQL Database, etc.) e configurará o pipeline de CI/CD com o GitHub Actions.

    *Atenção: O script solicitará autenticação com o GitHub no seu navegador para configurar o deploy. Siga as instruções no terminal.*
    ```bash
    chmod +x "challenge java/demo/deploy-mottu.sh"
    ./challenge java/demo/deploy-mottu.sh
    ```

4.  **Aguarde o Fim do Workflow:**
    Após a execução do script, acesse a aba "Actions" deste repositório no GitHub. Um workflow chamado "Build and deploy JAR app..." terá sido iniciado. Aguarde sua conclusão (o ícone ficará verde).

5.  **Acesse a Aplicação:**
    A URL da sua aplicação será exibida ao final da execução do script, no formato: `http://app-mottu-rm559105.azurewebsites.net`

### Credenciais de Acesso à Aplicação Web

A migração do banco de dados (Flyway) cria dois usuários padrão. Acesse a URL da aplicação e utilize:

* **Perfil Administrador:**
    * **Usuário:** `admin`
    * **Senha:** `admin123`
* **Perfil Usuário Comum:**
    * **Usuário:** `user`
    * **Senha:** `user123`

---

## Testando a API (Exemplos com `curl`)

Após o deploy, você pode testar os endpoints da API usando uma ferramenta como o `curl` ou o Postman.

**1. Obter Token de Autenticação (Login):**
Execute o comando abaixo para se autenticar como `admin` e obter um token JWT.

```bash
curl -X POST [http://app-mottu-rm559105.azurewebsites.net/api/auth/login](http://app-mottu-rm559105.azurewebsites.net/api/auth/login) \
-H "Content-Type: application/json" \
-d '{
    "username": "admin",
    "password": "admin123"
}'
```
*Copie o valor do token retornado para usar nos próximos requests. Vamos armazená-lo em uma variável de ambiente para facilitar.*

```bash
# No Linux/macOS/Git Bash
export TOKEN="COLE_SEU_TOKEN_AQUI"
```

**2. Listar Todos os Usuários (GET):**

```bash
curl -X GET [http://app-mottu-rm559105.azurewebsites.net/api/usuarios](http://app-mottu-rm559105.azurewebsites.net/api/usuarios) \
-H "Authorization: Bearer $TOKEN"
```

**3. Criar um Novo Veículo (POST):**
*Nota: O `usuarioId` deve corresponder a um usuário existente. O usuário `flima` é criado com ID `3` pela migração do banco.*

```bash
curl -X POST [http://app-mottu-rm559105.azurewebsites.net/api/veiculos](http://app-mottu-rm559105.azurewebsites.net/api/veiculos) \
-H "Content-Type: application/json" \
-H "Authorization: Bearer $TOKEN" \
-d '{
    "usuarioId": 3,
    "placaNova": "API1B23",
    "tipoVeiculo": "Motocicleta de Teste via API"
}'
```

**4. Atualizar o Veículo Criado (PUT):**
*Vamos assumir que o veículo criado no passo anterior recebeu o ID `4`.*

```bash
curl -X PUT [http://app-mottu-rm559105.azurewebsites.net/api/veiculos/4](http://app-mottu-rm559105.azurewebsites.net/api/veiculos/4) \
-H "Content-Type: application/json" \
-H "Authorization: Bearer $TOKEN" \
-d '{
    "usuarioId": 3,
    "placaNova": "API1B23",
    "tipoVeiculo": "Motocicleta ATUALIZADA via API"
}'
```

**5. Excluir o Veículo (DELETE):**
*Excluindo o veículo de ID `4`.*

```bash
curl -X DELETE [http://app-mottu-rm559105.azurewebsites.net/api/veiculos/4](http://app-mottu-rm559105.azurewebsites.net/api/veiculos/4) \
-H "Authorization: Bearer $TOKEN"
```
