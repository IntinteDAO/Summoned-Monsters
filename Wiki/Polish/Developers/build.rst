Zasady budowania kodu gry
=========================

To jest podstawowa i bardzo ogólna dokumentacja budowania kodu gry w celu osiągnięcia pełnego produktu. Zachęcamy w razie pytań zadawać je na kanale Matrix.

Gra składa się z paru elementów:

* Silnika gry YGOPro. Jest to silnik odpowiedzialny za całą mechanikę i przetwarzanie. Pozwala on (po uzupełnieniu gry Assetami i innymi danymi) stworzyć główny rdzeń gry.

* Windbot jako projekt sztucznej inteligencji. Jest to projekt udający klienta gry w celu rozegrania z nami pojedynku.

* SRVPro to projekt serwera gry. Pozwala on na łączeniu graczy przez sieć internet.

* Summoned Monsters to projekt stworzenia assetów do gry. Pozwala on na generowanie kart (grafik) i baz danych. Bez tego działanie silnika YGOPro jest niemożliwe.

Sam projekt Summoned Monsters składa się głównie z trzech głównych katalogów:

* Windbot-AIGen to grupa skryptów służąca do budowania podstawowej bazy wiedzy dla AI. W skrócie na podstawie tych danych określane są reguły dla Windbot. 

* Build to zbiór skryptów ułatwiający budowanie gry. Wszystkie skrypty oprócz srvpro powinny działać poprawnie po zainstalowaniu potrzebnych zależności na większości dystrybucji Linuksa. W przypadku srvpro zalecane jest budowanie go na systemie Debian / Ubuntu. Ogólnie oczywiście zalecam budowanie gry tylko na Debianie / Ubuntu, gdyż różne dystrybucje mają problemy ze zbudowaniem kodu.

* Cardgenerator to skrypt budujący na podstawie danych assety. Składa się on z 3 elementów:

- Scripts, czyli skryptów dla kart. Część kart ma własne mechaniki

- Sprites, czyli grafik

- Stats, czyli informacji na temat kart.

Za ich pomocą generator kart jest w stanie zbudować wszystkie dane potrzebne dla silnika YGOPro.