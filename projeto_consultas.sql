SELECT cnpj, nome, conf_nome  FROM Clube 
WHERE conf_nome in ('FERJ', 'FPF')

SELECT nome, dtnascimento, altura, pais FROM Jogador
WHERE pais not in ('Brasil')

SELECT * from Contrata
where salario BETWEEN 0 AND 95000

SELECT * from Patrocinio
where valor NOT BETWEEN 30000 AND 180000

SELECT nome, dtnascimento, altura, pais FROM Jogador
where endereco_estado IS NULL

SELECT * from Dependente
where descricao IS NOT NULL

SELECT * from Confederacao
where presidente LIKE '%Neto'

SELECT nome, estadio, presidente from Clube
where conf_nome not like 'FPF'

SELECT codDependente, nome, descricao from Dependente
order by nome

SELECT COUNT(matricula) [Quantidade]
from Arbitro

SELECT SUM(valor) [Total]
from Patrocinio

SELECT AVG(salario) [Média]
from Contrata

SELECT MAX(altura) [Mais Alto]
from Jogador

SELECT MIN(altura) [Mais Baixo]
from Jogador

SELECT clu.nome, AVG(jo.altura) [Média] 
from Jogador [jo] inner join Contrato [con]
on con.contrata_jogador_cpf = jo.cpf inner join Clube clu 
on clu.cnpj = con.contrata_clube
group by clu.nome, jo.nome
having AVG(jo.altura) > 1.80

SELECT torc.nome, clu.nome
from Torcedor [torc] inner join  Clube [clu]
on torc.clube_cnpj = clu.cnpj
where clu.nome = 'Flamengo'

SELECT arb.nome [Árbitro], arb.matricula [Matrícula], camp.nome [Campeonato]
FROM Arbitro [arb] LEFT JOIN Campeonato [camp]
ON arb.nome_confederacao = camp.confederacao_nome 

SELECT numero, nome from Telefone_Profissional
RIGHT JOIN Profissional
ON matricula_profissional = matricula
ORDER BY nome

SELECT clu.nome [Clube], jo.nome [Jogador], jo.cpf [CPF do Jogador]
FROM Clube [clu] FULL JOIN Contrata [con]
on clu.cnpj = con.cnpj_clube
FULL JOIN Jogador [jo]
on con.jogador_cpf = jo.cpf

SELECT nome, rg, cpf FROM Torcedor
where clube_cnpj = (SELECT cnpj from Clube
where nome = 'Flamengo')