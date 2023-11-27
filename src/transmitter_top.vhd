-- Copyright (c) 2023 Valerio Spinogatti
-- Licensed under Apache license


library ieee;
use ieee.std_logic_1164.all;

library xil_defaultlib;
use xil_defaultlib.common_pkg.all;
use xil_defaultlib.uart_pkg.all;



entity transmitter_top is
    port (
        i_ck: in std_logic;
        i_rst: in std_logic;
        i_transmit_req: in std_logic;
        i_word: in std_logic_vector (word_width_bit - 1 downto 0);
        o_busy: out std_logic;
        o_tx: out std_logic
    );
end transmitter_top;


architecture structure of transmitter_top is

    signal valid: std_logic;
    signal internal_busy: std_logic;
    signal byte: std_logic_vector (byte_width_bit - 1 downto 0);

    component uart_tx_ip is
        port (
            i_ck : in std_logic;
            i_rst: in std_logic;
            i_data_valid : in std_logic;
            i_data_in : in std_logic_vector (byte_width_bit - 1 downto 0);
            o_busy : out std_logic;
            o_tx : out std_logic
        );
    end component;
    
    component serializer_ip is
        port (
            i_transmit : in std_logic;
            i_tx_busy: in std_logic;
            i_word : in std_logic_vector (word_width_bit - 1 downto 0);
            i_ck : in std_logic;
            i_rst : in std_logic;
            o_byte : out std_logic_vector (byte_width_bit - 1 downto 0);
            o_busy: out std_logic;
            o_byte_valid : out std_logic    
        );
    end component;

begin

    uart_core: uart_tx_ip
    port map (
        i_ck => i_ck,
        i_rst => i_rst,
        i_data_valid => valid,
        i_data_in => byte,
        o_busy => internal_busy,
        o_tx => o_tx
    );

    ser: serializer_ip
    port map (
        i_transmit => i_transmit_req,
        i_tx_busy => internal_busy,
        i_word => i_word,
        i_ck => i_ck,
        i_rst => i_rst,
        o_byte => byte,
        o_busy => o_busy,
        o_byte_valid => valid
    );

end structure;