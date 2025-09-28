CREATE TABLE TB_MTT_ESTADO ( 
    id INT IDENTITY(1,1) PRIMARY KEY, 
    sigla_estado VARCHAR(2) NOT NULL, 
    nome_estado VARCHAR(25) NOT NULL 
);

CREATE TABLE TB_MTT_CIDADE ( 
    id INT IDENTITY(1,1) PRIMARY KEY, 
    tb_mtt_estado_id INT NOT NULL, 
    nome_cidade VARCHAR(65) NOT NULL, 
    numero_ddd INT NOT NULL 
);

CREATE TABLE TB_MTT_FILIAL ( 
    id INT IDENTITY(1,1) PRIMARY KEY
);

CREATE TABLE TB_MTT_USUARIO ( 
    id INT IDENTITY(1,1) PRIMARY KEY, 
    username VARCHAR(50) NOT NULL UNIQUE, 
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(100) NOT NULL,
    role VARCHAR(20) NOT NULL
);

CREATE TABLE TB_MTT_VEICULO ( 
    id INT IDENTITY(1,1) PRIMARY KEY, 
    tb_mtt_usuario_id INT NOT NULL, 
    placa_antiga VARCHAR(7), 
    placa_nova VARCHAR(10) NOT NULL UNIQUE, 
    tipo_veiculo VARCHAR(75) NOT NULL 
);

CREATE TABLE TB_MTT_CAMERA ( 
    id INT IDENTITY(1,1) PRIMARY KEY, 
    tb_mtt_filial_id INT NOT NULL, 
    modelo VARCHAR(40) NOT NULL 
);

CREATE TABLE TB_MTT_IOT ( 
    id INT IDENTITY(1,1) PRIMARY KEY, 
    tb_mtt_veiculo_id INT NOT NULL, 
    status SMALLINT NOT NULL CHECK (status IN (0, 1)), 
    tipo VARCHAR(30) NOT NULL 
);

CREATE TABLE TB_MTT_LOGRADOURO ( 
    id INT IDENTITY(1,1) PRIMARY KEY, 
    tb_mtt_usuario_id INT, 
    tb_mtt_filial_id INT, 
    tb_mtt_cidade_id INT NOT NULL, 
    nome_logradouro VARCHAR(100) NOT NULL, 
    numero_logradouro VARCHAR(10) NOT NULL, 
    cep VARCHAR(8) NOT NULL,
    complemento VARCHAR(50),
    CONSTRAINT CHK_LOGRADOURO_OWNER CHECK (tb_mtt_usuario_id IS NOT NULL OR tb_mtt_filial_id IS NOT NULL) 
);
