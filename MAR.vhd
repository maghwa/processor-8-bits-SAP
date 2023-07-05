library IEEE; -- Déclaration de la bibliothèque IEEE
use IEEE.STD_LOGIC_1164.ALL; -- Utilisation du package STD_LOGIC_1164 pour les types de données logiques
use IEEE.STD_LOGIC_ARITH.ALL; -- Utilisation du package STD_LOGIC_ARITH pour les opérations arithmétiques
use IEEE.STD_LOGIC_UNSIGNED.ALL; -- Utilisation du package STD_LOGIC_UNSIGNED pour les opérations non signées

entity MAR is -- Déclaration de l'entité MAR
    Port ( Lm : in  STD_LOGIC; -- Port d'entrée Lm pour le chargement du registre MAR
           clk : in  STD_LOGIC; -- Port d'entrée clk pour l'horloge
			  addr_in : in STD_LOGIC_VECTOR (3 downto 0); -- Port d'entrée addr_in pour la valeur à charger dans le registre MAR
           addr_out : out  STD_LOGIC_VECTOR (3 downto 0)); -- Port de sortie addr_out représentant le contenu du registre MAR
end MAR;

architecture Behavioral of MAR is -- Déclaration de l'architecture Behavior pour l'entité MAR

signal MAR_content : STD_LOGIC_VECTOR (3 downto 0) := (others => '0'); -- Déclaration d'un signal interne MAR_content représentant le contenu du registre MAR, initialisé à '0'

begin
process (clk) -- Processus sensible au signal clk
begin
	if rising_edge(clk) then -- Si un front montant de l'horloge se produit
		if Lm = '1' then -- Si le signal Lm est à '1', indiquant une demande de chargement du registre MAR
			MAR_content <= addr_in; -- Charger le contenu du registre MAR avec la valeur présente sur le port d'entrée addr_in
		end if;
	end if;
end process;

addr_out <= MAR_content; -- Affecter le contenu du registre MAR (MAR_content) à la sortie addr_out
end Behavioral;

