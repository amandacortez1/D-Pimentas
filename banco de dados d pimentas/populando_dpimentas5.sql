USE dpimentas13;
GO


SET DATEFORMAT ymd;
GO


-- =====================================================
-- 1. ESTADOS
-- =====================================================
INSERT INTO ufs (sigla, nome)
VALUES
('SP', 'São Paulo'),
('MG', 'Minas Gerais'),
('RJ', 'Rio de Janeiro'),
('PR', 'Paraná'),
('SC', 'Santa Catarina'),
('RS', 'Rio Grande do Sul'),
('GO', 'Goiás'),
('MS', 'Mato Grosso do Sul'),
('MT', 'Mato Grosso'),
('BA', 'Bahia');
GO


-- =====================================================
-- 2. CIDADES
-- =====================================================
INSERT INTO cidades (codigo, nome, uf_sigla)
VALUES
(1, 'São José do Rio Preto', 'SP'),
(2, 'Bady Bassitt', 'SP'),
(3, 'Mirassol', 'SP'),
(4, 'Catanduva', 'SP'),
(5, 'Ribeirão Preto', 'SP'),
(6, 'Uberlândia', 'MG'),
(7, 'Belo Horizonte', 'MG'),
(8, 'Curitiba', 'PR'),
(9, 'Londrina', 'PR'),
(10, 'Campinas', 'SP');
GO


-- =====================================================
-- 3. CEPS
-- =====================================================
INSERT INTO ceps (nr, cidade_codigo)
VALUES
('15010000', 1),
('15015000', 1),
('15025000', 1),
('15050000', 1),
('15115000', 2),
('15130000', 3),
('15800000', 4),
('14010000', 5),
('38400000', 6),
('13010000', 10);
GO


-- =====================================================
-- 4. PESSOAS
-- =====================================================
INSERT INTO pessoas
(nome, cpf, cep_nr, logradouro, numero, email, senha, nivel_acesso)
VALUES
('Carlos Eduardo Silva', '11111111111', '15010000', 'Rua Independência', '100', 'carlos@dpimentas.com', '123456', 'admin'),
('Mariana Oliveira', '22222222222', '15015000', 'Rua XV de Novembro', '250', 'mariana@dpimentas.com', '123456', 'funcionario'),
('Ricardo Mendes', '11111111112', '15025000', 'Av. Bady Bassitt', '410', 'ricardo@dpimentas.com', '123456', 'funcionario'),
('Patrícia Gomes', '11111111113', '15050000', 'Rua Bernardino de Campos', '890', 'patricia@dpimentas.com', '123456', 'funcionario'),
('Fernando Costa', '11111111114', '15115000', 'Rua Camilo de Moraes', '55', 'fernando@dpimentas.com', '123456', 'funcionario'),
('Juliana Martins', '11111111115', '15130000', 'Rua Santo Antônio', '312', 'juliana@dpimentas.com', '123456', 'funcionario'),
('Roberto Almeida', '11111111116', '15010000', 'Rua Voluntários de São Paulo', '1200', 'roberto@dpimentas.com', '123456', 'admin'),
('Camila Rocha', '11111111117', '15015000', 'Rua General Glicério', '740', 'camila@dpimentas.com', '123456', 'funcionario'),
('André Luiz Souza', '11111111118', '15025000', 'Av. Alberto Andaló', '1500', 'andre@dpimentas.com', '123456', 'funcionario'),
('Beatriz Nogueira', '11111111119', '15050000', 'Rua Saldanha Marinho', '620', 'beatriz@dpimentas.com', '123456', 'funcionario'),


('Lucas Ferreira', '44444444444', '15015000', 'Rua das Flores', '45', 'lucas@email.com', '123456', 'entregador'),
('Rafael Santos', '44444444441', '15010000', 'Rua Pedro Amaral', '180', 'rafael.ent@email.com', '123456', 'entregador'),
('Diego Carvalho', '44444444442', '15025000', 'Rua Siqueira Campos', '910', 'diego.ent@email.com', '123456', 'entregador'),
('Thiago Pereira', '44444444443', '15115000', 'Av. Marginal', '22', 'thiago.ent@email.com', '123456', 'entregador'),
('Bruno Nascimento', '44444444445', '15130000', 'Rua Campos Sales', '504', 'bruno.ent@email.com', '123456', 'entregador'),
('Gabriel Ribeiro', '44444444446', '15050000', 'Rua Jorge Tibiriçá', '330', 'gabriel.ent@email.com', '123456', 'entregador'),
('Matheus Barbosa', '44444444447', '15010000', 'Rua Fritz Jacobs', '715', 'matheus.ent@email.com', '123456', 'entregador'),
('Vinícius Araújo', '44444444448', '15015000', 'Rua Antônio de Godoy', '1102', 'vinicius.ent@email.com', '123456', 'entregador'),
('Gustavo Dias', '44444444449', '15025000', 'Av. Philadelpho Gouveia Neto', '88', 'gustavo.ent@email.com', '123456', 'entregador'),
('Leonardo Cardoso', '44444444450', '15050000', 'Rua Tiradentes', '419', 'leonardo.ent@email.com', '123456', 'entregador'),


('Ana Paula Souza', '66666666666', '15010000', 'Rua Brasil', '120', 'ana@email.com', '123456', 'cliente'),
('João Pedro Lima', '77777777777', '15015000', 'Rua Minas Gerais', '200', 'joao@email.com', '123456', 'cliente'),
('Fernanda Alves', '88888888888', '15010000', 'Rua Paraná', '350', 'fernanda@email.com', '123456', 'cliente'),
('Marcelo Vieira', '66666666661', '15025000', 'Rua Bahia', '415', 'marcelo@email.com', '123456', 'cliente'),
('Larissa Castro', '66666666662', '15050000', 'Rua Goiás', '78', 'larissa@email.com', '123456', 'cliente'),
('Rodrigo Teixeira', '66666666663', '15115000', 'Rua São Paulo', '902', 'rodrigo@email.com', '123456', 'cliente'),
('Amanda Correia', '66666666664', '15130000', 'Rua Rio de Janeiro', '144', 'amanda@email.com', '123456', 'cliente'),
('Felipe Monteiro', '66666666665', '15010000', 'Rua Santa Catarina', '560', 'felipe@email.com', '123456', 'cliente'),
('Natália Freitas', '66666666667', '15015000', 'Av. Potirendaba', '1320', 'natalia@email.com', '123456', 'cliente'),
('Renato Azevedo', '66666666668', '15025000', 'Rua Rubião Júnior', '295', 'renato@email.com', '123456', 'cliente');
GO


-- =====================================================
-- 5. TELEFONES
-- =====================================================
INSERT INTO telefones (pessoa_codigo, nr)
VALUES
(1, '17999990001'),
(2, '17999990002'),
(11, '17999990003'),
(21, '17999990004'),
(22, '17999990005'),
(23, '17988880001'),
(23, '17988880002'),
(24, '17988880003'),
(25, '17988880004'),
(26, '17988880005'),
(27, '17988880006'),
(28, '17988880007');
GO


-- =====================================================
-- 6. CLIENTES
-- =====================================================
INSERT INTO clientes (pessoa_codigo, estrelas)
VALUES
(21, 4.5), (22, 4.5), (23, 5.0), (24, 4.8), (25, 5.0),
(26, 4.2), (27, 4.9), (28, 5.0), (29, 4.7), (30, 4.6);
GO


-- =====================================================
-- 7. FUNCIONÁRIOS
-- =====================================================
INSERT INTO funcionarios (pessoa_codigo, salario)
VALUES
(1, 3500.00), (2, 2800.00), (3, 2400.00), (4, 2200.00),
(5, 2500.00), (6, 2100.00), (7, 4200.00), (8, 2300.00),
(9, 2600.00), (10, 2150.00);
GO


-- =====================================================
-- 8. ENTREGADORES
-- =====================================================
INSERT INTO entregadores (pessoa_codigo, valor_diaria)
VALUES
(11, 100.00), (12, 100.00), (13, 110.00), (14, 105.00),
(15, 100.00), (16, 115.00), (17, 100.00), (18, 120.00),
(19, 110.00), (20, 105.00);
GO


-- =====================================================
-- 9. TIPOS DE MARMITEX
-- =====================================================
INSERT INTO tipos (descricao)
VALUES
('Tradicional'),
GO


-- =====================================================
-- 10. TAMANHOS DE MARMITEX
-- =====================================================
INSERT INTO tamanhos_marmitex (nome, preco_base, limite_misturas)
VALUES
('Pequena', 15.00, 2),
('Média', 20.00, 3),
('Grande', 25.00, 4),
GO


-- =====================================================
-- 11. MARMITEX
-- =====================================================
INSERT INTO marmitex
(nome, tipo_codigo, preco_adicional, ativo, atualizado_em)
VALUES
('Frango Grelhado', 1, 0.00, 1, '2026-05-10 08:30:00'),
('Carne de Panela', 1, 0.00, 1, '2026-05-12 09:15:00'),
('Feijoada', 1, 2.00, 1, '2026-05-15 11:00:00'),
('Frango à Parmegiana', 1, 0.00, 1, '2026-05-18 10:20:00'),
('Patinho Moído com Legumes', 2, 0.00, 1, '2026-05-20 07:45:00'),
('Omelete de Forno com Queijo', 3, 0.00, 1, '2026-05-22 08:00:00'),
('Strogonoff de Grão-de-Bico', 4, 1.50, 1, '2026-05-25 14:10:00'),
('Contra-Filé Acebolado', 6, 3.00, 1, '2026-05-28 09:30:00'),
('Picanha na Brasa', 8, 5.00, 1, '2026-06-02 12:00:00'),
('Tilápia Grelhada ao Molho de Ervas', 9, 4.00, 1, '2026-06-05 10:05:00');
GO


-- =====================================================
-- 12. BEBIDAS
-- =====================================================
INSERT INTO bebidas (nome, estoque, preco, ativo, atualizado_em)
VALUES
('Coca-Cola Lata 350ml', 50, 6.00, 1, '2026-05-01 08:00:00'),
('Guaraná Lata 350ml', 40, 5.00, 1, '2026-05-02 08:30:00'),
('Água Mineral 500ml', 60, 3.00, 1, '2026-05-03 09:00:00'),
('Coca-Cola 2L', 20, 12.00, 1, '2026-05-04 09:30:00'),
('Coca-Cola Zero Lata 350ml', 45, 6.00, 1, '2026-05-05 10:00:00'),
('Fanta Laranja Lata 350ml', 35, 5.50, 1, '2026-05-06 10:30:00'),
('Suco Del Valle Uva 290ml', 30, 6.50, 1, '2026-05-07 11:00:00'),
('Suco Natural de Laranja 500ml', 25, 8.00, 1, '2026-05-08 11:30:00'),
('Água com Gás 500ml', 50, 3.50, 1, '2026-05-09 12:00:00'),
('Guaraná Antarctica 2L', 18, 10.00, 1, '2026-05-10 12:30:00');
GO


-- =====================================================
-- 13. ENTREGAS
-- =====================================================
INSERT INTO entregas (data_hora, status, entregador_codigo)
VALUES
('2026-06-26 12:20:00', 1, 11),
('2026-06-26 12:35:00', 1, 11),
('2026-06-27 11:50:00', 2, 12),
('2026-06-27 12:10:00', 2, 13),
('2026-06-28 12:05:00', 1, 14),
('2026-06-28 12:40:00', 1, 15),
('2026-06-29 11:45:00', 2, 16),
('2026-06-29 12:15:00', 1, 17),
('2026-06-30 12:00:00', 1, 18),
('2026-06-30 12:30:00', 1, 19);
GO


-- =====================================================
-- 14. PEDIDOS
-- =====================================================
INSERT INTO pedidos
(data, status, cliente_codigo, funcionario_codigo,
 entrega_codigo, preco, tipo_pedido, observacao_geral)
VALUES
('2026-06-26 12:00:00', 1, 23, 1, 1, 26.00, 'entrega', 'Nenhuma'),
('2026-06-26 12:15:00', 1, 21, 2, 2, 18.00, 'entrega', 'Caprichar'),
('2026-06-27 12:30:00', 1, 22, 1, NULL, 27.00, 'retirada', NULL),
('2026-06-27 11:30:00', 2, 24, 3, 3, 31.00, 'entrega', 'Enviar talheres descartáveis'),
('2026-06-27 11:55:00', 2, 25, 4, 4, 28.00, 'entrega', 'Sem cebola na salada'),
('2026-06-28 11:40:00', 1, 26, 5, 5, 50.00, 'entrega', 'Tocar o interfone 12'),
('2026-06-28 12:20:00', 1, 27, 6, 6, 22.00, 'entrega', NULL),
('2026-06-29 11:25:00', 2, 28, 7, 7, 50.00, 'entrega', 'Mandar sachês de pimenta'),
('2026-06-29 12:00:00', 1, 29, 8, NULL, 23.50, 'retirada', 'Cliente retira no balcão'),
('2026-06-30 12:10:00', 1, 30, 9, 9, 37.00, 'entrega', 'Troco para R$ 50,00');
GO


-- =====================================================
-- 15. ITENS DOS PEDIDOS - MARMITEX
-- =====================================================
INSERT INTO pedidos_marmitex
(pedido_nr, tamanho_codigo, marmitex_codigo, qtd, obs_troca)
VALUES
(1, 2, 1, 1, NULL),
(2, 1, 2, 1, 'Trocar arroz por purê'),
(3, 2, 3, 1, NULL),
(4, 3, 4, 1, NULL),
(5, 7, 5, 1, 'Dobro de legumes'),
(6, 5, 8, 1, 'Sem feijão'),
(7, 8, 7, 1, NULL),
(8, 5, 9, 1, 'Carne ao ponto'),
(9, 2, 6, 1, NULL),
(10, 3, 10, 1, 'Trocar farofa por salada');
GO


-- =====================================================
-- 16. ITENS DOS PEDIDOS - BEBIDAS
-- =====================================================
INSERT INTO pedidos_bebidas (pedido_nr, bebida_codigo, qtd)
VALUES
(1, 1, 1),
(2, 3, 1),
(3, 2, 1),
(4, 5, 1),
(5, 3, 2),
(6, 4, 1),
(7, 7, 1),
(8, 10, 1),
(9, 9, 1),
(10, 8, 1);
GO


-- =====================================================
-- 17. TIPOS DE CONTRATOS
-- =====================================================
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


-- =====================================================
-- 18. FOLHA DE PAGAMENTO / CONTRATOS
-- =====================================================
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
(1, 1, 'CTR-2025-001', '2025-01-10', NULL, 3500.00, 500.00, 'ATIVO', 1, '2025-01-10 09:00:00', 1, 'Gerente administrativo e financeiro'),
(2, 1, 'CTR-2025-002', '2025-02-01', NULL, 2800.00, 250.00, 'ATIVO', 1, '2025-02-01 09:30:00', 1, 'Supervisora de atendimento e caixa'),
(3, 1, 'CTR-2025-003', '2025-03-15', NULL, 2400.00, 200.00, 'ATIVO', 1, '2025-03-15 10:00:00', 1, 'Cozinheiro chefe'),
(4, 1, 'CTR-2025-004', '2025-04-01', NULL, 2200.00, 150.00, 'ATIVO', 1, '2025-04-01 10:30:00', 7, 'Auxiliar de cozinha'),


(5, 3, 'CTR-2026-005', '2026-05-01', '2026-07-29', 2500.00, 100.00, 'ENCERRADO', 0, '2026-07-29 11:00:00', 1, 'Contrato de experiência 90 dias'),
(6, 2, 'CTR-2026-006', '2026-06-01', '2026-07-15', 2100.00, 0.00, 'ENCERRADO', 0, '2026-07-15 11:30:00', 7, 'Período inicial de experiência'),


(7, 1, 'CTR-2024-007', '2024-08-10', NULL, 4200.00, 600.00, 'ATIVO', 1, '2024-08-10 08:00:00', 1, 'Administrador geral do sistema'),
(8, 6, 'CTR-2026-008', '2026-01-20', NULL, 2300.00, 120.00, 'ATIVO', 1, '2026-01-20 08:30:00', 1, 'Atendente turno almoço'),


(9, 4, 'CTR-2026-009', '2026-03-01', '2026-08-31', 2600.00, 180.00, 'ENCERRADO', 0, '2026-08-31 09:00:00', 7, 'Cobertura de demanda sazonal'),


(10, 7, 'CTR-2026-010', '2026-02-10', '2027-02-09', 2150.00, 0.00, 'ATIVO', 1, '2026-02-10 09:30:00', 1, 'Estágio em gestão de produção');
GO