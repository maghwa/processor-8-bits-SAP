library IEEE; -- Déclaration de la bibliothèque IEEE
use IEEE.STD_LOGIC_1164.ALL; -- Utilisation du package STD_LOGIC_1164 pour les types de données logiques
use IEEE.STD_LOGIC_ARITH.ALL; -- Utilisation du package STD_LOGIC_ARITH pour les opérations arithmétiques
use IEEE.STD_LOGIC_UNSIGNED.ALL; -- Utilisation du package STD_LOGIC_UNSIGNED pour les opérations non signées

entity MEM is -- Déclaration de l'entité MEM
    Port ( address : in  STD_LOGIC_VECTOR (3 downto 0); -- Port d'entrée address pour spécifier l'adresse mémoire à accéder
           dataout : out  STD_LOGIC_VECTOR (7 downto 0); -- Port de sortie dataout pour lire les données de la mémoire
           CE : in  STD_LOGIC); -- Port d'entrée CE pour activer la lecture de la mémoire
end MEM;

architecture Behavioral of MEM is
type memory is array(0 to 15) of std_logic_vector (7 downto 0); -- Déclaration d'un type "memory" représentant une mémoire avec 16 emplacements, chaque emplacement étant une séquence de 8 bits
signal RAM : memory := ( -- Déclaration et initialisation d'un signal "RAM" représentant la mémoire avec des valeurs prédéfinies pour chaque emplacement
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

dataout <= RAM(conv_integer(unsigned(address))) when CE = '1' else (others => 'Z'); -- La sortie dataout est affectée à la valeur présente dans la mémoire (RAM) à l'adresse spécifiée par le port d'entrée address lorsque le signal CE est actif ('1'), sinon la sortie est mise en état haute impédance ('Z').

end Behavioral;

