library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

ENTITY full_adder IS
    PORT (
        A     : in  STD_LOGIC;  -- Entrada A
        B     : in  STD_LOGIC;  -- Entrada B
        Cin   : in  STD_LOGIC;  -- Carry de entrada
        sum   : out STD_LOGIC;  -- Sa?da de soma
        Cout  : out STD_LOGIC   -- Carry de sa?da
    );
END full_adder;

ARCHITECTURE arquitetura_full_adder OF full_adder IS

    -- Declara??o do componente Half Adder
    COMPONENT half_adder
        PORT (
            A     : in  STD_LOGIC;
            B     : in  STD_LOGIC;
            sum   : out STD_LOGIC;
            carry : out STD_LOGIC
        );
    END COMPONENT;

    -- Sinais internos para interligar as sa?das dos Half Adders
    signal S1, C1, C2 : STD_LOGIC;

BEGIN

    -- Primeira inst?ncia do Half Adder para somar A e B
    HA1: half_adder PORT MAP (
        A     => A,
        B     => B,
        sum   => S1,    -- Soma intermedi?ria
        carry => C1     -- Carry intermedi?rio
    );

    -- Segunda inst?ncia do Half Adder para somar S1 e Cin
    HA2: half_adder PORT MAP (
        A     => S1,
        B     => Cin,
        sum   => sum,   -- Soma final
        carry => C2     -- Segundo carry intermedi?rio
    );

    -- Defini??o do carry de sa?da final
    Cout <= C1 OR C2;

END arquitetura_full_adder;
