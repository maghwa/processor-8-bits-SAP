library IEEE; -- D�claration de la biblioth�que IEEE
use IEEE.STD_LOGIC_1164.ALL; -- Utilisation du package STD_LOGIC_1164 pour les types de donn�es logiques
use IEEE.STD_LOGIC_ARITH.ALL; -- Utilisation du package STD_LOGIC_ARITH pour les op�rations arithm�tiques
use IEEE.STD_LOGIC_UNSIGNED.ALL; -- Utilisation du package STD_LOGIC_UNSIGNED pour les op�rations non sign�es

entity MEM is -- D�claration de l'entit� MEM
    Port ( address : in  STD_LOGIC_VECTOR (3 downto 0); -- Port d'entr�e address pour sp�cifier l'adresse m�moire � acc�der
           dataout : out  STD_LOGIC_VECTOR (7 downto 0); -- Port de sortie dataout pour lire les donn�es de la m�moire
           CE : in  STD_LOGIC); -- Port d'entr�e CE pour activer la lecture de la m�moire
end MEM;

architecture Behavioral of MEM is
type memory is array(0 to 15) of std_logic_vector (7 downto 0); -- D�claration d'un type "memory" repr�sentant une m�moire avec 16 emplacements, chaque emplacement �tant une s�quence de 8 bits
signal RAM : memory := ( -- D�claration et initialisation d'un signal "RAM" repr�sentant la m�moire avec des valeurs pr�d�finies pour chaque emplacement
0  => "00001001" , --LDA @9h
1  => "11101111" , --OUT
2  => "00011010" , --ADD @Ah
3  => "11101111" , --OUT
4  => "00101011" , --SUB @Bh
5  => "11101111" , --OUT
6  => "11111111" , --HLT
7  => "00000000" ,
8  => "00000000" ,
9  => "00000110" , --6
10 => "00001000" , --8
11 => "00000011" , --3
12 => "00000000" ,
13 => "11111111" ,
14 => "11111111" , 
15 => "11111111" );

begin

dataout <= RAM(conv_integer(unsigned(address))) when CE = '1' else (others => 'Z'); -- La sortie dataout est affect�e � la valeur pr�sente dans la m�moire (RAM) � l'adresse sp�cifi�e par le port d'entr�e address lorsque le signal CE est actif ('1'), sinon la sortie est mise en �tat haute imp�dance ('Z').

end Behavioral;

