library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

ENTITY cpu IS
    PORT (
        clk                 : in  STD_LOGIC;                         -- Clock de entrada
        rst                 : in  STD_LOGIC;                         -- Sinal de reset
        instruction         : in  STD_LOGIC_VECTOR(7 downto 0);      -- Instrução (8 bits)
	run 		    : in  STD_LOGIC;                         -- Sinal de run
        COMPAL              : out STD_LOGIC;                         -- Flag para comparações
        RESULT              : out STD_LOGIC_VECTOR(15 downto 0);     -- Resultado da operação (16 bits)
	DONE                : out STD_LOGIC;                         -- Flag para comparações
	INVALID             : out STD_LOGIC);                         -- Flag para comparações
END cpu;

ARCHITECTURE arquitetura_cpu OF cpu IS

    -- Componentes internos
    COMPONENT controle_processador
        PORT (
            clk                 : in  STD_LOGIC;
            reset               : in  STD_LOGIC;
            run                 : in  STD_LOGIC;
            instruction         : in  STD_LOGIC_VECTOR(7 downto 0);
            read_enable         : out STD_LOGIC;
            write_enable        : out STD_LOGIC;
            op                  : out STD_LOGIC_VECTOR(2 downto 0);
            address_operandoA   : out STD_LOGIC_VECTOR(1 downto 0);
            address_operandoB   : out STD_LOGIC_VECTOR(1 downto 0);
            done                : out STD_LOGIC;
            invalid             : out STD_LOGIC
        );
    END COMPONENT;

    -- Definição do componente do banco de registradores
    COMPONENT banco_registradores_denis
        Port (
            clk           : in  STD_LOGIC;                      -- Clock de entrada
            rst           : in  STD_LOGIC;                      -- Sinal de reset
            read_enable   : in  STD_LOGIC;                      -- Habilita a leitura dos registradores
            adress_opa    : in  STD_LOGIC_VECTOR(1 downto 0);   -- Endereço do registrador A (2 bits)
            adress_opb    : in  STD_LOGIC_VECTOR(1 downto 0);   -- Endereço do registrador B (2 bits)
            operando_a    : out STD_LOGIC_VECTOR(7 downto 0);   -- Valor de saída do operando A (8 bits)
            operando_b    : out STD_LOGIC_VECTOR(7 downto 0)    -- Valor de saída do operando B (8 bits)
        );
    END COMPONENT;

    -- Definição do componente para as operações de 8 bits
    COMPONENT operacoes_8bits
        Port (
            clk               : in  STD_LOGIC;                     -- Clock de entrada
            enable            : in  STD_LOGIC;                     -- Sinal de habilitação
            A                 : in  STD_LOGIC_VECTOR(7 downto 0);  -- Operando A de 8 bits
            B                 : in  STD_LOGIC_VECTOR(7 downto 0);  -- Operando B de 8 bits
            OP                : in  STD_LOGIC_VECTOR(2 downto 0);  -- OP de 3 bits, define a operação
            RESULT            : out STD_LOGIC_VECTOR(15 downto 0); -- Resultado da operação (16 bits)
            flag              : out STD_LOGIC                       -- Flag de comparação
        );
    END COMPONENT;

    -- Sinais internos para interligar as saídas
    signal C1, C2 : STD_LOGIC_VECTOR(7 downto 0);  
    signal re_internal : STD_LOGIC; 
    signal we_internal : STD_LOGIC; 
    signal ula_enable : STD_LOGIC;
    signal FLAG_INTERNAL : STD_LOGIC; 
    signal DONE_INTERNAL : STD_LOGIC; 
    signal INVALID_INTERNAL : STD_LOGIC; 
    signal RESULT_INTERNAL : STD_LOGIC_VECTOR(15 downto 0);
    signal op_internal : STD_LOGIC_VECTOR(2 downto 0); 
    signal adress_opa_internal : STD_LOGIC_VECTOR(1 downto 0); 
    signal adress_opb_internal : STD_LOGIC_VECTOR(1 downto 0);  

BEGIN

    -- Instancia o controlador
    controle: controle_processador 
        PORT MAP (
            clk                 => clk,
            reset               => rst,
            run                 => run,                 -- Entrada RUN
            instruction         => instruction,         -- A instrução da CPU
            read_enable         => re_internal,         -- Sinal de habilitação de leitura
            write_enable        => we_internal,         -- Sinal de habilitação de escrita
            op                  => op_internal,         -- Sinal da operação
            address_operandoA   => adress_opa_internal, -- Endereço do operando A
            address_operandoB   => adress_opb_internal, -- Endereço do operando B
            done                => DONE_INTERNAL,       -- Flag de finalização
            invalid             => INVALID_INTERNAL     -- Flag de erro
        );

    -- Instanciação do componente banco_registradores_denis
    BR: banco_registradores_denis 
        PORT MAP (
            clk         => clk,
            rst         => rst,
            read_enable => re_internal,         -- Habilita a leitura dos operandos
            adress_opa  => adress_opa_internal, -- Endereço do registrador A
            adress_opb  => adress_opb_internal, -- Endereço do registrador B
            operando_a  => C1,                  -- Valor do operando A
            operando_b  => C2                   -- Valor do operando B
        );

    -- Instanciação do componente operacoes_8bits
    ULA: operacoes_8bits 
        PORT MAP (
            clk     => clk,           -- Clock conectado
            enable  => ula_enable,    -- Habilitação controlada
            A       => C1,            -- Operando A
            B       => C2,            -- Operando B
            OP      => op_internal,   -- Operação
            RESULT  => RESULT_INTERNAL, -- Resultado
            flag    => FLAG_INTERNAL   -- Flag
        );

    PROCESS(clk, rst)
    BEGIN
        IF rst = '1' THEN
            ula_enable <= '0';
        ELSIF rising_edge(clk) THEN
            ula_enable <= re_internal;
        END IF;
    END PROCESS;

    PROCESS(clk, rst)
    BEGIN
        IF rst = '1' THEN
            RESULT <= (others => '0');     -- Resetando o resultado
            COMPAL <= '0';                   -- Resetando a flag
	    DONE <= '0';
	    INVALID <= '0';
        ELSIF rising_edge(clk) THEN
            IF we_internal = '1' THEN
                RESULT <= RESULT_INTERNAL; -- Atualiza o RESULT apenas se write_enable estiver ativado
                COMPAL <= FLAG_INTERNAL;     -- Atualiza a flag apenas se write_enable estiver ativado
            END IF;
	    DONE <= DONE_INTERNAL;
	    INVALID <= INVALID_INTERNAL;
        END IF;
    END PROCESS;

END arquitetura_cpu;

