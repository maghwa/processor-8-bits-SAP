library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Controller is
    Port ( clk : in  STD_LOGIC;
           clr : in  STD_LOGIC;
           inst_in : in STD_LOGIC_VECTOR (3 downto 0);
           Cp : out STD_LOGIC;
           Ep : out STD_LOGIC;
           Lm : out STD_LOGIC;
           CE : out STD_LOGIC;
           Li : out STD_LOGIC;
           Ei : out STD_LOGIC;
           La : out STD_LOGIC;
           Ea : out STD_LOGIC;
           Su : out STD_LOGIC;
           Eu : out STD_LOGIC;
           Lb : out STD_LOGIC;
           Lo : out STD_LOGIC;
           HLT : out STD_LOGIC);
end Controller;

architecture Behavioral of Controller is

  -- Déclaration du type énuméré pour les états du contrôleur
  type state is (idle, t0, t1, t2, t3, t4, t5);
  
  -- Déclaration des signaux
  signal pr_state, nx_state : state := t0;
  signal control_signal : STD_LOGIC_VECTOR (11 downto 0) := (others => '0');
  signal HLT_sig : STD_LOGIC := '1';

begin

  -- Processus pour mettre à jour l'état courant
  process(clk, clr)
  begin
    if clr = '0' then
      pr_state <= idle;
    elsif rising_edge(clk) then
      pr_state <= nx_state;
    end if;
  end process;


  -- Processus pour la logique de transition et les opérations effectuées
  process(pr_state)
  begin
    case pr_state is
      when idle =>
        -- Ne rien faire
        control_signal <= "000000000000";
        HLT_sig <= '1';
        nx_state <= t0;

      when t0 =>
        -- Activer le PC (Ep = 1), charger dans le MAR (Lm = 1)
        control_signal <= "011000000000";
        nx_state <= t1;

      when t1 =>
        -- Incrémenter le PC (Cp = 1)
        control_signal <= "100000000000";
        nx_state <= t2;

      when t2 =>
        -- Activer la mémoire (CE = 1), charger dans l'IR (Li = 1)
        control_signal <= "000110000000";
        nx_state <= t3;

      when t3 =>
        -- OUT
        if inst_in = "1110" then
          -- Activer l'AC, charger dans OUT
          control_signal <= "000000010001";
        -- HALT
        elsif inst_in = "1111" then
          control_signal <= "000000000000";
          HLT_sig <= '0';
        -- Autres instructions
        else
          control_signal <= "001001000000";
        end if;
        nx_state <= t4;

      when t4 =>
        -- LDA
        if inst_in = "0000" then
          -- Activer la mémoire, charger dans l'AC
          control_signal <= "000100100000";
        -- ADD
        elsif inst_in = "0001" then
          -- Activer la mémoire, charger dans B
          control_signal <= "000100000010";
        -- SUB
        elsif inst_in = "0010" then
          -- Activer la mémoire, charger dans B
          control_signal <= "000100000010";
        -- Autres instructions
        else
          control_signal <= "000000000000";
        end if;
        nx_state <= t5;

      when t5 =>
        -- ADD
        if inst_in = "0001" then
          -- Activer l'ALU, charger dans l'AC, Su = 0 pour ADD
          control_signal <= "000000100100";
        -- SUB
        elsif inst_in = "0010" then
          -- Activer l'ALU, charger dans l'AC, Su = 1 pour SUB
          control_signal <= "000000101100";
        -- Autres instructions
        else
          control_signal <= "000000000000";
        end if;
        nx_state <= t0;

    end case;
  end process;

  -- Assignation des signaux de commande aux sorties

  Cp <= control_signal(11);
  Ep <= control_signal(10);
  Lm <= control_signal(9);
  CE <= control_signal(8);
  Li <= control_signal(7);
  Ei <= control_signal(6);
  La <= control_signal(5);
  Ea <= control_signal(4);
  Su <= control_signal(3);
  Eu <= control_signal(2);
  Lb <= control_signal(1);
  Lo <= control_signal(0);
  HLT <= HLT_sig;

end Behavioral;

