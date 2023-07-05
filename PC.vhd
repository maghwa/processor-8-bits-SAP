library IEEE; -- Déclaration de la bibliothèque IEEE
use IEEE.STD_LOGIC_1164.ALL; -- Utilisation du package STD_LOGIC_1164 pour les types de données logiques
use IEEE.STD_LOGIC_ARITH.ALL; -- Utilisation du package STD_LOGIC_ARITH pour les opérations arithmétiques
use IEEE.STD_LOGIC_UNSIGNED.ALL; -- Utilisation du package STD_LOGIC_UNSIGNED pour les opérations non signées

entity PC is -- Déclaration de l'entité PC
    Port ( Cp : in  STD_LOGIC; -- Port d'entrée Cp pour l'incrémentation du compteur
           clk : in  STD_LOGIC; -- Port d'entrée clk pour l'horloge
           clr : in  STD_LOGIC; -- Port d'entrée clr pour la réinitialisation du compteur
           Ep : in  STD_LOGIC; -- Port d'entrée Ep pour l'activation de la sortie
           addr_out : out  STD_LOGIC_VECTOR (3 downto 0)); -- Port de sortie addr_out représentant la valeur du compteur
end PC;

architecture Behavioral of PC is -- Déclaration de l'architecture Behavior pour l'entité PC

signal PC_content : STD_LOGIC_VECTOR (3 downto 0) := (others => '0'); -- Déclaration d'un signal interne PC_content représentant le contenu du compteur, initialisé à '0'

begin
process (clk, clr) -- Processus sensible aux signaux clk et clr
begin
	if clr = '0' then -- Si le signal clr est à '0', indiquant une demande de réinitialisation du compteur
		PC_content <= (others => '0'); -- Réinitialiser le contenu du compteur à '0'
	elsif falling_edge(clk) then -- Sinon, si il y a un front descendant de clk
		if Cp = '1' then -- Si le signal Cp est à '1', indiquant une demande d'incrémentation du compteur
			PC_content <= PC_content + 1; -- Incrémenter le contenu du compteur de 1
		end if;
	end if;
end process;

addr_out <= PC_content when Ep = '1' else (others => 'Z'); -- La sortie addr_out est affectée au contenu du compteur PC_content lorsque Ep est à '1', sinon elle est affectée à 'Z' (état haute impédance)
end Behavioral;

