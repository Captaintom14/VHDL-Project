library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity system is port
( X : in std_logic;
  Y : in std_logic;
  OCCUPANCY : in std_logic_vector (5 downto 0);
  MAX_OCCUPANCY : in std_logic_vector (5 downto 0) := "111111";
  clk : in std_logic;
  reset : in std_logic;
  Z: out std_logic);

end system;

architecture rtl of system is
signal Q_REG, Q_NEXT, NEW_CAPACITY : std_logic_vector(5 downto 0);
signal Q_temp, Q_temp2,Q_temp3, Q_temp4 : std_logic_vector (5 downto 0);
begin



    process (reset, clk)
           begin
                   if (reset = '1') then
                       Q_REG <= (others => '0');

                    elsif (clk'event and clk = '1') then

                   if (X = '1' and Y = '0') then
                     if (OCCUPANCY < MAX_OCCUPANCY) then
                      Q_REG <= Q_temp;

                       end if;

                   elsif (X = '0' and Y = '1') then

                    if (OCCUPANCY > "000000") then
                    Q_REG <= Q_temp2;
                     end if;

                   else
                        Q_REG <= Q_temp3;

                     end if;
                     end if;
                     end process;

                       Q_temp <= OCCUPANCY + "000001";
                       Q_temp2 <= OCCUPANCY - "000001";
                       Q_temp3 <= OCCUPANCY;


                Q_NEXT <= Q_REG;

                     NEW_CAPACITY <= Q_temp when (X = '1' and Y = '0') else
                                     Q_temp2 when (X = '0' and Y = '1') else
                                     Q_temp3;





 --Determining if the Q passed the maximum capacity

                process (NEW_CAPACITY, MAX_OCCUPANCY)
                          begin
