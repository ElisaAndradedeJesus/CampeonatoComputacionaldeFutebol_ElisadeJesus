# TP Parte II - Campeonato Computacional de Futebol

Este projeto implementa um sistema de gerenciamento de partidas e teams de futebol em linguagem C. O sistema permite consultar teams, consultar partidas, atualizar placares, remover partidas, inserir novas partidas e imprimir a tabela de classificação ordenada. Os dados são carregados de arquivos CSV, armazenados em memória com listas encadeadas e salvos novamente ao final da execução.

---

## Estrutura do Repositório

```
├── BD                # Pasta Base de dados no formato CSV
│   ├── bd_times.csv
│   ├── bd_partidas.csv
│   ├── bd_classificacao.csv
│   ├── partidas_parcial.csv
│   ├── partidas_vazio.csv
│   └── backupBD.csv
├── include           # Pasta com arquivos .h
│   ├── bdpartidas.h
│   ├── bdteams.h
│   ├── classificacao.h
│   ├── menu.h
│   ├── partida.h
│   └── team.h
├── src               # Pasta com arquivos .c
│   ├── bdpartidas.c
│   ├── bdteams.c
│   ├── classificacao.c
│   ├── menu.c
│   ├── partida.c
│   └── team.c
├── Makefile          # Automação de compilação e execução
├── main.c            # Ponto de entrada do programa
├── README.md         # Informações de execução e funcionamento do programa
├── tp1.pdf           # Documento guia. Especificações da parte I do trabalho.
└── tp_parte-II.pdf   # Documento guia. Especificações da parte II do trabalho.
```

---

### Sobre os arquivos: 

---

- **Makefile:**  
  - `make`: Executa: `clean compile run` nesta sequência;
  - `make run`: roda o programa;
  - `make clean`: remove o executável gerado;
  - `make compile`: compila o programa em um arquivo executável;
  - `make reset-bd`: restaura o arquivo `bd_partidas.csv` usando o conteúdo de `backupBD.csv`;

- **main.c:** Ponto de entrada do programa.
  - Carrega os CSVs de teams e partidas;
  - Inicializa os bancos em memória;
  - Calcula as estatísticas dos teams a partir das partidas;
  - Gera e atualiza a classificação;
  - Controla o loop do menu;
  - Salva `bd_partidas.csv` e `bd_classificacao.csv`;
  - Libera a memória alocada.

- **menu.c / menu.h:** Implementam a interface textual do sistema. Este módulo consulta dados, recebe entradas do usuário, pede confirmações e coordena operações como atualizar, remover e inserir partidas.

- **classificacao.c / classificacao.h:** Implementam o TAD `Classificacao`, responsável por montar, ordenar, imprimir e salvar a tabela de classificação.

- **bdteams.c / bdteams.h:** Implementam o TAD `BDTeams`, responsável por carregar os teams, armazená-los em lista encadeada, buscar teams e recalcular estatísticas a partir das partidas.

- **bdpartidas.c / bdpartidas.h:** Implementam o TAD `BDPartidas`, responsável por carregar, buscar, inserir, atualizar, remover e salvar partidas usando lista encadeada.

- **BD :** Pasta com todos os arquivos que emulam o Banco de Dados do projeto incluindo um backup do arquivo `bd_partidas.csv`. 

- **include :** Pasta com os arquivos .h (os headers) criados.

- **src :** Pasta com os arquivos .c referentes às TADs.

- **.gitignore :** Arquivo responsável por evitar o versionamento de arquivos gerados, como `.o` e o executável `programa`.

- **tp1.pdf / tp_parte-II.pdf:** Documentos utilizados como consulta durante a construção do programa, contendo os requisitos das duas partes do trabalho.

---

## TADs utilizados:

### 1. Team

O projeto utiliza o TAD **Team**, definido como uma `struct` em `team.c`. Este TAD representa cada time e possui os seguintes campos:

- `id` (int): Número identificador do time.
- `nome` (char[50]): Nome do time.

- `vitorias` (int): Quantas vitórias tiveram.
- `empates` (int): Quantas vezes empataram.
- `derrotas` (int): Quantas vezes perderam.

- `golsMarcados` (int): Quantos gols marcaram.
- `golsSofridos` (int): Quantos gols sofreram.

Este TAD é a base para manipulação dos dados do time.

### 2. Partida

O projeto utiliza o TAD **Partida**, definido como uma `struct` em `partida.c`, que possui os seguintes campos:

struct partida {
    int id;
    int idTeam1;
    int idTeam2;
    int golsTeam1;
    int golsTeam2;
};

- `id` (int): Número identificador da partida.

- `idTeam1` (int): Número identificador do time mandante.

- `idTeam2` (int): Número identificador do time visitante.

- `golsTeam1` (int): Quantos gols o time mandante marcou.
- `golsTeam2` (int): Quantos gols o time visitante marcou.

Este TAD é a base para manipulação dos dados da partida.

### 3. BDTeams 

O TAD **BDTeams**, definido em `bdteams.h`,  gerencia todos os times cadastrados e foi implementado com lista encadeada. Cada nó da lista aponta para um Team.

Este TAD é responsável por:
- carregar os teams de `bd_times.csv`;
- buscar teams por ID ou prefixo de nome;
- manter a coleção de teams em memória;
- recalcular estatísticas dos teams a partir do banco de partidas.

Possui os campos:
- `nElementos` (int): quantidade de teams armazenados na lista.

- `primeiro` (TeamNode*): ponteiro para o primeiro nó da lista encadeada.

- `ultimo` (TeamNode*): ponteiro para o último nó da lista, usado para facilitar inserções no fim.

#### TeamNode 

Possui os campos:
- `team` (Team*): ponteiro para o team armazenado naquele nó.
- `proximo` (TeamNode*): ponteiro para o próximo nó da lista. Quando vale NULL, indica que o nó atual é o último.

### 4. BDPartidas 

O TAD **BDPartidas**, definido em `bdpartidas.c` e `bdpartidas.h`, gerencia todas as partidas cadastradas e foi implementado com lista encadeada. Cada nó da lista aponta para uma `Partida`.

Este TAD é responsável por:
- carregar partidas de `bd_partidas.csv`;
- buscar partidas por ID ou pelo nome dos teams envolvidos;
- inserir novas partidas;
- atualizar placares;
- remover partidas;
- salvar o estado atualizado em `bd_partidas.csv`.

Possui os campos: 
- `nElementos` (int): quantidade de partidas armazenadas na lista.

- `primeiro` (PartidaNode*): ponteiro para o primeiro nó da lista.

- `ultimo` (PartidaNode*): ponteiro para o último nó da lista, facilitando inserções ao final.

#### PartidaNode 

Possui os campos:
- `partida` (Partida*): ponteiro para a partida armazenada naquele nó.
- `proximo` (PartidaNode*): ponteiro para o próximo nó da lista. Quando vale NULL, indica o fim da lista.

### 5. Classificacao

O TAD **Classificacao** armazena uma lista encadeada com as informações usadas para exibir a tabela do campeonato. Ele usa os dados já calculados dos teams, ordena a tabela por pontos ganhos e critérios de desempate, imprime a classificação e salva o resultado em `bd_classificacao.csv`.

Possui os campos:
- `nElementos` (int): quantidade de registros presentes na classificação.
- `primeiro` (ClassificacaoNode*): ponteiro para o primeiro nó da lista de classificação.
- `ultimo` (ClassificacaoNode*): ponteiro para o último nó da lista.

#### ClassificacaoNode

Possui os campos:
- `Info` (Info): guarda uma cópia dos dados usados na tabela de classificação.

  - `id` (int): identificador do team.
  - `nome` (char[50]): nome do team.
  - `vitorias` (int): quantidade de vitórias.
  - `empates` (int): quantidade de empates.
  - `derrotas` (int): quantidade de derrotas.
  - `golsMarcados` (int): total de gols marcados.
  - `golsSofridos` (int): total de gols sofridos.
  - `saldoDeGols` (int): diferença entre gols marcados e gols sofridos.
  - `pontosGanhos` (int): pontuação do team, calculada por `3 * vitórias + empates`.

- `proximo` (ClassificacaoNode*): ponteiro para o próximo nó da classificação.


---

## Instruções para Execução
Caso esteja seguindo o passo a passo do repositório **EstruturadeDadosPaixao**:
```bash
  cd CampeonatoComputacionaldeFutebol_ElisadeJesus
```
Se não:

**Clone o repositório:**
 ```bash
   git clone https://github.com/ElisaAndradedeJesus/CampeonatoComputacionaldeFutebol_ElisadeJesus.git
   cd CampeonatoComputacionaldeFutebol_ElisadeJesus
   ```

**Para rodar o programa:** 
```bash
  make 
  ```
O comando `make` executa clean, compile e run para facilitar a execução do programa. Porém caso haja a necessidade das etapas serem executadas separadamente:

1. **Compilar**  
   ```bash
   make compile
   ```
---

2. **Executar o programa**  
   ```bash
   make run
   ```

---

3. **Remover arquivo executável**  
   ```bash
   make clean
   ```

---

## Principais Decisões de Implementação

- **Terminal Limpo Regularmente:** Para evitar um terminal poluído por múltiplas execuções do programa. Esta decisão foi puramente estética.

- **Listas Encadeadas:** `BDTeams`, `BDPartidas` e `Classificacao` foram implementados com listas encadeadas, permitindo trabalhar com inserção e remoção dinâmica de registros.

- **Separação Em TADs:** O projeto foi dividido em TADs para separar responsabilidades: `Team` representa um team, `Partida` representa uma partida, `BDTeams` gerencia os teams, `BDPartidas` gerencia partidas, `Classificacao` organiza a tabela e `menu.c` coordena a interação com o usuário.

- **Persistência Em CSV:** O sistema carrega `bd_times.csv` e `bd_partidas.csv` ao iniciar. Ao final da execução, salva o estado atualizado em `bd_partidas.csv` e gera `bd_classificacao.csv`.

- **Busca Por Prefixo Case-Insensitive:** Foi utilizada a função `strncasecmp`, permitindo buscas por prefixo sem diferenciar letras maiúsculas e minúsculas.

- **Recalculo Das Estatísticas:** Após inserir, remover ou atualizar partidas, as estatísticas dos teams são recalculadas a partir da lista atual de partidas. Isso evita contagem duplicada e mantém a classificação consistente.

- **TAD Classificação:** Criado para melhorar a organização e separação de responsabilidades. 

- **Ordenação Da Classificação:** A classificação é ordenada por pontos ganhos, vitórias, saldo de gols, gols marcados e ID como critério final de desempate.


- **Confirmação Antes De Alterações:** As operações de atualização, remoção e inserção mostram uma prévia do registro e pedem confirmação antes de modificar o banco em memória.

- **Modularização:** O sistema foi dividido em módulos independentes para separar responsabilidades e melhorar organização/manutenção do código:

  - modelos de dados (`Team`, `Partida`, `Classificacao`);
  - estruturas de armazenamento (`BDTeams` e `BDPartidas`);
  - interface e interação com o usuário (`menu.c`);
  - fluxo principal de execução (`main.c`).

---

## Funcionalidades

Ao executar o programa, o usuário pode:

1. Consultar teams por nome ou prefixo;
2. Consultar partidas por team mandante, visitante ou ambos;
3. Atualizar o placar de uma partida existente;
4. Remover uma partida;
5. Inserir uma nova partida;
6. Imprimir a tabela de classificação ordenada;
7. Salvar os dados atualizados em CSV ao sair.
---

Este README.md oferece uma visão geral da estrutura, funcionamento e principais decisões de implementação do sistema.