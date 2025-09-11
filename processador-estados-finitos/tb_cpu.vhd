LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY tb_cpu IS
END tb_cpu;

ARCHITECTURE arquitetura_tb_cpu OF tb_cpu IS

    -- Sinal de clock e outros sinais de controle
    signal clk               : STD_LOGIC := '0'; -- Sinal de clock
    signal rst               : STD_LOGIC := '0'; -- Sinal de reset
    signal instruction       : STD_LOGIC_VECTOR(7 downto 0); -- Instrução
    signal run               : STD_LOGIC := '0'; -- Sinal de execução
    signal COMPAL            : STD_LOGIC; -- Flag de comparação
    signal RESULT            : STD_LOGIC_VECTOR(15 downto 0); -- Resultado da operação
    signal DONE              : STD_LOGIC; -- Flag de operação concluída
    signal INVALID           : STD_LOGIC; -- Flag de erro

    -- Constantes para simulação
    constant CLOCK_PERIOD : time := 30.517 us;  -- Aproximadamente 1/(32.768 kHz)

BEGIN
	
    UUT: ENTITY work.cpu
        PORT MAP (
            clk         => clk,
            rst         => rst,
            instruction => instruction,
            run         => run,
            COMPAL      => COMPAL,
            RESULT      => RESULT,
            DONE        => DONE,
            INVALID     => INVALID
        );

    -- Processo para gerar o clock de 32.768 kHz
    clk_process : PROCESS
    BEGIN
        -- Gera o sinal de clock (borda de subida)
        clk <= '0';
        wait for CLOCK_PERIOD / 2;
        clk <= '1';
        wait for CLOCK_PERIOD / 2;
    END PROCESS;

    -- Processo para a simulação do comportamento do Testbench
    stim_proc: PROCESS
    BEGIN
        -- Inicialização
        rst <= '1';
        run <= '0';
        instruction <= (others => '0');
        WAIT FOR 20 ns;
        
        -- Desativa o reset
        rst <= '0';
	WAIT FOR 20 ns;

        -- Teste 2: Instrução de soma A = 00000000 e B = 11001100
	run <= '1';
        instruction <= "10000001";  
	WAIT FOR 160 us;
	assert (RESULT = "0000000011001100") --Testa o resultado antes de passar para o proximo teste
        report "Erro: resultado está incorreto!"
        severity warning;
        WAIT FOR 60 us;

	-- Teste 2.1: Instrução de soma A = 11110000 e B = 00001111
        instruction <= "10001110";  
        run <= '1';
        WAIT FOR 182 us;
	assert (RESULT = "0000000011111111") --Testa o resultado antes de passar para o proximo teste
        report "Erro: resultado está incorreto!"
        severity warning;

        -- Teste 3: Instrução de multiplicação A = 00000000 e B = 11001100
        instruction <= "10010001";  
        run <= '1';
        WAIT FOR 182 us;
	assert (RESULT = "0000000000000000") --Testa o resultado antes de passar para o proximo teste
        report "Erro: resultado está incorreto!"
        severity warning;

	-- Teste 4: Verifica se A = 00000000 é igual a 0
        instruction <= "11000011"; 
        run <= '1';
        WAIT FOR 182 us;
	assert (COMPAL = '1') --Testa o resultado antes de passar para o proximo teste
        report "Erro: resultado está incorreto!"
        severity warning;

	-- Teste 4.1: Verifica se A = 11001100 é igual a 0
        instruction <= "11000111"; 
        run <= '1';
        WAIT FOR 182 us;
	assert (COMPAL = '0') --Testa o resultado antes de passar para o proximo teste
        report "Erro: resultado está incorreto!"
        severity warning;

	--Teste 5: Verifica se A = 00000000 é igual a B = 00000000
        instruction <= "11010000"; 
        run <= '1';
        WAIT FOR 182 us;
	assert (COMPAL = '1') --Testa o resultado antes de passar para o proximo teste
        report "Erro: resultado está incorreto!"
        severity warning;

	--Teste 5.1: Verifica se A = 00000000 é igual a B = 11001100
        instruction <= "11010001"; 
        run <= '1';
        WAIT FOR 182 us;
	assert (COMPAL = '0') --Testa o resultado antes de passar para o proximo teste
        report "Erro: resultado está incorreto!"
        severity warning;

	--Teste 6: Verifica se A = 00000000 é menor que B = 11001100
        instruction <= "11100001"; 
        run <= '1';
        WAIT FOR 182 us;
	assert (COMPAL = '1') --Testa o resultado antes de passar para o proximo teste
        report "Erro: resultado está incorreto!"
        severity warning;

	--Teste 6: Verifica se A = 00000000 é menor que B = 00000000
        instruction <= "11100000"; 
        run <= '1';
        WAIT FOR 182 us;
	assert (COMPAL = '0') --Testa o resultado antes de passar para o proximo teste
        report "Erro: resultado está incorreto!"
        severity warning;

	--Teste 7: Verifica se A = 11001100 é maior que B = 00000000
        instruction <= "11110100"; 
        run <= '1';
        WAIT FOR 182 us;
	assert (COMPAL = '1') --Testa o resultado antes de passar para o proximo teste
        report "Erro: resultado está incorreto!"
        severity warning;

	--Teste 7.1: Verifica se A = 00000000 é maior que B = 00000000
        instruction <= "11110000"; 
        run <= '1';
        WAIT FOR 182 us;
	assert (COMPAL = '0') --Testa o resultado antes de passar para o proximo teste
        report "Erro: resultado está incorreto!"
        severity warning;

	-- Teste 8: Instrução com falha (erro no controlador)
        instruction <= "10111010";  
        run <= '1';
        WAIT FOR 182 us;
	assert (RESULT = "0000000000000000") --Testa variavel zerada após erro
        report "Erro: resultado está incorreto!"
        severity warning;	

        -- Fim dos testes
        WAIT;
    END PROCESS;

END arquitetura_tb_cpu;

