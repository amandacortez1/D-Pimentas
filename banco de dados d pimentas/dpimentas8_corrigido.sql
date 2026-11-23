-- =====================================================
-- BANCO: dpimentas8 (versão corrigida)
-- =====================================================
 create DATABASE dpimentas8;
GO

USE dpimentas8;
GO

-- =====================================================
-- 1. ESTRUTURA DE LOCALIZAÇÃO (UFs, Cidades e CEPs)
-- =====================================================
CREATE TABLE ufs
(
    sigla                CHAR(02)                NOT NULL,
    nome                 VARCHAR(50)             NOT NULL,
    CONSTRAINT           pk_sigla                PRIMARY KEY (sigla)
);
GO

CREATE TABLE cidades
(
    codigo              INT                     NOT NULL,
    nome                VARCHAR(50)             NOT NULL,
    uf_sigla            CHAR(02)                NOT NULL,
    CONSTRAINT          pk_cidades              PRIMARY KEY (codigo),
    CONSTRAINT          fk_ufs_cidades          FOREIGN KEY (uf_sigla) REFERENCES ufs (sigla)
);
GO

CREATE TABLE ceps
(
    nr                   VARCHAR(10)             NOT NULL,
    cidade_codigo        INT                     NOT NULL,
    CONSTRAINT           pk_ceps                 PRIMARY KEY (nr),
    CONSTRAINT           fk_cidades_ceps         FOREIGN KEY (cidade_codigo) REFERENCES cidades (codigo)
);
GO

-- =====================================================
-- 2. PESSOAS, TELEFONES E USUÁRIOS
-- =====================================================
CREATE TABLE pessoas
(
    codigo              INT                     NOT NULL    IDENTITY,
    nome                VARCHAR(50)             NOT NULL,
    cpf                 VARCHAR(12)             NOT NULL,
    cep_nr              VARCHAR(10)             NOT NULL,
    logradouro          VARCHAR(100)            NOT NULL,
    numero              VARCHAR(10)             NOT NULL,
    email               VARCHAR(100)            NULL,
    senha               VARCHAR(50)             NULL,
    nivel_acesso        VARCHAR(20)             NULL,
    CONSTRAINT          pk_pessoas              PRIMARY KEY (codigo),
    CONSTRAINT          uq_pessoas_cpf          UNIQUE (cpf),
    CONSTRAINT          fk_ceps_pessoas         FOREIGN KEY (cep_nr) REFERENCES ceps (nr)
);
GO

CREATE TABLE telefones
(
    pessoa_codigo       INT                     NOT NULL,
    nr                  VARCHAR(15)             NOT NULL,
    CONSTRAINT          pk_telefones            PRIMARY KEY (pessoa_codigo, nr),
    CONSTRAINT          fk_pessoas_telefones    FOREIGN KEY (pessoa_codigo) REFERENCES pessoas (codigo)
);
GO

CREATE TABLE clientes
(
    pessoa_codigo       INT                     NOT NULL,
    estrelas            DECIMAL(2,1)            NOT NULL    DEFAULT 5.0,
    CONSTRAINT          pk_clientes             PRIMARY KEY (pessoa_codigo),
    CONSTRAINT          fk_pessoas_clientes     FOREIGN KEY (pessoa_codigo) REFERENCES pessoas (codigo)
);
GO

CREATE TABLE funcionarios
(
    pessoa_codigo       INT                     NOT NULL,
    salario             DECIMAL(7,2)            NOT NULL,
    CONSTRAINT          pk_funcionarios         PRIMARY KEY (pessoa_codigo),
    CONSTRAINT          fk_pessoas_funcionarios FOREIGN KEY (pessoa_codigo) REFERENCES pessoas (codigo)
);
GO

CREATE TABLE entregadores
(
    pessoa_codigo       INT                     NOT NULL,
    valor_diaria        DECIMAL(7,2)            NOT NULL,
    CONSTRAINT          pk_entregadores         PRIMARY KEY (pessoa_codigo),
    CONSTRAINT          fk_pessoas_entregadores FOREIGN KEY (pessoa_codigo) REFERENCES pessoas (codigo)
);
GO

-- =====================================================
-- 3. CARDÁPIO
-- =====================================================
CREATE TABLE tipos
(
    codigo              INT                     NOT NULL    IDENTITY,
    descricao           VARCHAR(50)             NOT NULL,
    CONSTRAINT          pk_tipos                PRIMARY KEY (codigo)
);
GO

CREATE TABLE tamanhos_marmitex
(
    codigo              INT                     NOT NULL    IDENTITY,
    nome                VARCHAR(50)             NOT NULL,
    preco_base          DECIMAL(10,2)           NOT NULL,
    limite_misturas     INT                     NOT NULL,
    CONSTRAINT          pk_tamanhos_marmitex    PRIMARY KEY (codigo)
);
GO

CREATE TABLE marmitex
(
    codigo                          INT                     NOT NULL    IDENTITY,
    nome                            VARCHAR(50)             NOT NULL, 
    tipo_codigo                     INT                     NOT NULL, 
    preco_adicional                 DECIMAL(10,2)           NOT NULL    DEFAULT 0.00,
    ativo                           BIT                     NOT NULL    DEFAULT 1, -- 1=Disponível, 0=Indisponível
    atualizado_em                   DATETIME                NULL        DEFAULT GETDATE(),
    CONSTRAINT                      pk_marmitex             PRIMARY KEY (codigo),
    CONSTRAINT                      fk_tipos_marmitex       FOREIGN KEY (tipo_codigo) REFERENCES tipos (codigo)
);
GO

CREATE TABLE bebidas
(
    codigo                          INT                     NOT NULL    IDENTITY,
    nome                            VARCHAR(50)             NOT NULL,
    estoque                         INT                     NOT NULL,
    preco                           DECIMAL(10,2)           NOT NULL,
    ativo                           BIT                     NOT NULL    DEFAULT 1, -- 1=Disponível, 0=Indisponível
    atualizado_em                   DATETIME                NULL        DEFAULT GETDATE(),
    CONSTRAINT                      pk_bebidas              PRIMARY KEY (codigo)
);
GO

-- =====================================================
-- 4. ENTREGAS E PEDIDOS
-- =====================================================
CREATE TABLE entregas
(
    codigo              INT                     NOT NULL    IDENTITY,
    data_hora           DATETIME                NOT NULL    DEFAULT GETDATE(),
    status              INT                     NULL        DEFAULT 1,
    entregador_codigo   INT                     NOT NULL,
    CONSTRAINT          pk_entregas             PRIMARY KEY (codigo),
    CONSTRAINT          fk_entregadores_entregas FOREIGN KEY (entregador_codigo) REFERENCES entregadores (pessoa_codigo)
);
GO

CREATE TABLE pedidos
(
    nr                  INT                     NOT NULL    IDENTITY,
    data                DATETIME                NOT NULL    DEFAULT GETDATE(),
    preco               DECIMAL(10,2)           NOT NULL    DEFAULT 0.00,
    status              INT                     NULL        DEFAULT 1,
    tipo_pedido         VARCHAR(20)             NOT NULL    DEFAULT 'retirada',
    observacao_geral    VARCHAR(255)            NULL,
    cliente_codigo      INT                     NOT NULL,
    funcionario_codigo  INT                     NULL,       
    entrega_codigo      INT                     NULL,       
    CONSTRAINT          pk_pedidos              PRIMARY KEY (nr),
    CONSTRAINT          fk_clientes_pedidos     FOREIGN KEY (cliente_codigo)     REFERENCES clientes (pessoa_codigo),
    CONSTRAINT          fk_funcionarios_pedidos FOREIGN KEY (funcionario_codigo) REFERENCES funcionarios (pessoa_codigo),
    CONSTRAINT          fk_entregas_pedidos     FOREIGN KEY (entrega_codigo)     REFERENCES entregas (codigo)
);
GO

CREATE TABLE pedidos_marmitex
(
    pedido_nr           INT                     NOT NULL,
    tamanho_codigo      INT                     NOT NULL,
    marmitex_codigo     INT                     NOT NULL,
    qtd                 INT                     NOT NULL,
    obs_troca           VARCHAR(100)            NULL,
    CONSTRAINT          pk_pedidosmarmitex      PRIMARY KEY (pedido_nr, tamanho_codigo, marmitex_codigo),
    CONSTRAINT          fk_pedidos_pedmarmitex  FOREIGN KEY (pedido_nr)        REFERENCES pedidos (nr),
    CONSTRAINT          fk_tamanho_pedmarmitex  FOREIGN KEY (tamanho_codigo)   REFERENCES tamanhos_marmitex (codigo),
    CONSTRAINT          fk_marmitex_pedmarmitex FOREIGN KEY (marmitex_codigo)  REFERENCES marmitex (codigo)
);
GO

CREATE TABLE pedidos_bebidas
(
    pedido_nr           INT                     NOT NULL,
    bebida_codigo       INT                     NOT NULL,
    qtd                 INT                     NOT NULL,
    CONSTRAINT          pk_pedidosbebidas       PRIMARY KEY (pedido_nr, bebida_codigo),
    CONSTRAINT          fk_pedidos_pedbebidas   FOREIGN KEY (pedido_nr)       REFERENCES pedidos (nr),
    CONSTRAINT          fk_bebidas_pedbebidas   FOREIGN KEY (bebida_codigo)   REFERENCES bebidas (codigo)
);
GO

-- =====================================================
-- 5. TIPOS DE CONTRATO E FOLHA DE PAGAMENTO
-- (criadas por último porque dependem de funcionarios)
-- =====================================================
CREATE TABLE tipos_contratos
(
    codigo              INT                     NOT NULL    IDENTITY,
    descricao           VARCHAR(50)             NOT NULL,
    CONSTRAINT          pk_tipos_contratos      PRIMARY KEY (codigo)
);
GO

CREATE TABLE folha_pagamento_contratos
(
    codigo                          INT                     NOT NULL    IDENTITY,
    funcionario_codigo              INT                     NOT NULL,
    tipo_contrato_codigo            INT                     NOT NULL,
    numero_contrato                 VARCHAR(30)             NOT NULL,
    data_inicio                     DATE                    NOT NULL,
    data_fim                        DATE                    NULL,
    salario_base                    DECIMAL(10,2)           NOT NULL    DEFAULT 0.00,
    adicional                       DECIMAL(10,2)           NOT NULL    DEFAULT 0.00,
    status_contrato                 VARCHAR(20)             NOT NULL    DEFAULT 'ATIVO',
    ativo                           BIT                     NOT NULL    DEFAULT 1,     
    atualizado_em                   DATETIME                NOT NULL    DEFAULT GETDATE(),
    funcionario_atualizacao_codigo  INT                     NULL,                     
    observacao                      VARCHAR(255)            NULL,

    CONSTRAINT pk_folha_pagamento_contratos PRIMARY KEY (codigo),
    
    CONSTRAINT fk_funcionarios_folha_pagamento
        FOREIGN KEY (funcionario_codigo) REFERENCES funcionarios (pessoa_codigo),
        
    CONSTRAINT fk_tipos_contrato_folha
        FOREIGN KEY (tipo_contrato_codigo) REFERENCES tipos_contratos (codigo),
        
    CONSTRAINT fk_funcionarios_atualizacao_folha
        FOREIGN KEY (funcionario_atualizacao_codigo) REFERENCES funcionarios (pessoa_codigo)
);
GO
