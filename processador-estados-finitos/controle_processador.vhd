library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity controle_processador is
    Port ( clk 			: in STD_LOGIC;
           reset 		: in STD_LOGIC;
           run 			: in STD_LOGIC;
           instruction  	: in STD_LOGIC_VECTOR(7 downto 0);
           read_enable  	: out STD_LOGIC;
           write_enable 	: out STD_LOGIC;
           op 			: out STD_LOGIC_VECTOR(2 downto 0);
           address_operandoA 	: out STD_LOGIC_VECTOR(1 downto 0);
           address_operandoB 	: out STD_LOGIC_VECTOR(1 downto 0);
           done 		: out STD_LOGIC;
           invalid 		: out STD_LOGIC);
end controle_processador;

architecture arquitetura_controle_processador of controle_processador is

    type state_type is (IDLE, PROCESSING, DONE_STATE, ERROR);
    signal state, next_state : state_type;
    
    -- Sinais internos
    signal internal_done : STD_LOGIC := '0'; -- Sinal interno para rastrear o estado de done
    
begin
    -- FSM process
    process(clk, reset)
    begin
        if reset = '1' then
            state <= IDLE;
        elsif rising_edge(clk) then
            state <= next_state;
        end if;
    end process;

    process(state, run, instruction)
    begin
        next_state <= state;  -- Default transition

	-- Default values
	read_enable <= '0';
        write_enable <= '0';
        op <= instruction(6 downto 4);
        address_operandoA <= instruction(3 downto 2);
        address_operandoB <= instruction(1 downto 0);
	done <= '0';  
        invalid <= '0';
         
        -- Controlando as transições de estado
        case state is
            when IDLE =>
		if internal_done = '1' then
		    write_enable <= instruction(7);
		end if;

                if run = '1' then
                    next_state <= PROCESSING;
                else
                    next_state <= IDLE;
                end if;
                
            when PROCESSING =>
		read_enable <= instruction(7);
                invalid <= '0';  -- Considera que não há erro durante PROCESSING

                if instruction(6 downto 4) = "011" or instruction(6 downto 4) = "010" then -- Operações que não existem coloco como erro
                    next_state <= ERROR;
                elsif run = '1' then
                    next_state <= DONE_STATE;
                else
                    next_state <= IDLE; 
                end if;
                
            when DONE_STATE =>
		internal_done <= '1'; -- Indica o sinal interno que deu ok para a impressão do resultado
                done <= '1';  -- Indica que a operação foi concluída
                next_state <= IDLE;  -- Volta para IDLE após terminar a operação
                
            when ERROR =>
                invalid <= '1';  -- Indica erro
                done <= '0';
                next_state <= IDLE;  -- Caso de erro, volta para IDLE
        end case;
    end process;
    
end arquitetura_controle_processador;

