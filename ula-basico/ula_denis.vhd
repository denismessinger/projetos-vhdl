-- Definindo a arquitetura para as operações de soma e multiplicação
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  

entity operacoes_8bits is
    Port ( A                 : in  STD_LOGIC_VECTOR(7 downto 0);  -- Operando A de 8 bits
           B                 : in  STD_LOGIC_VECTOR(7 downto 0);  -- Operando B de 8 bits
           OP                : in  STD_LOGIC_VECTOR(2 downto 0);  -- OP de 3 bits, define e operacao
           RESULT            : out STD_LOGIC_VECTOR(15 downto 0);  -- Resultado da multiplicação e spma (16 bits)
	   flag_Aequal0      : out STD_LOGIC;   -- Sinaliza se A = 0
	   flag_AequalB      : out STD_LOGIC;   -- Sinaliza se A = B
	   flag_Alessthan0   : out STD_LOGIC;   -- Sinaliza se A < B
	   flag_Agreatertan0 : out STD_LOGIC    -- Sinaliza se A > B
         );
end operacoes_8bits;

architecture Behavioral of operacoes_8bits is
begin

   RESULT <=  std_logic_vector(resize(unsigned(A) + unsigned(B), 16)) WHEN OP = "000" ELSE
              std_logic_vector(resize(unsigned(A) * unsigned(B), 16)) WHEN OP = "001" ELSE
              (others => '0');  

    flag_Aequal0      <= '1' WHEN OP = "100" AND A = "00000000" ELSE '0';
    flag_AequalB      <= '1' WHEN OP = "101" AND unsigned(A) = unsigned(B) ELSE '0';
    flag_Alessthan0   <= '1' WHEN OP = "110" AND unsigned(A) < unsigned(B) ELSE '0';
    flag_Agreatertan0 <= '1' WHEN OP = "111" AND unsigned(A) > unsigned(B) ELSE '0';
   
end Behavioral;
