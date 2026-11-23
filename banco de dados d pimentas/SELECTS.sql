USE dpimentas8;
GO

-- 1. Quantidade de funcionários e salário médio
SELECT 
    COUNT(*) AS total_funcionarios,
    AVG(salario) AS salario_medio,
    MAX(salario) AS maior_salario,
    MIN(salario) AS menor_salario
FROM funcionarios;

-- 2. Clientes com avaliação maior ou igual a 4.5
SELECT 
    p.nome,
    c.estrelas
FROM clientes c
INNER JOIN pessoas p ON c.pessoa_codigo = p.codigo
WHERE c.estrelas >= 4.5
ORDER BY c.estrelas DESC;

-- 3. Quantidade de pedidos por tipo (entrega / retirada)
SELECT 
    tipo_pedido,
    COUNT(*) AS quantidade
FROM pedidos
GROUP BY tipo_pedido
ORDER BY quantidade DESC;

-- 4. Total vendido por funcionário
SELECT 
    p.nome AS funcionario,
    COUNT(ped.nr) AS total_pedidos,
    SUM(ped.preco) AS valor_total
FROM pedidos ped
INNER JOIN funcionarios f ON ped.funcionario_codigo = f.pessoa_codigo
INNER JOIN pessoas p ON f.pessoa_codigo = p.codigo
GROUP BY p.nome
ORDER BY valor_total DESC;

-- 5. Marmitex mais caras (preço adicional)
SELECT 
    nome,
    preco_adicional
FROM marmitex
WHERE preco_adicional > 0
ORDER BY preco_adicional DESC;

-- 6. Bebidas com estoque baixo (menos de 30 unidades)
SELECT 
    nome,
    estoque,
    preco
FROM bebidas
WHERE estoque < 30
ORDER BY estoque ASC;

-- 7. Quantidade de marmitex vendidas por tamanho
SELECT 
    tm.nome AS tamanho,
    SUM(pm.qtd) AS total_vendido
FROM pedidos_marmitex pm
INNER JOIN tamanhos_marmitex tm ON pm.tamanho_codigo = tm.codigo
GROUP BY tm.nome
ORDER BY total_vendido DESC;

-- 8. Funcionários com salário acima da média
SELECT 
    p.nome,
    f.salario
FROM funcionarios f
INNER JOIN pessoas p ON f.pessoa_codigo = p.codigo
WHERE f.salario > (SELECT AVG(salario) FROM funcionarios)
ORDER BY f.salario DESC;

-- 9. Contratos ativos com salário base + adicional
SELECT 
    p.nome AS funcionario,
    tc.descricao AS tipo_contrato,
    fpc.salario_base,
    fpc.adicional,
    (fpc.salario_base + fpc.adicional) AS salario_total
FROM folha_pagamento_contratos fpc
INNER JOIN funcionarios f ON fpc.funcionario_codigo = f.pessoa_codigo
INNER JOIN pessoas p ON f.pessoa_codigo = p.codigo
INNER JOIN tipos_contratos tc ON fpc.tipo_contrato_codigo = tc.codigo
WHERE fpc.ativo = 1
ORDER BY salario_total DESC;

-- 10. Tipos de contrato que possuem mais de 1 contrato cadastrado
SELECT 
    tc.descricao,
    COUNT(*) AS quantidade_contratos
FROM folha_pagamento_contratos fpc
INNER JOIN tipos_contratos tc ON fpc.tipo_contrato_codigo = tc.codigo
GROUP BY tc.descricao
HAVING COUNT(*) > 1
ORDER BY quantidade_contratos DESC;