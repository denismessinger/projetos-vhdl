library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  

entity operacoes_8bits is
    PORT ( A       : in  STD_LOGIC_VECTOR(7 downto 0);  -- Operando A de 8 bits
           B       : in  STD_LOGIC_VECTOR(7 downto 0);  -- Operando B de 8 bits
           OP      : in  STD_LOGIC_VECTOR(2 downto 0);  -- OP de 3 bits, define e operacao
           RESULT  : out STD_LOGIC_VECTOR(15 downto 0);  -- Resultado da multiplicação e spma (16 bits)
	   flag    : out STD_LOGIC   -- Sinaliza a flag de saida
         );
end operacoes_8bits;

architecture arquitetura_operacoes_8bits of operacoes_8bits is
begin

    RESULT <=  std_logic_vector(resize(unsigned(A) + unsigned(B), 16)) WHEN OP = "000" ELSE
               std_logic_vector(resize(unsigned(A) * unsigned(B), 16)) WHEN OP = "001" ELSE
               (others => '0');  

    flag <= '1' WHEN (OP = "100" AND A = "00000000") ELSE  -- A = 0
            '1' WHEN (OP = "101" AND unsigned(A) = unsigned(B)) ELSE  -- A = B
            '1' WHEN (OP = "110" AND unsigned(A) < unsigned(B)) ELSE  -- A < B
            '1' WHEN (OP = "111" AND unsigned(A) > unsigned(B)) ELSE  -- A > B
            '0';  -- Caso contrário, a flag é desativada

end arquitetura_operacoes_8bits;
