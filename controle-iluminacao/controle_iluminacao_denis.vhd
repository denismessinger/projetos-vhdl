LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY controle_iluminacao_denis IS
    PORT (
        SP   : in  STD_LOGIC;  -- Sensor de Presença (SP)
        SLN  : in  STD_LOGIC;  -- Sensor de Luz Natural (SLN)
	SJA  : in  STD_LOGIC;  -- Sensor de Janela Aberta (SJA)
	SHN  : in  STD_LOGIC;  -- Sensor de Horário Noturno (SHN)
        LA   : out STD_LOGIC;  -- Luz Artificial (LA)
	AS   : out STD_LOGIC   -- Alerta de Segurança (AS)
    );
END controle_iluminacao_denis;

ARCHITECTURE arquitetura_controle_iluminacao_deniso OF controle_iluminacao_denis IS
BEGIN

    LA  <= SP AND (NOT SLN OR SHN);
    AS  <= SP AND SJA AND SHN;

END arquitetura_controle_iluminacao_deniso;
