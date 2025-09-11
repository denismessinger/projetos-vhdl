Processador de 8 bits em VHDL
Este projeto consiste na implementação de um processador de 8 bits em VHDL. Um processador é o cérebro de um sistema computacional, responsável por executar instruções de um programa. Ele realiza operações lógicas e aritméticas e gerencia o fluxo de dados, seguindo um ciclo de busca, decodificação e execução de instruções.

Para controlar as operações do processador, utilizamos uma máquina de estados finitos (FSM). Uma FSM é um modelo matemático que descreve o comportamento de um sistema. Ela opera em diferentes estados (como IDLE, PROCESSING, DONE_STATE, etc.) e muda de um estado para outro com base nas entradas, controlando a sequência de ações do processador de forma ordenada e previsível.

Estrutura do Projeto
O projeto é composto pelos seguintes arquivos:

ula.vhd: Implementa a Unidade Lógica e Aritmética (ULA), responsável por realizar as operações matemáticas e lógicas (como soma, subtração, etc.).

banco_registrador.vhd: Gerencia o banco de registradores, que armazena os dados temporários e os resultados das operações.

controle_processador.vhd: É a máquina de estados finitos que recebe a instrução e a traduz para os demais componentes do processador.

cpu.vhd: O componente principal que integra todos os módulos (ula, banco_registrador e controle_processador), fazendo a conexão e o gerenciamento do fluxo de dados.

tb_cpu.vhd: O testbench para a cpu.vhd, que testa as operações e a lógica do processador, incluindo a detecção de instruções inválidas.

Detalhes da Instrução e Operação
A instrução é codificada em 8 bits, lidos da esquerda para a direita, seguindo o formato [bit 7][bit 6][bit 5][bit 4][bit 3][bit 2][bit 1][bit 0].

Bit 7: Habilita a leitura e escrita.

Bits 6 a 4: Definem a operação a ser realizada pela ULA.

Bits 3 e 2: Indicam o registrador de origem A no banco de registradores.

Bits 1 e 0: Indicam o registrador de origem B no banco de registradores.

Controle do Processador
A máquina de estados finitos (controle_processador) possui quatro estados principais:

IDLE: Estado inicial e de espera, aguardando uma nova instrução.

PROCESSING: Estado de processamento, onde a operação da ULA é executada.

DONE_STATE: Indica que o processamento foi concluído com sucesso.

INVALID: Estado de erro, ativado quando uma instrução inválida é recebida.

A leitura de uma nova instrução é habilitada no início de um novo processamento. A escrita do resultado nos registradores só ocorre quando a máquina de estados retorna para o estado IDLE após o DONE_STATE. A transição para o estado INVALID acontece apenas se uma operação não reconhecida for passada. O testbench (tb_cpu) inclui testes para validar esse comportamento.
