WITH ContagemTags AS (
    SELECT
        id_clinica,
        LOWER(tag_area) AS tag_lower,
        COUNT(*) AS total_tags
    FROM
        dashboard_produto
    WHERE
        tag_area IS NOT NULL AND tag_area != 'Área-Sem retorno'
    GROUP BY
        id_clinica, LOWER(tag_area)
)

SELECT
    ct.id_clinica,
    COUNT(*) AS total_contatos,
    MAX(ct.tag_lower) AS tag_mais_utilizada,
    MAX(ct.total_tags) AS vezes_tag_mais_utilizada
FROM
    ContagemTags ct
JOIN
    (SELECT
        id_clinica,
        MAX(total_tags) AS max_total_tags
     FROM
        ContagemTags
     GROUP BY
        id_clinica) maxTags
ON
    ct.id_clinica = maxTags.id_clinica AND ct.total_tags = maxTags.max_total_tags
GROUP BY
    ct.id_clinica;
