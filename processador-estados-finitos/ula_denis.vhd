library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  

entity operacoes_8bits is
    PORT ( 
        clk     : in  STD_LOGIC;                     -- Clock de entrada
        enable  : in  STD_LOGIC;                     -- Habilita a opera��o
        A       : in  STD_LOGIC_VECTOR(7 downto 0);  -- Operando A de 8 bits
        B       : in  STD_LOGIC_VECTOR(7 downto 0);  -- Operando B de 8 bits
        OP      : in  STD_LOGIC_VECTOR(2 downto 0);  -- OP de 3 bits, define a opera��o
        RESULT  : out STD_LOGIC_VECTOR(15 downto 0); -- Resultado da opera��o
        flag    : out STD_LOGIC                      -- Flag de sa�da
    );
end operacoes_8bits;

architecture arquitetura_operacoes_8bits of operacoes_8bits is
    signal RESULT_reg : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal flag_reg   : STD_LOGIC := '0';
begin
    PROCESS(clk, OP, A, B)
    BEGIN
        IF rising_edge(clk) THEN
            IF enable = '1' THEN
                -- Calcula o resultado baseado na opera��o
		RESULT_reg <= (others => '0');
                CASE OP IS
                    WHEN "000" => -- Soma
                        RESULT_reg <= std_logic_vector(resize(unsigned(A) + unsigned(B), 16));
                    WHEN "001" => -- Multiplica��o
                        RESULT_reg <= std_logic_vector(resize(unsigned(A) * unsigned(B), 16));
                    WHEN OTHERS => -- Opera��o inv�lida
                        RESULT_reg <= (others => '0');
                END CASE;

                -- Calcula a flag
                CASE OP IS
                    WHEN "100" => -- Verifica se A � zero
                        IF A = "00000000" THEN
                            flag_reg <= '1';
                        ELSE
                            flag_reg <= '0';
                        END IF;
                    WHEN "101" => -- Verifica se A � igual a B
                        IF unsigned(A) = unsigned(B) THEN
                            flag_reg <= '1';
                        ELSE
                            flag_reg <= '0';
                        END IF;
                    WHEN "110" => -- Verifica se A < B
                        IF unsigned(A) < unsigned(B) THEN
                            flag_reg <= '1';
                        ELSE
                            flag_reg <= '0';
                        END IF;
                    WHEN "111" => -- Verifica se A > B
                        IF unsigned(A) > unsigned(B) THEN
                            flag_reg <= '1';
                        ELSE
                            flag_reg <= '0';
                        END IF;
                    WHEN OTHERS => -- Caso inv�lido
                        flag_reg <= '0';
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- Mapeia os sinais internos para as sa�das
    RESULT <= RESULT_reg;
    flag <= flag_reg;
end arquitetura_operacoes_8bits;

