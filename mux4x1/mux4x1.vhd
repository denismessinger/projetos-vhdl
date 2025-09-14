LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY mux4x1 IS
    PORT (
        E0 : in  STD_LOGIC;
        E1 : in  STD_LOGIC;
        E2 : in  STD_LOGIC;
        E3 : in  STD_LOGIC;
        C  : in  STD_LOGIC_VECTOR(1 downto 0);
        S  : out STD_LOGIC
    );
END mux4x1;

ARCHITECTURE arquitetura_mux4x1 OF mux4x1 IS
BEGIN

    S <= E0 WHEN C = "00" ELSE
         E1 WHEN C = "01" ELSE
         E2 WHEN C = "10" ELSE
         E3 WHEN C = "11";

END arquitetura_mux4x1;