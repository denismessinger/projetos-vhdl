LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY banco_registradores_denis IS
    PORT (
        clk           : in  STD_LOGIC;                     -- Clock de entrada
        rst           : in  STD_LOGIC;                     -- Sinal de reset
        read_enable   : in  STD_LOGIC;                     -- Habilita a leitura dos registradores
        adress_opa    : in  STD_LOGIC_VECTOR(1 downto 0);   -- Endereço do registrador A (2 bits)
        adress_opb    : in  STD_LOGIC_VECTOR(1 downto 0);   -- Endereço do registrador B (2 bits)
        operando_a    : out STD_LOGIC_VECTOR(7 downto 0);   -- Valor de saída do operando A (8 bits)
        operando_b    : out STD_LOGIC_VECTOR(7 downto 0)    -- Valor de saída do operando B (8 bits)
    );
END banco_registradores_denis;

ARCHITECTURE arquitetura_banco_registradores_denis OF banco_registradores_denis IS
    -- Definir 4 registradores de 8 bits
    SIGNAL reg0, reg1, reg2, reg3 : STD_LOGIC_VECTOR(7 downto 0);
BEGIN

    PROCESS(clk, rst)
    BEGIN
        IF rst = '1' THEN
            -- Gerar valores aleatórios e armazenar nos registradores
            reg0 <= "00000000";  -- Exemplo de valor aleatório
            reg1 <= "11001100";  -- Exemplo de valor aleatório
            reg2 <= "11110000";  -- Exemplo de valor aleatório
            reg3 <= "00001111";  -- Exemplo de valor aleatório
        ELSIF rising_edge(clk) THEN
            -- Caso read_enable esteja ativo, ler os valores dos registradores
            IF read_enable = '1' THEN
                CASE adress_opa IS
                    WHEN "00" => operando_a <= reg0;
                    WHEN "01" => operando_a <= reg1;
                    WHEN "10" => operando_a <= reg2;
                    WHEN "11" => operando_a <= reg3;
                    WHEN OTHERS => operando_a <= (others => '0');
                END CASE;

                CASE adress_opb IS
                    WHEN "00" => operando_b <= reg0;
                    WHEN "01" => operando_b <= reg1;
                    WHEN "10" => operando_b <= reg2;
                    WHEN "11" => operando_b <= reg3;
                    WHEN OTHERS => operando_b <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

END arquitetura_banco_registradores_denis;

