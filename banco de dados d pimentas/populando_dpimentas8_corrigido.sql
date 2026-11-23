USE dpimentas8;
GO

SET DATEFORMAT ymd;
GO

-- =============================================
-- 1. ESTADOS
-- =============================================
INSERT INTO ufs (sigla, nome) 
VALUES ('SP', 'São Paulo');

-- =============================================
-- 2. CIDADES
-- =============================================
INSERT INTO cidades (codigo, nome, uf_sigla) 
VALUES (1, 'São José do Rio Preto', 'SP');

-- =============================================
-- 3. CEPS
-- =============================================
INSERT INTO ceps (nr, cidade_codigo) 
VALUES ('15010000', 1),
       ('15015000', 1);

-- =============================================
-- 4. PESSOAS (agora com 10 pessoas para suportar a folha)
-- =============================================
INSERT INTO pessoas (nome, cpf, cep_nr, logradouro, numero, email, senha, nivel_acesso)
VALUES 
-- Funcionários principais
('Carlos Eduardo Silva',   '11111111111', '15010000', 'Rua Independência', '100', 'carlos@dpimentas.com',   '123456', 'admin'),
('Mariana Oliveira',       '22222222222', '15015000', 'Rua XV de Novembro', '250', 'mariana@dpimentas.com',  '123456', 'funcionario'),
-- Entregador
('Lucas Ferreira',         '44444444444', '15015000', 'Rua das Flores', '45',     'lucas@email.com',        '123456', 'entregador'),
-- Clientes
('Ana Paula Souza',        '66666666666', '15010000', 'Rua Brasil', '120',        'ana@email.com',          '123456', 'cliente'),
('João Pedro Lima',        '77777777777', '15015000', 'Rua Minas Gerais', '200',  'joao@email.com',         '123456', 'cliente'),
('Fernanda Alves',         '88888888888', '15010000', 'Rua Paraná', '350',        'fernanda@email.com',     '123456', 'cliente'),
-- Funcionários adicionais (para a folha de pagamento)
('Roberto Mendes',         '99999999991', '15010000', 'Rua São Paulo', '80',      'roberto@dpimentas.com',  '123456', 'funcionario'),
('Juliana Costa',          '99999999992', '15015000', 'Rua Goiás', '150',         'juliana@dpimentas.com',  '123456', 'funcionario'),
('Pedro Henrique Santos',  '99999999993', '15010000', 'Av. Brasil', '500',        'pedro@dpimentas.com',    '123456', 'funcionario'),
('Camila Rodrigues',       '99999999994', '15015000', 'Rua Bahia', '75',          'camila@dpimentas.com',   '123456', 'funcionario');

-- =============================================
-- 5. TELEFONES
-- =============================================
INSERT INTO telefones (pessoa_codigo, nr) 
VALUES (1, '17999990001'),
       (2, '17999990002'),
       (3, '17999990003'),
       (4, '17999990004'),
       (5, '17999990005'),
       (6, '17988880001'),
       (6, '17988880002'),
       (7, '17999990007'),
       (8, '17999990008'),
       (9, '17999990009'),
       (10,'17999990010');

-- =============================================
-- 6. CLIENTES (apenas as pessoas 4, 5 e 6)
-- =============================================
INSERT INTO clientes (pessoa_codigo, estrelas) 
VALUES (4, 4.5),
       (5, 4.5),
       (6, 5.0);

-- =============================================
-- 7. FUNCIONÁRIOS (agora 1,2 + 7 a 10)
-- =============================================
INSERT INTO funcionarios (pessoa_codigo, salario) 
VALUES (1, 3500.00),
       (2, 2800.00),
       (7, 2400.00),  -- Roberto - Cozinheiro
       (8, 2200.00),  -- Juliana - Auxiliar
       (9, 4200.00),  -- Pedro   - Admin
       (10,2150.00);  -- Camila  - Estagiária

-- =============================================
-- 8. ENTREGADORES
-- =============================================
INSERT INTO entregadores (pessoa_codigo, valor_diaria) 
VALUES (3, 100.00);

-- =============================================
-- 9. TIPOS DE MARMITEX
-- =============================================
INSERT INTO tipos (descricao) 
VALUES ('Tradicional');

-- =============================================
-- 10. TAMANHOS DE MARMITEX
-- =============================================
INSERT INTO tamanhos_marmitex (nome, preco_base, limite_misturas)
VALUES ('Pequena', 15.00, 2),
       ('Média',   20.00, 3),
       ('Grande',  25.00, 4);

-- =============================================
-- 11. MARMITEX
-- =============================================
INSERT INTO marmitex (nome, tipo_codigo, preco_adicional, ativo, atualizado_em)
VALUES ('Frango Grelhado',      1, 0.00, 1, GETDATE()),
       ('Carne de Panela',      1, 0.00, 1, GETDATE()),
       ('Feijoada',             1, 2.00, 1, GETDATE()),
       ('Frango à Parmegiana',  1, 0.00, 1, GETDATE());

-- =============================================
-- 12. BEBIDAS 
-- =============================================
INSERT INTO bebidas (nome, estoque, preco, ativo, atualizado_em)
VALUES ('Coca-Cola Lata 350ml', 50,  6.00, 1, GETDATE()),
       ('Guaraná Lata 350ml',   40,  5.00, 1, GETDATE()),
       ('Água Mineral 500ml',   60,  3.00, 1, GETDATE()),
       ('Coca-Cola 2L',         20, 12.00, 1, GETDATE());

-- =============================================
-- 13. ENTREGAS
-- =============================================
INSERT INTO entregas (data_hora, status, entregador_codigo)
VALUES ('2026-06-26 12:20:00', 1, 3),
       ('2026-06-26 12:35:00', 1, 3);

-- =============================================
-- 14. PEDIDOS
-- =============================================
INSERT INTO pedidos (data, status, cliente_codigo, funcionario_codigo, entrega_codigo, preco, tipo_pedido, observacao_geral)
VALUES ('2026-06-26 12:00:00', 1, 6, 1, 1,    26.00, 'entrega',  'Nenhuma'),       
       ('2026-06-26 12:15:00', 1, 4, 2, 2,    23.00, 'entrega',  'Caprichar'),       
       ('2026-06-27 12:30:00', 1, 5, 1, NULL, 20.00, 'retirada', NULL);

-- =============================================
-- 15. ITENS DOS PEDIDOS - MARMITEX
-- =============================================
INSERT INTO pedidos_marmitex (pedido_nr, tamanho_codigo, marmitex_codigo, qtd, obs_troca)
VALUES (1, 2, 1, 1, NULL),
       (2, 1, 2, 1, 'Trocar arroz por purê'),
       (3, 2, 3, 1, NULL);

-- =============================================
-- 16. ITENS DOS PEDIDOS - BEBIDAS
-- =============================================
INSERT INTO pedidos_bebidas (pedido_nr, bebida_codigo, qtd)
VALUES (1, 1, 1),
       (2, 3, 1),
       (3, 2, 1);
GO

-- =============================================
-- 17. TIPOS DE CONTRATO
-- =============================================
INSERT INTO tipos_contratos (descricao)
VALUES
('CLT - Tempo Indeterminado'),
('CLT - Experiência 45 dias'),
('CLT - Experiência 90 dias'),
('Temporário'),
('Intermitente'),
('Meio Período (Part-Time)'),
('Estágio'),
('Jovem Aprendiz'),
('Prestador de Serviços (PJ)'),
('Terceirizado');
GO

-- =============================================
-- 18. FOLHA DE PAGAMENTO / CONTRATOS
-- =============================================
INSERT INTO folha_pagamento_contratos (
    funcionario_codigo,
    tipo_contrato_codigo,
    numero_contrato,
    data_inicio,
    data_fim,
    salario_base,
    adicional,
    status_contrato,
    ativo,
    atualizado_em,
    funcionario_atualizacao_codigo,
    observacao
)
VALUES
-- Contratos ativos principais
(1,  1, 'CTR-2025-001', '2025-01-10', NULL,         3500.00, 500.00, 'ATIVO',    1, '2025-01-10 09:00:00', 1, 'Gerente administrativo e financeiro'),
(2,  1, 'CTR-2025-002', '2025-02-01', NULL,         2800.00, 250.00, 'ATIVO',    1, '2025-02-01 09:30:00', 1, 'Supervisora de atendimento e caixa'),
(7,  1, 'CTR-2025-003', '2025-03-15', NULL,         2400.00, 200.00, 'ATIVO',    1, '2025-03-15 10:00:00', 1, 'Cozinheiro chefe'),
(8,  1, 'CTR-2025-004', '2025-04-01', NULL,         2200.00, 150.00, 'ATIVO',    1, '2025-04-01 10:30:00', 1, 'Auxiliar de cozinha'),

-- Contratos encerrados (experiência)
(7,  3, 'CTR-2026-005', '2026-05-01', '2026-07-29', 2500.00, 100.00, 'ENCERRADO', 0, '2026-07-29 11:00:00', 1, 'Contrato de experiência 90 dias (substituído)'),
(8,  2, 'CTR-2026-006', '2026-06-01', '2026-07-15', 2100.00,   0.00, 'ENCERRADO', 0, '2026-07-15 11:30:00', 1, 'Período inicial de experiência'),

-- Outros contratos ativos
(9,  1, 'CTR-2024-007', '2024-08-10', NULL,         4200.00, 600.00, 'ATIVO',    1, '2024-08-10 08:00:00', 1, 'Administrador geral do sistema'),
(10, 6, 'CTR-2026-008', '2026-01-20', NULL,         2300.00, 120.00, 'ATIVO',    1, '2026-01-20 08:30:00', 1, 'Atendente turno almoço'),

-- Contrato temporário encerrado
(9,  4, 'CTR-2026-009', '2026-03-01', '2026-08-31', 2600.00, 180.00, 'ENCERRADO', 0, '2026-08-31 09:00:00', 1, 'Cobertura de demanda sazonal'),

-- Estágio
(10, 7, 'CTR-2026-010', '2026-02-10', '2027-02-09', 2150.00,   0.00, 'ATIVO',    1, '2026-02-10 09:30:00', 1, 'Estágio em gestão de produção');
GO
