Rules for building the game code
================================

This is the basic and very general documentation for building game code to achieve a full product. Feel free to ask any questions on the Matrix channel.

The game consists of a couple of elements:

* YGOPro game engine. This is the engine responsible for all mechanics and processing. It allows (after completing the game with Assets and other data) to create the main core of the game.

* Windbot as an artificial intelligence project. It is a project that pretends to be a game client in order to play a duel with us.

* SRVPro is a game server project. It allows players to be connected via the internet.

* Summoned Monsters is a project to create game assets. It allows to generate cards (graphics) and databases. Without this, it is impossible for YGOPro engine to work.

Summoned Monsters project itself consists mainly of three main directories:

* Windbot-AIGen is a group of scripts used to build a basic knowledge base for AI. In short, rules for Windbot are defined based on this data. 

* Build is a collection of scripts to facilitate the building of the game. All scripts except srvpro should work fine after installing the necessary dependencies on most Linux distributions. In the case of srvpro, it is recommended to build it on a Debian / Ubuntu system. In general, of course, I recommend building the game only on Debian / Ubuntu, as different distributions have problems building the code.

* Cardgenerator is a script that builds from asset data. It consists of 3 elements:

- Scripts, which are the scripts for the cards. Some cards have their own mechanics

- Sprites, i.e. graphics

- Stats, i.e. information about the cards.

With these, the card generator is able to build all the data needed for the YGOPro engine.