library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity initial is


end initial;


architecture timing of initial is

       constant max_time : time := 1000 ns;
       constant clock_time : time := 10 ns;


     component system_clock is port
     (X : in std_logic;
      Y : in std_logic;
      OCCUPANCY : in std_logic_vector (5 downto 0);
      MAX_OCCUPANCY : in std_logic_vector (5 downto 0);
      clk : in std_logic;
      reset : in std_logic;
      Z: out std_logic);

     end component;


       signal x_tb, y_tb, z_tb : std_logic;
       signal occupancy_tb, max_occupancy_tb : std_logic_vector (5 downto 0);
       signal clk_tb, reset_tb : std_logic;

      FOR  circuit : system_clock USE ENTITY Work.system(rtl);

begin

       clock_generator : process
            variable simulation_time : time;

                   begin
                        simulation_time := 0 ns;

                          while simulation_time <= max_time loop

                            clk_tb <= '0';
                            wait for 10 ns;

                            clk_tb <= '1';
                            wait for 10 ns;

                            simulation_time := simulation_time + clock_time;
                            end loop;

                            wait;
                            end process;

      circuit : system_clock port map (x_tb, y_tb, occupancy_tb, max_occupancy_tb, clk_tb,reset_tb,z_tb);

             room_simulation : process

                  begin

                   occupancy_tb <= "101010";
                   max_occupancy_tb <= "111111";

                     wait until clk_tb'event and clk_tb ='0';
