----------------------------------------------------------------------------------
-- University of Victoria
-- Engineers: Justin Guze, Paul Hunter
-- 
-- Create Date:    19:21:32 07/31/2014 
-- Design Name: 
-- Module Name:    cordic - Behavioral 
-- Project Name: 
-- Target Devices: Spartan6
-- Tool versions: 
-- Description: This module contains the definition of a CORDIC computer capable
-- 				of calculating the trigonometic functions Sin, Cos and Arctan.
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cordic is
    Port ( 	x : 		in STD_LOGIC_VECTOR(31 downto 0);
			o : 		in STD_LOGIC_VECTOR(1 downto 0);

           	result : 	out STD_LOGIC_VECTOR (31 downto 0);
end cordic;

architecture Behavioral of cordic is
	type ARC_INFO is array (0 to 31) of SIGNED(0 to 31);

	-- ARC_TABLE is our lookup table of Arctan(2^ -i) values 
	-- for the 31 iterations we will use to compute our answer.
	constant ARC_TABLE : ARC_INFO := (
		TO_SIGNED( 843314857 ),
		TO_SIGNED( 497837829 ),
		TO_SIGNED( 263043837 ),
		TO_SIGNED( 133525159 ),

		TO_SIGNED( 67021687 ),
		TO_SIGNED( 33543516 ),
		TO_SIGNED( 16775851 ),
		TO_SIGNED( 8388437 ),

		TO_SIGNED( 4194283 ),
		TO_SIGNED( 2097149 ),
		TO_SIGNED( 1048576 ),
		TO_SIGNED( 524288 ),

		TO_SIGNED( 262144 ),
		TO_SIGNED( 131072 ),
		TO_SIGNED( 65536 ),
		TO_SIGNED( 32768 ),

		TO_SIGNED( 16384 ),
		TO_SIGNED( 8192 ),
		TO_SIGNED( 4096 ),
		TO_SIGNED( 2048 ),

		TO_SIGNED( 1024 ),
		TO_SIGNED( 512 ),
		TO_SIGNED( 256 ),
		TO_SIGNED( 128 ),

		TO_SIGNED( 64 ),
		TO_SIGNED( 32 ),
		TO_SIGNED( 16 ),
		TO_SIGNED( 8 ),

		TO_SIGNED( 4 ),
		TO_SIGNED( 2 ),
		TO_SIGNED( 1 ),
	);


begin
	-- x, y, and z are expected to be 2^30 based fixed point values.
	-- o should be 1 for rotation mode
	rotation: process (x, o)
		variable x_temp, cur_x, cur_y, cur_z, arctan_val, shift_x, shift_y: SIGNED(31 downto 0);
	begin

		-- if the most sig bit of o is 0, then the operation
		-- is arctangent, otherwise it is sine or cosine.
		if(o(1) = '0') then
			cur_x := SIGNED(X);
			cur_y := SIGNED(1073741824);
			cur_z := SIGNED(0);
		else
			cur_x := SIGNED(1073741824);
			cur_y := SIGNED(0);
			cur_z := SIGNED(X);
		end if;
		
		for i in 0 to 31 loop
			arctan_val := ARC_TABLE(i);
			x_temp := cur_x;
			shift_x := SHIFT_RIGHT(SIGNED(cur_x), i);
			shift_y := SHIFT_RIGHT(SIGNED(cur_y), i);
			-- optimization, we can us the following piece of insight
			-- If we take the sign bits of z and y as sz and sy respectively
			-- we can simplify the logic to (sz and o) or not(sy or o)
			if ( (cur_z < 0 and o(1) = '1') or (cur_y >= 0 and o(1) = '0') ) then
				cur_x := cur_x + shift_y;
				cur_y := cur_y - shift_x;
				cur_z := cur_z + arctan_val;
			else
				cur_x := cur_x - shift_y;
				cur_y := cur_y + shift_x;
				cur_z := cur_z - arctan_val;
			end if;
		end loop;

		-- Select the appropriate output based on the operation.
		if(o(1) = '0') then
			--arctangent, return Z
			result <= STD_LOGIC_VECTOR(cur_z);
		else
			if(o(0) = '0') then
				--Cosine, return X
				result <= STD_LOGIC_VECTOR(cur_x);
			else
				--Sine, return Y
				result <= STD_LOGIC_VECTOR(cur_y);
			end if;
		end if;

	end process;

end Behavioral;
