--Este codigo simula las luces direccionales de un automovil mustang

--Aqui añadimos las librerias
library IEEE;
	use IEEE.STD_LOGIC_1164.all;
	use IEEE.NUMERIC_STD.ALL;

--Aqui definimos nuestas variables
entity maquina_de_Moore is
	port (CLK, RST, VD, VI, IM: in STD_LOGIC;
		LD, LI: out STD_LOGIC_VECTOR(3 downto 0)); --Estas variables son un vector de 3 a 0 que representan cada led
end maquina_de_Moore;

--Aqui definimos todos los estados posibles que podemos tener
architecture A1 of maquina_de_Moore is

type State is (S0, SIZ0, SIZ1, SIZ2, SIZ3, SID0, SID1, SID2, SID3, SIN0, SIN1);
--Aqui se definen los cambios de estado
signal CurrentState, NextState: State;
signal count: integer:=1;
signal temp: std_logic:='0';

begin
	--Este process sera el encargado de hacer los cambios de estado
	Estados: process(CLK, RST)
	begin
		--Cuando hacemos reset nuestro primer estado se manda al estado que estamos corriendo
		if (RST = '1') then
			CurrentState <= S0;
		--Cuando hay un cambio de reloj aumentamos el contados y cambiamos al siguiente estado programado
		elsif(rising_edge(CLK)) then
			count <= count + 1;
			--Aqui reiniciamos el ciclo de reloj cada segundo
			if (count = 25000000) then
				count <= 1;
				CurrentState <= NextState;
			end if;
		end if;
	end process Estados;
	
	--Esto es el process de las lucese
	Luces: process(CurrentState, RST, IM, VD, VI)
	begin 
		NextState <= CurrentState;
		LD(3) <= '1';
		LI(3) <= '1';
		
		case CurrentState is
		when S0 =>
			LD(0) <= '0';
			LD(1) <= '0';
			LD(2) <= '0';
			LD(3) <= '1';
			
			LI(0) <= '0';
			LI(1) <= '0';
			LI(2) <= '0';
			LI(3) <= '1';
			
			if (IM = '1') then
				NextState <= SIN0;
			elsif (VD = '1') then
				NextState <= SID0;
			elsif (VI = '1') then
				NextState <= SIZ0;
			else
				NextState <= S0;
			end if;
			
		when SIN0 =>
			LD(0) <= '0';
			LD(1) <= '0';
			LD(2) <= '0';
			LD(3) <= '1';
			
			LI(0) <= '0';
			LI(1) <= '0';
			LI(2) <= '0';
			LI(3) <= '1';
			
			if (IM = '0') then
				NextState <= S0;
			else 
				NextState <= SIN1;
			end if;
			
		when SIN1 =>
			LD(0) <= '1';
			LD(1) <= '1';
			LD(2) <= '1';
			LD(3) <= '1';
			
			LI(0) <= '1';
			LI(1) <= '1';
			LI(2) <= '1';
			LI(3) <= '1';
			
			if (IM = '0') then
				NextState <= S0;
			else 
				NextState <= SIN0;
			end if;
			
		when SID0 =>
			LD(0) <= '0';
			LD(1) <= '0';
			LD(2) <= '0';
			LD(3) <= '1';
			
			LI(0) <= '0';
			LI(1) <= '0';
			LI(2) <= '0';
			LI(3) <= '1';
			
			if (VD = '0') then
				NextState <= S0;
			else 
				NextState <= SID1;
			end if;
		
		when SID1 =>
			LD(0) <= '0';
			LD(1) <= '0';
			LD(2) <= '1';
			LD(3) <= '1';
			
			LI(0) <= '0';
			LI(1) <= '0';
			LI(2) <= '0';
			LI(3) <= '1';
			
			if (VD = '0') then
				NextState <= S0;
			else 
				NextState <= SID2;
			end if;
			
		when SID2 =>
			LD(0) <= '0';
			LD(1) <= '1';
			LD(2) <= '1';
			LD(3) <= '1';
			
			LI(0) <= '0';
			LI(1) <= '0';
			LI(2) <= '0';
			LI(3) <= '1';
			
			if (VD = '0') then
				NextState <= S0;
			else 
				NextState <= SID3;
			end if;
			
		when SID3 =>
			LD(0) <= '1';
			LD(1) <= '1';
			LD(2) <= '1';
			LD(3) <= '1';
			
			LI(0) <= '0';
			LI(1) <= '0';
			LI(2) <= '0';
			LI(3) <= '1';
			
			if (VD = '0') then
				NextState <= S0;
			else 
				NextState <= SID0;
			end if;
		
		when SIZ0 =>
			LD(0) <= '0';
			LD(1) <= '0';
			LD(2) <= '0';
			LD(3) <= '1';
			
			LI(0) <= '0';
			LI(1) <= '0';
			LI(2) <= '0';
			LI(3) <= '1';
			
			if (VI = '0') then
				NextState <= S0;
			else 
				NextState <= SIZ1;
			end if;
		
		when SIZ1 =>
			LD(0) <= '0';
			LD(1) <= '0';
			LD(2) <= '0';
			LD(3) <= '1';
			
			LI(0) <= '0';
			LI(1) <= '0';
			LI(2) <= '1';
			LI(3) <= '1';
			
			if (VI = '0') then
				NextState <= S0;
			else 
				NextState <= SIZ2;
			end if;
			
		when SIZ2 =>
			LD(0) <= '0';
			LD(1) <= '0';
			LD(2) <= '0';
			LD(3) <= '1';
			
			LI(0) <= '0';
			LI(1) <= '1';
			LI(2) <= '1';
			LI(3) <= '1';
			
			if (VI = '0') then
				NextState <= S0;
			else
				NextState <= SIZ3;
			end if;
			
		when SIZ3 =>
			LD(0) <= '0';
			LD(1) <= '0';
			LD(2) <= '0';
			LD(3) <= '1';
			
			LI(0) <= '1';
			LI(1) <= '1';
			LI(2) <= '1';
			LI(3) <= '1';
			
			if (VI = '0') then
				NextState <= S0;
			else 
				NextState <= SIZ0;
			end if;
			
			when others =>
				LD(0) <= '0';
				LD(1) <= '0';
				LD(2) <= '0';
				LD(3) <= '1';
			
				LI(0) <= '0';
				LI(1) <= '0';
				LI(2) <= '0';
				LI(3) <= '1';
				
				NextState <= S0;
			end case;
		end process Luces;
	end architecture A1;
	
