LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY half_adder IS
    PORT (
        A    : in  STD_LOGIC;  -- Entrada A
        B    : in  STD_LOGIC;  -- Entrada B
        sum  : out STD_LOGIC;  -- Saida de soma
        carry: out STD_LOGIC   -- Saida de carry
    );
END half_adder;

ARCHITECTURE arquitetura_half_adder OF half_adder IS
BEGIN

    sum   <= A XOR B;    -- Soma a operacaoo XOR de A e B
    carry <= A AND B;    -- Carry a operacao AND de A e B

END arquitetura_half_adder;
