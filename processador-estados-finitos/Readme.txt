Detalhes dos arquivos:

Projeto é composto de 5 arquivos, a ula, banco_registradore, controle_processador, 
que é a maquina de estados finitos que recebe a instrução e transcreve para os demais componentes, 
a cpu que faz a ligação de tudo. Além desses tambem consta o arquivo para testes tb_cpu, que faz a testagem
dos calculos e regras implementadas.

Detalhes do projeto:

Para montar a instrução e traduzi-la para os registradores e ula utilizei os seguintes parametros.

Instrução de 8 bits lendo da esquerda para a direita, exemplo '10010101':
- 1° Bit '1' habilita leitura e escrita, não sei se era necessário mas ia sobrar e utilizei;
- 2° ao 4° Bit's, essa é a instrução da operação a ser realizada pela ULA;
- 5° e 6° Bit's, esses são os bits que indicarão o registrador A para o banco;
- 7° e 8° Bit's, esses são os bits que indicarão o registrador B para o banco;

O controle de processador, a maquina de estados finitos, criei 4 estados para ela, IDLE, PROCESSING, DONE_STATE
e INVALID, ele só habilitara a leitura quando começar um novo processamento e escrita dos resultados quando voltar
para o IDLE depois do DONE_STATE, o erro nesse caso só é alcançado se uma operação invalida for passada, coloquei
um teste disso no tb_cpu, nesse também programei mais ou menos os tempos entre um ciclo de processo e outro para ficar
1 processamento para cada teste feito.