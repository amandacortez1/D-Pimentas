USE dpimentas13;
GO


/* =====================================================
   1. CONTAR REGISTROS DAS TABELAS
   ===================================================== */


SELECT 'Pessoas' AS tabela, COUNT(*) AS total FROM pessoas
UNION ALL
SELECT 'Clientes', COUNT(*) FROM clientes
UNION ALL
SELECT 'Funcionarios', COUNT(*) FROM funcionarios
UNION ALL
SELECT 'Entregadores', COUNT(*) FROM entregadores
UNION ALL
SELECT 'Telefones', COUNT(*) FROM telefones
UNION ALL
SELECT 'Pedidos', COUNT(*) FROM pedidos
UNION ALL
SELECT 'Marmitex', COUNT(*) FROM marmitex
UNION ALL
SELECT 'Bebidas', COUNT(*) FROM bebidas
UNION ALL
SELECT 'Entregas', COUNT(*) FROM entregas;




/* =====================================================
   2. LISTAR PESSOAS E SEUS TELEFONES
   ===================================================== */


SELECT
    p.codigo,
    p.nome,
    p.cpf,
    p.email,
    t.nr AS telefone
FROM pessoas p
LEFT JOIN telefones t
    ON p.codigo = t.pessoa_codigo
ORDER BY p.nome;




/* =====================================================
   3. MOSTRAR O CARDÁPIO DE MARMITEX
   ===================================================== */


SELECT
    m.codigo,
    m.nome AS marmitex,
    t.descricao AS tipo,
    m.preco_adicional,
    m.ativo
FROM marmitex m
INNER JOIN tipos t
    ON m.tipo_codigo = t.codigo
ORDER BY m.nome;




/* =====================================================
   4. LISTAR PEDIDOS E SEUS CLIENTES
   ===================================================== */


SELECT
    p.nr AS pedido,
    p.data,
    pes.nome AS cliente,
    p.preco,
    p.status,
    p.tipo_pedido
FROM pedidos p
INNER JOIN clientes c
    ON p.cliente_codigo = c.pessoa_codigo
INNER JOIN pessoas pes
    ON c.pessoa_codigo = pes.codigo
ORDER BY p.nr;




/* =====================================================
   5. MOSTRAR OS ITENS DE CADA PEDIDO
   ===================================================== */


SELECT
    pm.pedido_nr AS pedido,
    m.nome AS marmitex,
    tm.nome AS tamanho,
    pm.qtd AS quantidade
FROM pedidos_marmitex pm
INNER JOIN marmitex m
    ON pm.marmitex_codigo = m.codigo
INNER JOIN tamanhos_marmitex tm
    ON pm.tamanho_codigo = tm.codigo
ORDER BY pm.pedido_nr;


-- Bebidas dos pedidos
SELECT
    pb.pedido_nr AS pedido,
    b.nome AS bebida,
    pb.qtd AS quantidade
FROM pedidos_bebidas pb
INNER JOIN bebidas b
    ON pb.bebida_codigo = b.codigo
ORDER BY pb.pedido_nr;




/* =====================================================
   6. LISTAR FUNCIONÁRIOS E SEUS CONTRATOS
   ===================================================== */


SELECT
    p.nome AS funcionario,
    fpc.numero_contrato,
    tc.descricao AS tipo_contrato,
    fpc.salario_base,
    fpc.adicional,
    fpc.status_contrato,
    fpc.data_inicio,
    fpc.data_fim
FROM folha_pagamento_contratos fpc
INNER JOIN funcionarios f
    ON fpc.funcionario_codigo = f.pessoa_codigo
INNER JOIN pessoas p
    ON f.pessoa_codigo = p.codigo
INNER JOIN tipos_contratos tc
    ON fpc.tipo_contrato_codigo = tc.codigo
ORDER BY p.nome;