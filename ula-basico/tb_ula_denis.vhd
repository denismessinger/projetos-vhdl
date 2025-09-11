LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY tb_ula_denis IS
END tb_ula_denis;

ARCHITECTURE arquitetura_tb_ula_denis OF tb_ula_denis IS

    -- Declara??o do componente Full Adder a ser testado
    COMPONENT operacoes_8bits
        PORT ( 
	   A                 : in  STD_LOGIC_VECTOR(7 downto 0);  -- Operando A de 8 bits
           B                 : in  STD_LOGIC_VECTOR(7 downto 0);  -- Operando B de 8 bits
           OP                : in  STD_LOGIC_VECTOR(2 downto 0);  -- OP de 3 bits, define e operacao
           RESULT            : out STD_LOGIC_VECTOR(15 downto 0);  -- Resultado da multiplicação e spma (16 bits)
	   flag_Aequal0      : out STD_LOGIC;   -- Sinaliza se A = 0
	   flag_AequalB      : out STD_LOGIC;   -- Sinaliza se A = B
	   flag_Alessthan0   : out STD_LOGIC;   -- Sinaliza se A < B
	   flag_Agreatertan0 : out STD_LOGIC    -- Sinaliza se A > B
        );
    END COMPONENT;

    -- Sinais internos para conectar ao DUT
    SIGNAL A, B : STD_LOGIC_VECTOR(7 downto 0);
    SIGNAL OP : STD_LOGIC_VECTOR(2 downto 0);
    SIGNAL RESULT : STD_LOGIC_VECTOR(15 downto 0);
    SIGNAL flag_Aequal0, flag_AequalB, flag_Alessthan0,flag_Agreatertan0 : STD_LOGIC;

BEGIN

    -- Inst?ncia do DUT (Device Under Test)
    dut: operacoes_8bits PORT MAP (
        A    => A,
        B    => B,
        OP   => OP,
        RESULT  => RESULT,
	flag_Aequal0  => flag_Aequal0,
	flag_AequalB  => flag_AequalB,
	flag_Alessthan0  => flag_Alessthan0,
        flag_Agreatertan0 => flag_Agreatertan0
    );

    -- Processo de gera??o de est?mulos
    stim_proc: PROCESS
    BEGIN

        -- Aplicando combina??es de entrada para testar o DUT
        A <= "00000001"; B <= "00000001"; OP <= "000"; WAIT FOR 50 ps; -- Soma
        A <= "00000001"; B <= "00000000"; OP <= "000"; WAIT FOR 50 ps; -- Soma
        A <= "00000011"; B <= "00000101"; OP <= "000"; WAIT FOR 50 ps; -- Soma
        A <= "00001000"; B <= "00000001"; OP <= "000"; WAIT FOR 50 ps; -- Soma
        A <= "00000001"; B <= "00000001"; OP <= "001"; WAIT FOR 50 ps; -- Multiplicação
        A <= "11111111"; B <= "00000000"; OP <= "001"; WAIT FOR 50 ps; -- Multiplicação
	A <= "00000111"; B <= "00000011"; OP <= "001"; WAIT FOR 50 ps; -- Multiplicação
        A <= "00001001"; B <= "00000101"; OP <= "001"; WAIT FOR 50 ps; -- Multiplicação
        A <= "00000111"; B <= "00000011"; OP <= "100"; WAIT FOR 50 ps; -- A = 0
        A <= "00000000"; B <= "00000001"; OP <= "100"; WAIT FOR 50 ps; -- A = 0
        A <= "00000011"; B <= "00000001"; OP <= "101"; WAIT FOR 50 ps; -- A = B
	A <= "00000011"; B <= "00000011"; OP <= "101"; WAIT FOR 50 ps; -- A = B
        A <= "00000001"; B <= "00000101"; OP <= "110"; WAIT FOR 50 ps; -- A < B
        A <= "00000101"; B <= "00000001"; OP <= "110"; WAIT FOR 50 ps; -- A < B
        A <= "00000001"; B <= "00000011"; OP <= "111"; WAIT FOR 50 ps; -- A > B
        A <= "00000011"; B <= "00000001"; OP <= "111"; WAIT FOR 50 ps; -- A > B
        
        -- Finaliza o teste
        WAIT;

    END PROCESS;

END arquitetura_tb_ula_denis;
