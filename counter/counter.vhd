LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY counter IS
    PORT (
        clk          : in  STD_LOGIC;                     -- Clock
        rst          : in  STD_LOGIC;                     -- Reset assíncrono
        start        : in  STD_LOGIC;                     -- Sinal de início
        target_value : in  UNSIGNED(31 downto 0);         -- Valor de término
        done         : out STD_LOGIC                      -- Indica fim da contagem
    );
END counter;

ARCHITECTURE rtl OF counter IS

    SIGNAL counter_reg : UNSIGNED(31 downto 0) := (others => '0');
    SIGNAL counting    : STD_LOGIC := '0';
    SIGNAL done_reg    : STD_LOGIC := '0';

BEGIN

    PROCESS(clk, rst)
    BEGIN
        IF rst = '1' THEN
            counter_reg <= (others => '0');
            counting    <= '0';
            done_reg    <= '0';

        ELSIF rising_edge(clk) THEN

            IF start = '1' AND counting = '0' THEN
                -- Inicia a contagem
                counter_reg <= (others => '0');
                counting    <= '1';
                done_reg    <= '0';

            ELSIF counting = '1' THEN
                IF counter_reg = target_value THEN
                    -- Atingiu o valor alvo
                    done_reg <= '1';
                    counting <= '0';
                ELSE
                    -- Incrementa
                    counter_reg <= counter_reg + 1;
                END IF;
            END IF;

        END IF;
    END PROCESS;

    done <= done_reg;

END rtl;
