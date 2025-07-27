LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY tb_full_adder IS
END tb_full_adder;

ARCHITECTURE arquitetura_tb_full_adder OF tb_full_adder IS

    -- Declara??o do componente Full Adder a ser testado
    COMPONENT full_adder
        PORT (
            A    : in  STD_LOGIC;
            B    : in  STD_LOGIC;
            Cin  : in  STD_LOGIC;
            sum  : out STD_LOGIC;
            Cout : out STD_LOGIC
        );
    END COMPONENT;

    -- Sinais internos para conectar ao DUT
    SIGNAL A, B, Cin : STD_LOGIC;
    SIGNAL sum, Cout : STD_LOGIC;

BEGIN

    -- Inst?ncia do DUT (Device Under Test)
    dut: full_adder PORT MAP (
        A    => A,
        B    => B,
        Cin  => Cin,
        sum  => sum,
        Cout => Cout
    );

    -- Processo de gera??o de est?mulos
    stim_proc: PROCESS
    BEGIN

        -- Aplicando combina??es de entrada para testar o DUT
        A <= '0'; B <= '0'; Cin <= '0'; WAIT FOR 10 ns;
        A <= '0'; B <= '0'; Cin <= '1'; WAIT FOR 10 ns;
        A <= '0'; B <= '1'; Cin <= '0'; WAIT FOR 10 ns;
        A <= '0'; B <= '1'; Cin <= '1'; WAIT FOR 10 ns;
        A <= '1'; B <= '0'; Cin <= '0'; WAIT FOR 10 ns;
        A <= '1'; B <= '0'; Cin <= '1'; WAIT FOR 10 ns;
        A <= '1'; B <= '1'; Cin <= '0'; WAIT FOR 10 ns;
        A <= '1'; B <= '1'; Cin <= '1'; WAIT FOR 10 ns;
        
        -- Finaliza o teste
        WAIT;

    END PROCESS;

END arquitetura_tb_full_adder;