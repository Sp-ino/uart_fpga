library ieee;
use ieee.std_logic_1164.all;

library xil_defaultlib;
use xil_defaultlib.common_pkg.all;
use xil_defaultlib.uart_pkg.all;



entity txrx_top_for_implementation is
    port (
        i_ck: in std_logic;
        i_rst: in std_logic;
        i_transmit_req: in std_logic;
        i_rx: in std_logic;
        o_rx_buffer_full: out std_logic;
        o_tx_busy: out std_logic;
        o_tx: out std_logic
    );
end txrx_top_for_implementation;


architecture structure of txrx_top_for_implementation is

    signal ck_slow: std_logic;
    signal word: std_logic_vector (word_width_bit - 1 downto 0);

    component transmitter_top is
        port (
            i_ck: in std_logic;
            i_rst: in std_logic;
            i_transmit_req: in std_logic;
            i_word: in std_logic_vector (word_width_bit - 1 downto 0);
            o_busy: out std_logic;
            o_tx: out std_logic
        );
    end component;
    
    component receiver_top is
        port (
            i_ck: in std_logic;
            i_rst: in std_logic;
            i_rx: in std_logic;
            o_word: out std_logic_vector (word_width_bit - 1 downto 0);
            o_buffer_full: out std_logic
        );
    end component;
    
    component ckdiv_ip is
        port ( 
            i_ck : in std_logic;
            o_ckout : out std_logic
        );
    end component;    

begin

    ckdiv: ckdiv_ip
    port map (
        i_ck => i_ck,
        o_ckout => ck_slow
    );

    tx: transmitter_top
    port map (
        i_ck => ck_slow,
        i_rst => i_rst,
        i_transmit_req => i_transmit_req,
        i_word => word,
        o_busy => o_tx_busy,
        o_tx => o_tx
    );

    rx: receiver_top
    port map (
        i_ck => ck_slow,
        i_rst => i_rst,
        i_rx => i_rx,
        o_word => word,
        o_buffer_full => o_rx_buffer_full
    );

end structure;