WITH lives as (
SELECT 
    video_id,
    titulo_evento,
    competicao
    , data_evento
    , MAX(tempo_video) AS tempo_video
    
    , AVG(media_espectadores_simultaneos) * 1.117 AS media_espectadores_simultaneos
    , AVG(if(classificacao_minuto = "Pré-Jogo", media_espectadores_simultaneos, null)) * 1.117 AS media_espectadores_simultaneos_pre_jogo
    , AVG(if(classificacao_minuto = "Em Andamento", media_espectadores_simultaneos, null)) * 1.117 AS media_espectadores_simultaneos_em_andamento
    , AVG(if(classificacao_minuto = "Pós-Jogo", media_espectadores_simultaneos, null)) * 1.117 AS media_espectadores_simultaneos_pos_jogo
    
    , MAX(espectadores_simultaneos) * 1.117 AS pico_expectadores
    , MAX(if(classificacao_minuto = "Pré-Jogo", espectadores_simultaneos,null)) * 1.117 AS pico_expectadores_pre_jogo
    , MAX(if(classificacao_minuto = "Em Andamento", espectadores_simultaneos,null)) * 1.117  AS pico_expectadores_em_andamento
    , MAX(if(classificacao_minuto = "Pós-Jogo", espectadores_simultaneos,null)) * 1.117  AS pico_expectadores_pos_jogo
 
    , SUM(mensagens) AS total_mensagens
    , SUM(if(classificacao_minuto = "Pré-Jogo", mensagens,null)) AS total_mensagens_pre_jogo
    , SUM(if(classificacao_minuto = "Em Andamento", mensagens,null)) AS total_mensagens_em_andamento
    , SUM(if(classificacao_minuto = "Pós-Jogo", mensagens,null)) AS total_mensagens_pos_jogo

    , SUM(reacoes) AS total_reacoes
    , SUM(if(classificacao_minuto = "Pré-Jogo", reacoes,null)) AS total_reacoes_pre_jogo
    , SUM(if(classificacao_minuto = "Em Andamento", reacoes,null)) AS total_reacoes_em_andamento
    , SUM(if(classificacao_minuto = "Pós-Jogo", reacoes,null)) AS total_reacoes_pos_jogo

    , SUM(envolvimentos) AS total_envolvimentos
    , DATETIME(CURRENT_TIMESTAMP(), "America/Sao_Paulo") AS insert_date
  FROM 
   `data-analytics-422617.gold_layer.youtube_lives_por_minuto` 
  GROUP BY 1, 2, 3,4

)


select 
    video_id,
    titulo_evento,
    competicao,
    data_evento,
    tempo_video,
    if(media_espectadores_simultaneos_em_andamento is null,media_espectadores_simultaneos,media_espectadores_simultaneos_em_andamento) as media,
    media_espectadores_simultaneos,
    media_espectadores_simultaneos_pre_jogo,
    media_espectadores_simultaneos_em_andamento,
    media_espectadores_simultaneos_pos_jogo,
    pico_expectadores,
    pico_expectadores_pre_jogo,
    pico_expectadores_em_andamento,
    pico_expectadores_pos_jogo,
    total_mensagens,
    total_mensagens_pre_jogo,
    total_mensagens_em_andamento,
    total_mensagens_pos_jogo,
    total_reacoes,
    total_reacoes_pre_jogo,
    total_reacoes_em_andamento,
    total_reacoes_pos_jogo,
    total_envolvimentos,
    insert_date,
from lives
WHERE video_id = '9iq8PdNq5jc'