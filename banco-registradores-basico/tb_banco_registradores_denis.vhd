LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY tb_banco_registradores_denis IS
END tb_banco_registradores_denis;

ARCHITECTURE arquitetura_tb_banco_registradores_denis OF tb_banco_registradores_denis IS

    -- Sinais de entrada e saída para o banco de registradores
    signal clk           : STD_LOGIC := '0';   -- Sinal de clock
    signal rst           : STD_LOGIC := '0';   -- Sinal de reset
    signal read_enable   : STD_LOGIC := '0';   -- Sinal de leitura ativado
    signal adress_opa    : STD_LOGIC_VECTOR(1 downto 0);  -- Endereço do operando A (2 bits)
    signal adress_opb    : STD_LOGIC_VECTOR(1 downto 0);  -- Endereço do operando B (2 bits)
    signal operando_a    : STD_LOGIC_VECTOR(7 downto 0);  -- Valor de saída do operando A (8 bits)
    signal operando_b    : STD_LOGIC_VECTOR(7 downto 0);  -- Valor de saída do operando B (8 bits)

    -- Constante para simular o clock de 32.768 kHz
    constant CLOCK_PERIOD : time := 30.517 us;  -- Aproximadamente 1/(32.768 kHz)

BEGIN

    -- Instancia o banco de registradores
    DUT: ENTITY work.banco_registradores_denis
        PORT MAP (
            clk          => clk,
            rst          => rst,
            read_enable  => read_enable,
            adress_opa   => adress_opa,
            adress_opb   => adress_opb,
            operando_a   => operando_a,
            operando_b   => operando_b
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

        -- Inicializa o reset e o read_enable
        rst <= '1';
        read_enable <= '0';
        adress_opa <= "00";
        adress_opb <= "00";
        
        -- Aguarda um tempo para garantir o reset e gerar valores aleatórios nos registradores
        WAIT FOR 100 us;
        rst <= '0';  -- Desativa o reset

        -- Teste 1: Verificando a leitura de operando A e B com endereços diferentes
        -- Habilita a leitura (read_enable = '1')
        read_enable <= '1';
        adress_opa <= "00";  -- Lê o registrador 0
        adress_opb <= "01";  -- Lê o registrador 1
        WAIT FOR 50 us;  -- Espera para simular a leitura
        
        -- Teste 2: Modificando os endereços e verificando os valores
        adress_opa <= "10";  -- Lê o registrador 2
        adress_opb <= "11";  -- Lê o registrador 3
        WAIT FOR 50 us;  -- Espera para simular a leitura
        
        -- Teste 3: Desabilitando a leitura e verificando que os operandos não mudam
        read_enable <= '0';
        WAIT FOR 50 us;

        -- Teste 4: Reiniciando o sistema e verificando os novos valores aleatórios após o reset
        rst <= '1';
        WAIT FOR 100 us;

        rst <= '0';  -- Desativa o reset
        WAIT FOR 50 us;
        
        WAIT;
        
    END PROCESS;

END arquitetura_tb_banco_registradores_denis;

