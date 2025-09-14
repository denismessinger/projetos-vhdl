LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY parallel_to_serial IS
    PORT (
        clk           : in  STD_LOGIC;                -- Clock de entrada
        rst           : in  STD_LOGIC;                -- Sinal de reset
        start         : in  STD_LOGIC;                -- Porta de in?cio da serializa??o
        parallel_data : in  STD_LOGIC_VECTOR(7 downto 0); -- Byte de entrada (8 bits)
        serial_data   : out STD_LOGIC;                -- Sa?da serial de 1 bit
        done          : out STD_LOGIC                 -- Sinal que indica que a serializa??o terminou
    );
END parallel_to_serial;

ARCHITECTURE arquitetura_parallel_to_serial OF parallel_to_serial IS

    signal shift_register : STD_LOGIC_VECTOR(7 downto 0);  -- Registrador de deslocamento interno
    signal bit_count      : INTEGER range 0 to 8 := 0;     -- Contador de bits
    signal shifting       : STD_LOGIC := '0';              -- Indica se a serializa??o est? em andamento

BEGIN

    PROCESS(clk, rst)
    BEGIN

        IF rst = '1' THEN
            
	    -- Reseta o registrador, contador e sinais de controle
            shift_register <= (others => '0');
            serial_data <= '0';
            bit_count <= 0;
            done <= '0';
            shifting <= '0';

        ELSIF clk'event and clk = '1' THEN

            IF start = '1' THEN
                -- Inicia a serializa??o
                shift_register <= parallel_data;  -- Carrega o dado de entrada no registrador
                bit_count <= 0;
                shifting <= '1';
                done <= '0';
            END IF;
            
            IF shifting = '1' THEN
                -- Serializa??o em andamento
                serial_data <= shift_register(0); -- Envia o bit menos significativo
                shift_register <= '0' & shift_register(7 downto 1); -- Desloca para a direita
                
                IF bit_count = 7 THEN
                    -- Serializa??o conclu?da ap?s 8 bits
                    done <= '1';
                    shifting <= '0';  -- Para a serializa??o
                ELSE
                    bit_count <= bit_count + 1;
                END IF;

            END IF;

        END IF;

    END PROCESS;

END arquitetura_parallel_to_serial;

