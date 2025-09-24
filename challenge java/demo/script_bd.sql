-- ====================================================================================
-- SEÇÃO 1: CRIAÇÃO DAS TABELAS
-- ====================================================================================

CREATE TABLE TB_MTT_USUARIO (
    id INT IDENTITY(1,1) PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(100) NOT NULL,
    role VARCHAR(20) NOT NULL
);
COMMENT ON TABLE TB_MTT_USUARIO IS 'Armazena informações dos usuários do sistema.';
COMMENT ON COLUMN TB_MTT_USUARIO.role IS 'Define o nível de permissão do usuário.';


-- Tabela para armazenar os veículos da frota da Mottu
CREATE TABLE TB_MTT_VEICULO (
    id INT IDENTITY(1,1) PRIMARY KEY,
    tb_mtt_usuario_id INT NOT NULL, 
    placa_antiga VARCHAR(7),
    placa_nova VARCHAR(10) NOT NULL UNIQUE,
    tipo_veiculo VARCHAR(75) NOT NULL
);
COMMENT ON TABLE TB_MTT_VEICULO IS 'Armazena os detalhes dos veículos da frota.';
COMMENT ON COLUMN TB_MTT_VEICULO.tb_mtt_usuario_id IS 'Referência ao ID do usuário proprietário do veículo na tabela TB_MTT_USUARIO.';

-- ====================================================================================
-- SEÇÃO 2: ADIÇÃO DE CHAVES ESTRANGEIRAS (FOREIGN KEYS)
-- ====================================================================================

ALTER TABLE TB_MTT_VEICULO ADD CONSTRAINT FK_VEICULO_USUARIO
FOREIGN KEY (tb_mtt_usuario_id) REFERENCES TB_MTT_USUARIO(id);

-- ====================================================================================
-- SEÇÃO 3: INSERÇÃO DE DADOS INICIAIS (AMOSTRA)
-- ====================================================================================

INSERT INTO TB_MTT_USUARIO (username, email, senha, role) VALUES 
('admin', 'admin@mottu.com', '$2a$10$8.g9j.yL5Yk4P6c.B..ZFe3v2u6jB5/A1aM2w0i.w8c7.pS2R2o/q', 'ADMIN');

INSERT INTO TB_MTT_USUARIO (username, email, senha, role) VALUES 
('user', 'user@mottu.com', '$2a$10$Y1/yJ.Q/dD2A8.pOR8h3UuG8p2f/aI5uKb.bY/1j9/x8C8e3U0jS.', 'USER');

INSERT INTO TB_MTT_VEICULO (tb_mtt_usuario_id, placa_nova, tipo_veiculo) VALUES 
((SELECT id FROM TB_MTT_USUARIO WHERE username = 'user'), 'BRA2E19', 'Motocicleta');