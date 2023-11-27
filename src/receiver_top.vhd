-- Copyright (c) 2023 Valerio Spinogatti
-- Licensed under Apache license

library ieee;
use ieee.std_logic_1164.all;

library xil_defaultlib;
use xil_defaultlib.common_pkg.all;
use xil_defaultlib.uart_pkg.all;



entity receiver_top is
    port (
        i_ck: in std_logic;
        i_rst: in std_logic;
        i_rx: in std_logic;
        o_word: out std_logic_vector (word_width_bit - 1 downto 0);
        o_buffer_full: out std_logic
    );
end receiver_top;


architecture structure of receiver_top is

    signal valid: std_logic;
    signal seen: std_logic;
    signal byte: std_logic_vector (byte_width_bit - 1 downto 0);

    component uart_rx_ip is
        port ( 
            i_ck : in std_logic;
            i_rx : in std_logic;
            i_rst : in std_logic;
            i_data_seen : in std_logic;
            o_data_valid : out std_logic;
            o_data_out : out std_logic_vector (byte_width_bit - 1 downto 0)
        );
    end component;
        
    component deserializer_ip is
        port (
            i_byte_valid : in std_logic;
            i_byte : in std_logic_vector (byte_width_bit - 1 downto 0);
            i_ck : in std_logic;
            i_rst : in std_logic;
            o_word : out std_logic_vector (word_width_bit - 1 downto 0);
            o_data_seen : out std_logic;
            o_buffer_full : out std_logic    
        );
    end component;

begin

    uart_core: uart_rx_ip
    port map (
        i_ck => i_ck,
        i_rst => i_rst,
        i_rx => i_rx,
        i_data_seen => seen,
        o_data_valid => valid,
        o_data_out => byte
    );

    des: deserializer_ip
    port map (
        i_byte_valid => valid,
        i_byte => byte,
        i_ck => i_ck,
        i_rst => i_rst,
        o_word => o_word,
        o_data_seen => seen,
        o_buffer_full => o_buffer_full
    );

end structure;