library IEEE; -- D�claration de la biblioth�que IEEE
use IEEE.STD_LOGIC_1164.ALL; -- Utilisation du package STD_LOGIC_1164 pour les types de donn�es logiques
use IEEE.STD_LOGIC_ARITH.ALL; -- Utilisation du package STD_LOGIC_ARITH pour les op�rations arithm�tiques
use IEEE.STD_LOGIC_UNSIGNED.ALL; -- Utilisation du package STD_LOGIC_UNSIGNED pour les op�rations non sign�es

entity PC is -- D�claration de l'entit� PC
    Port ( Cp : in  STD_LOGIC; -- Port d'entr�e Cp pour l'incr�mentation du compteur
           clk : in  STD_LOGIC; -- Port d'entr�e clk pour l'horloge
           clr : in  STD_LOGIC; -- Port d'entr�e clr pour la r�initialisation du compteur
           Ep : in  STD_LOGIC; -- Port d'entr�e Ep pour l'activation de la sortie
           addr_out : out  STD_LOGIC_VECTOR (3 downto 0)); -- Port de sortie addr_out repr�sentant la valeur du compteur
end PC;

architecture Behavioral of PC is -- D�claration de l'architecture Behavior pour l'entit� PC

signal PC_content : STD_LOGIC_VECTOR (3 downto 0) := (others => '0'); -- D�claration d'un signal interne PC_content repr�sentant le contenu du compteur, initialis� � '0'

begin
process (clk, clr) -- Processus sensible aux signaux clk et clr
begin
	if clr = '0' then -- Si le signal clr est � '0', indiquant une demande de r�initialisation du compteur
		PC_content <= (others => '0'); -- R�initialiser le contenu du compteur � '0'
	elsif falling_edge(clk) then -- Sinon, si il y a un front descendant de clk
		if Cp = '1' then -- Si le signal Cp est � '1', indiquant une demande d'incr�mentation du compteur
			PC_content <= PC_content + 1; -- Incr�menter le contenu du compteur de 1
		end if;
	end if;
end process;

addr_out <= PC_content when Ep = '1' else (others => 'Z'); -- La sortie addr_out est affect�e au contenu du compteur PC_content lorsque Ep est � '1', sinon elle est affect�e � 'Z' (�tat haute imp�dance)
end Behavioral;

