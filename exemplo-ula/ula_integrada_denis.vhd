library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

ENTITY ula_integrada_denis IS
   PORT (
        clk                 : in  STD_LOGIC;                   -- Clock de entrada
        rst                 : in  STD_LOGIC;                   -- Sinal de reset
        read_enable         : in  STD_LOGIC;                   -- Habilita a leitura dos registradores
        write_enable        : in  STD_LOGIC;                   -- Habilita a leitura dos registradores
        adress_opa          : in  STD_LOGIC_VECTOR(1 downto 0); -- Endereço do registrador A (2 bits)
        adress_opb          : in  STD_LOGIC_VECTOR(1 downto 0); -- Endereço do registrador B (2 bits)
        OP                  : in  STD_LOGIC_VECTOR(2 downto 0); -- Sinal de controle da operação (3 bits)
        flag	            : out STD_LOGIC;
        RESULT              : out STD_LOGIC_VECTOR(15 downto 0) -- Resultado da operação (16 bits)
    );
END ula_integrada_denis;

ARCHITECTURE arquitetura_ula_integrada_denis OF ula_integrada_denis IS

    -- Definição do componente do banco de registradores
    COMPONENT banco_registradores_denis
        Port (
            clk           : in  STD_LOGIC;                     -- Clock de entrada
            rst           : in  STD_LOGIC;                     -- Sinal de reset
            read_enable   : in  STD_LOGIC;                     -- Habilita a leitura dos registradores
            adress_opa    : in  STD_LOGIC_VECTOR(1 downto 0);   -- Endereço do registrador A (2 bits)
            adress_opb    : in  STD_LOGIC_VECTOR(1 downto 0);   -- Endereço do registrador B (2 bits)
            operando_a    : out STD_LOGIC_VECTOR(7 downto 0);   -- Valor de saída do operando A (8 bits)
            operando_b    : out STD_LOGIC_VECTOR(7 downto 0)    -- Valor de saída do operando B (8 bits)
        );
    END COMPONENT;

    -- Definição do componente para as operações de 8 bits
    COMPONENT operacoes_8bits
        Port (
            A                 : in  STD_LOGIC_VECTOR(7 downto 0);  -- Operando A de 8 bits
            B                 : in  STD_LOGIC_VECTOR(7 downto 0);  -- Operando B de 8 bits
            OP                : in  STD_LOGIC_VECTOR(2 downto 0);  -- OP de 3 bits, define a operação
            RESULT            : out STD_LOGIC_VECTOR(15 downto 0);  -- Resultado da operação (16 bits)
            flag              : out STD_LOGIC  
        );
    END COMPONENT;

    -- Sinais internos para interligar as saídas
    signal C1, C2 : STD_LOGIC_VECTOR(7 downto 0);  -- Sinais para operando A e B
    signal FLAG_INTERNAL : STD_LOGIC;  -- Sinais para as flags

    -- Sinal de resultado interno
    signal RESULT_INTERNAL : STD_LOGIC_VECTOR(15 downto 0);

BEGIN

    -- Instanciação do componente banco_registradores_denis
    BR: banco_registradores_denis PORT MAP (
        clk         => clk,
        rst         => rst,
        read_enable => read_enable,
        adress_opa  => adress_opa,
        adress_opb  => adress_opb,
        operando_a  => C1,
        operando_b  => C2
    );

    -- Instanciação do componente operacoes_8bits
    ULA: operacoes_8bits PORT MAP (
        A       => C1,                    -- Operando A vindo do banco de registradores
        B       => C2,                    -- Operando B vindo do banco de registradores
        OP      => OP,                    -- Sinal de operação a ser realizado
        RESULT  => RESULT_INTERNAL,       -- Resultado da operação (16 bits)
        flag    => FLAG_INTERNAL         -- Flag de comparações logicas
    );

    PROCESS(clk, rst)
    BEGIN
        IF rst = '1' THEN
            RESULT <= (others => '0');  -- Resetando o resultado
            flag <= '0';  -- Resetando a flag
        ELSIF rising_edge(clk) THEN
            IF write_enable = '1' THEN
                RESULT <= RESULT_INTERNAL;  -- Atualiza o RESULT apenas se write_enable estiver ativado
                flag <= FLAG_INTERNAL;  -- Atualiza a flag C3 apenas se write_enable estiver ativado
            END IF;
        END IF;
    END PROCESS;

END arquitetura_ula_integrada_denis;

