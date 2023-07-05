library IEEE; -- D�claration de la biblioth�que IEEE
use IEEE.STD_LOGIC_1164.ALL; -- Utilisation du package STD_LOGIC_1164 pour les types de donn�es logiques
use IEEE.STD_LOGIC_ARITH.ALL; -- Utilisation du package STD_LOGIC_ARITH pour les op�rations arithm�tiques
use IEEE.STD_LOGIC_UNSIGNED.ALL; -- Utilisation du package STD_LOGIC_UNSIGNED pour les op�rations non sign�es

entity MAR is -- D�claration de l'entit� MAR
    Port ( Lm : in  STD_LOGIC; -- Port d'entr�e Lm pour le chargement du registre MAR
           clk : in  STD_LOGIC; -- Port d'entr�e clk pour l'horloge
			  addr_in : in STD_LOGIC_VECTOR (3 downto 0); -- Port d'entr�e addr_in pour la valeur � charger dans le registre MAR
           addr_out : out  STD_LOGIC_VECTOR (3 downto 0)); -- Port de sortie addr_out repr�sentant le contenu du registre MAR
end MAR;

architecture Behavioral of MAR is -- D�claration de l'architecture Behavior pour l'entit� MAR

signal MAR_content : STD_LOGIC_VECTOR (3 downto 0) := (others => '0'); -- D�claration d'un signal interne MAR_content repr�sentant le contenu du registre MAR, initialis� � '0'

begin
process (clk) -- Processus sensible au signal clk
begin
	if rising_edge(clk) then -- Si un front montant de l'horloge se produit
		if Lm = '1' then -- Si le signal Lm est � '1', indiquant une demande de chargement du registre MAR
			MAR_content <= addr_in; -- Charger le contenu du registre MAR avec la valeur pr�sente sur le port d'entr�e addr_in
		end if;
	end if;
end process;

addr_out <= MAR_content; -- Affecter le contenu du registre MAR (MAR_content) � la sortie addr_out
end Behavioral;

