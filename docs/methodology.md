# Missão 1

Iniciei a missão entendo se seria necessário criar uma database para fazer as análises iniciais em SQL e concluí que sim! Pois tenho intenção de estudar 3 tabelas presentes no Kaggle, que são:

- fifa_ranking_2022-10-06.csv
- matches_1930_2022.csv
- world_cup.csv

Também defini a organização que seria utilizada no projeto: recentemente descobri o cookiecutter e estou seguindo uma organização baseada nele, pois acredito que dá uma visibilidade fácil de todas as etapas e caso alguém queira ver apenas uma parte específica do processo, não é difícil de se encontrar pela nomenclatura padrão das pastas.

Após criada a database, dei início à análise geral dos dados utilizando SQL e constatei que as tabelas estão completas o suficiente para poder explorar relações entre elas. Meu primeiro objetivo será fazer um panorama e diversos rankings com as informações que temos.

Decidi criar uma view para facilitar informações de ranking da tabela matches.

# Missão 2

Após estruturar e compreender a base de dados, iniciei a Análise Exploratória de Dados (EDA) utilizando Python e SQL. O objetivo dessa etapa foi entender melhor o comportamento das seleções e identificar padrões que pudessem ser utilizados tanto no dashboard quanto na etapa de Machine Learning.

Como os dados já apresentavam boa qualidade, não foi necessário realizar um tratamento extensivo de valores ausentes. O foco passou a ser a criação de novas variáveis e a padronização das informações entre as tabelas, garantindo consistência para as análises.

Durante a exploração foram investigados aspectos como:

- desempenho das seleções nas Copas de 2018 e 2022;
- evolução do ranking FIFA;
- quantidade de gols por fase do campeonato;
- distribuição de cartões amarelos e vermelhos;
- partidas decididas por disputa de pênaltis;
- desempenho por confederação.

Também foram construídas diversas visualizações utilizando Matplotlib e Plotly para compreender a distribuição das variáveis e identificar possíveis relações entre elas. Essa etapa foi importante para levantar hipóteses que posteriormente serviram de base para a construção do dashboard e da solução preditiva.

Além das análises descritivas, foram criadas novas métricas derivadas dos dados originais, permitindo enriquecer a base para responder perguntas que não poderiam ser obtidas diretamente das tabelas fornecidas.

Ao fim dessa etapa, decidi que eu estava interessada em investigar a relação dos cartões com o desempenho de cada time e se a fase do campeonato teria relação com a quantidade de cartões, estes apontamentos guiaram meus passos durante as próximas missões.

# Missão 3

Com os principais insights identificados na etapa exploratória, foi desenvolvido um dashboard no Power BI com o objetivo de transformar os resultados obtidos em uma ferramenta interativa de análise. Durante esta etapa percebi que os nomes das seleções em ranking e matches não seguiam os mesmos padrões, por isso precisei retornar à etapa 2 e criar um dicionário com o nome padronizado dos países.

O dashboard foi estruturado para permitir diferentes perspectivas sobre os dados das Copas do Mundo de 2018 e 2022, reunindo indicadores gerais, rankings, comparações entre seleções, confederações e análises sobre a distribuição de cartões das partidas.

Essa etapa também serviu como validação das análises realizadas anteriormente, permitindo confirmar visualmente diversos padrões encontrados durante a EDA e preparando a base para a etapa final de modelagem preditiva.

# Missão 4

Dei início à missão 4 criando o arquivo de feature engineering e adicionando a coluna de match id para as partidas, dessa forma é possível facilitar a identificação de partidas na tabela e também evitar que existam duplicadas ao treinar a máquina.

Também foi necessário criar uma nova view que consolidasse os dados históricos de cada time nestas 2 edições da copa que estamos analisando.