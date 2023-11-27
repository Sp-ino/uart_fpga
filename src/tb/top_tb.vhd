----------------------------------------------------------------------------------
-- Engineer: Valerio Spinogatti
-- 
-- Module Name: tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
-- Copyright (c) 2023 Valerio Spinogatti
-- Licensed under Apache license
----------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

library xil_defaultlib;
use xil_defaultlib.uart_pkg.all;
use xil_defaultlib.common_pkg.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb is
--  Port ( );
end tb;

architecture Behavioral of tb is

    component txrx_top_for_implementation is
    port (
        i_ck : in std_logic;
        i_rst : in std_logic;
        i_rx : in std_logic;
        i_transmit_req: in std_logic;
        o_rx_buffer_full: out std_logic;
        o_tx_busy: out std_logic;
        o_tx : out std_logic
    );
    end component;
    
    constant tck_fast: time := 10 ns;
    constant tck: time := tck_fast*4; -- need to divide by 4 to because internally we use a clock at 1/4 speed

    constant in1: integer := 1;
    constant in2: integer := 1234556;

    signal transmit: std_logic;
    signal rx_buffer_full: std_logic;
    signal tx_busy: std_logic;
    signal clock: std_logic;
    signal rst: std_logic;
    signal rx: std_logic;
    signal tx: std_logic;

begin

    top: txrx_top_for_implementation
    port map (
        i_ck => clock,
        i_rst => rst,
        i_rx => rx,
        i_transmit_req => transmit,
        o_rx_buffer_full => rx_buffer_full,
        o_tx_busy => tx_busy,
        o_tx => tx
    );
        
    
    clock_gen: process
    begin

        clock <= '1';
        wait for tck_fast/2;
        clock <= '0';
        wait for tck_fast/2;
    
    end process clock_gen;


    test_sig_gen: process
    begin

        transmit <= '0';
        rx <= '1';
        rst <= '1';
        wait for 3*tck;
        rst <= '0';

        -- send start bit
        wait for 2*tck; 
        rx <= '0';

        -- then send a "01010011" (0x53)
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';

        -- send stop bit
        wait for bit_duration*tck;
        rx <= '1';

        -- send a new start bit
        wait for bit_duration*tck; 
        rx <= '0';

        -- then send a "10011010" (0xa9)
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';

        -- send stop bit
        wait for bit_duration*tck;
        rx <= '1';
        
        -- send a new start bit
        wait for bit_duration*tck; 
        rx <= '0';

        -- then send a "00001011" (0x0b)
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';

        -- send stop bit
        wait for bit_duration*tck;
        rx <= '1';
        
        wait for bit_duration*tck;

        -- send a new start bit
        wait for bit_duration*tck; 
        rx <= '0';

        -- then send a "00011010" (0x1a)
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';

        -- send stop bit
        wait for bit_duration*tck;
        rx <= '1';
        
        wait for bit_duration*tck;

        -- send a new start bit
        wait for bit_duration*tck; 
        rx <= '0';

        -- then send a "00001010" (0x0a)
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';

        -- send stop bit
        wait for bit_duration*tck;
        rx <= '1';
        
        wait for bit_duration*tck;

        -- send a new start bit
        wait for bit_duration*tck; 
        rx <= '0';

        -- then send a "00001010" (0x0a)
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';

        -- send stop bit
        wait for bit_duration*tck;
        rx <= '1';
        
        wait for bit_duration*tck;

        -- send a new start bit
        wait for bit_duration*tck; 
        rx <= '0';

        -- then send a "00001010" (0x0a)
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';

        -- send stop bit
        wait for bit_duration*tck;
        rx <= '1';
        
        wait for bit_duration*tck;

        -- send a new start bit
        wait for bit_duration*tck; 
        rx <= '0';

        -- then send a "00001010" (0x0a)
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';

        -- send stop bit
        wait for bit_duration*tck;
        rx <= '1';
        
        wait for bit_duration*tck;

        -- send a new start bit
        wait for bit_duration*tck; 
        rx <= '0';

        -- then send a "00001010" (0x0a)
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';

        -- send stop bit
        wait for bit_duration*tck;
        rx <= '1';
        
        wait for bit_duration*tck;

        -- send a new start bit
        wait for bit_duration*tck; 
        rx <= '0';

        -- then send a "00001010" (0x0a)
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';

        -- send stop bit
        wait for bit_duration*tck;
        rx <= '1';
        
        wait for bit_duration*tck;

        -- send a new start bit
        wait for bit_duration*tck; 
        rx <= '0';

        -- then send a "00001010" (0x0a)
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';

        -- send stop bit
        wait for bit_duration*tck;
        rx <= '1';
        
        wait for bit_duration*tck;

        -- send a new start bit
        wait for bit_duration*tck; 
        rx <= '0';

        -- then send a "00001010" (0x0a)
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';

        -- send stop bit
        wait for bit_duration*tck;
        rx <= '1';
        
        wait for bit_duration*tck;

        -- send a new start bit
        wait for bit_duration*tck; 
        rx <= '0';

        -- then send a "00001010" (0x0a)
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';

        -- send stop bit
        wait for bit_duration*tck;
        rx <= '1';
        
        wait for bit_duration*tck;

        -- send a new start bit
        wait for bit_duration*tck; 
        rx <= '0';

        -- then send a "00001010" (0x0a)
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';

        -- send stop bit
        wait for bit_duration*tck;
        rx <= '1';
        
        wait for bit_duration*tck;

        -- send a new start bit
        wait for bit_duration*tck; 
        rx <= '0';

        -- then send a "00001011" (0x0b)
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';

        -- send stop bit
        wait for bit_duration*tck;
        rx <= '1';
        
        wait for bit_duration*tck;

        -- send a new start bit
        wait for bit_duration*tck; 
        rx <= '0';

        -- then send a "11101111" (0x0a)
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '1';

        -- send stop bit
        wait for bit_duration*tck;
        rx <= '1';
        
        wait for bit_duration*tck;        
        transmit <= '1';
        wait for 2*tck;
        transmit <= '0';

        wait for tck*bit_duration*200;

    end process test_sig_gen;

end Behavioral;
