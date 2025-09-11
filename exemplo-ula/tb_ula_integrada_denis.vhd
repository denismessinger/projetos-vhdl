LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY tb_ula_integrada_denis IS
END tb_ula_integrada_denis;

ARCHITECTURE arquitetura_tb_ula_integrada_denis OF tb_ula_integrada_denis IS

    -- Sinais de entrada e saída para a ULA integrada
    signal clk               : STD_LOGIC := '0'; -- Sinal de clock
    signal rst               : STD_LOGIC := '0'; -- Sinal de reset
    signal read_enable       : STD_LOGIC := '0'; -- Habilita a leitura do banco de registradores
    signal adress_opa        : STD_LOGIC_VECTOR(1 downto 0); -- Endereço do operando A (2 bits)
    signal adress_opb        : STD_LOGIC_VECTOR(1 downto 0); -- Endereço do operando B (2 bits)
    signal write_enable      : STD_LOGIC := '0'; -- Habilita a escrita dos resultados
    signal OP                : STD_LOGIC_VECTOR(2 downto 0); -- Sinal de controle da operação (3 bits)
    signal RESULT            : STD_LOGIC_VECTOR(15 downto 0); -- Resultado da operação (16 bits)
    signal flag              : STD_LOGIC; -- Flag 

    -- Constantes para simulação
    constant CLOCK_PERIOD : time := 30.517 us;  -- Aproximadamente 1/(32.768 kHz)

BEGIN

    -- Instancia a ULA integrada
    DUT: ENTITY work.ula_integrada_denis
        PORT MAP (
            clk             => clk,
            rst             => rst,
            read_enable     => read_enable,
            adress_opa      => adress_opa,
            adress_opb      => adress_opb,
            write_enable    => write_enable,
            OP              => OP,
            RESULT          => RESULT,
            flag            => flag
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
    stimulus_process : PROCESS
    BEGIN
        -- Inicializa os sinais
        rst <= '1';
        read_enable <= '0';
        adress_opa <= "00";  -- Inicializa os endereços
        adress_opb <= "00";  -- Inicializa os endereços
        OP <= "000";         -- Inicializa a operação com adição
        
        -- Aguarda um tempo para garantir o reset
        WAIT FOR 100 us;
        rst <= '0';  -- Desativa o reset

        -- Teste 1: Teste de carregamento e escrita com todas operações
        read_enable <= '1';  -- Habilita a leitura (read_enable = '1')
        adress_opa <= "00";  -- Lê o registrador 0
        adress_opb <= "01";  -- Lê o registrador 1
        WAIT FOR 50 us;
	write_enable <= '1';
	WAIT FOR 50 us;
        OP <= "000";  -- Define a operação como adição
        WAIT FOR 50 us; 
	OP <= "001";  -- Define a operação como multiplicação
        WAIT FOR 50 us;  
        OP <= "100";  -- Define a operação como comparação A=0
        WAIT FOR 50 us;  
	OP <= "101";  -- Define a operação como comparação A=B
        WAIT FOR 50 us;
	OP <= "110";  -- Define a operação como comparação A<B
        WAIT FOR 50 us;
	OP <= "111";  -- Define a operação como comparação A>B
        WAIT FOR 50 us;

	-- Teste 2: Teste de carregamento e escrita com todas operações e outras variaveis, lendo mesmo regisrador
        read_enable <= '1';  -- Habilita a leitura (read_enable = '1')
        adress_opa <= "01";  -- Lê o registrador 0
        adress_opb <= "01";  -- Lê o registrador 1
        WAIT FOR 50 us; 
	write_enable <= '1';
	WAIT FOR 50 us;
        OP <= "000";  -- Define a operação como adição
        WAIT FOR 50 us; 
	OP <= "001";  -- Define a operação como multiplicação
        WAIT FOR 50 us;  
        OP <= "100";  -- Define a operação como comparação A=0
        WAIT FOR 50 us;  
	OP <= "101";  -- Define a operação como comparação A=B
        WAIT FOR 50 us;
	OP <= "110";  -- Define a operação como comparação A<B
        WAIT FOR 50 us;
	OP <= "111";  -- Define a operação como comparação A>B
        WAIT FOR 50 us;

	-- Teste 3: Teste de carregamento e escrita com todas operações e outras variaveis
        read_enable <= '1';  -- Habilita a leitura (read_enable = '1')
        adress_opa <= "11";  -- Lê o registrador 0
        adress_opb <= "10";  -- Lê o registrador 1
        WAIT FOR 50 us; 
	write_enable <= '1';
	WAIT FOR 50 us;
        OP <= "000";  -- Define a operação como adição
        WAIT FOR 50 us; 
	OP <= "001";  -- Define a operação como multiplicação
        WAIT FOR 50 us;  
        OP <= "100";  -- Define a operação como comparação A=0
        WAIT FOR 50 us;  
	OP <= "101";  -- Define a operação como comparação A=B
        WAIT FOR 50 us;
	OP <= "110";  -- Define a operação como comparação A<B
        WAIT FOR 50 us;
	OP <= "111";  -- Define a operação como comparação A>B
        WAIT FOR 50 us;

        -- Teste 4: Modificando os endereços e testando o read_enable desativado, o resultado deve
	-- ficar igual a soma dos ultimos endere;os lidos 11 e 10 que 0000000011111111.
	read_enable <= '0';  -- Desabilita a leitura (read_enable = '0')
	WAIT FOR 50 us; 
        adress_opa <= "00";  -- Lê o registrador 2
        adress_opb <= "11";  -- Lê o registrador 3
        WAIT FOR 50 us;  
        OP <= "000";  -- Define a operação como soma
        WAIT FOR 50 us;  

	-- Teste 5: Modificando os endereços e testando o write_enable desativado, o resultado desse 
	-- não devera ser impresso
	read_enable <= '1';  -- Habilita a leitura (read_enable = '1')
        adress_opa <= "10";  -- Lê o registrador 2
        adress_opb <= "11";  -- Lê o registrador 3
        WAIT FOR 50 us; 
	write_enable <= '0';  -- Desabilita a escrita (write_enable = '0')
	WAIT FOR 50 us;
        OP <= "000";  -- Define a operação como soma
        WAIT FOR 50 us; 

        -- Teste 6: Desabilita a leitura e verifica se o valor dos operandos não muda
        read_enable <= '0';
        WAIT FOR 50 us;

        -- Teste 7: Reinicia o sistema e verifica o comportamento após o reset
        rst <= '1';
        WAIT FOR 100 us;

        rst <= '0';  -- Desativa o reset
        WAIT FOR 50 us;

        -- Finaliza a simulação
        WAIT;
    END PROCESS;

END arquitetura_tb_ula_integrada_denis;

