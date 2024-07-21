Class {
	#name : #RedoCard,
	#superclass : #Object,
	#instVars : [
		'cardId'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance variables' }
RedoCard >> id [

	^ cardId
]

{ #category : #action }
RedoCard >> id: number [

	cardId := number
]

{ #category : #play }
RedoCard >> isPlayedOn: aBoardGame from: aSpaceship choosing: aCard [ 
	(aBoardGame lastCardPlayed) isPlayedOn: aBoardGame from: aSpaceship choosing: aCard
]

{ #category : #play }
RedoCard >> isThrownOn: aBoardGame from: aCardPlayers affecting: aCell [ 
	(aBoardGame lastCardPlayed) isThrownOn: aBoardGame from: aCardPlayers affecting: aCell .
]

{ #category : #play }
RedoCard >> isThrownOn: aBoardGame from: aSpaceship to: anotherSpaceship [
	(aBoardGame lastCardPlayed) isThrownOn: aBoardGame from: aSpaceship to: anotherSpaceship.
]

{ #category : #play }
RedoCard >> isThrownOn: aBoardGame from: aSpaceship toAll: spaceships [ 
	(aBoardGame lastCardPlayed) isThrownOn: aBoardGame from: aSpaceship toAll: spaceships .
]
