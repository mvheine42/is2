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
RedoCard >> isPlayedOn: aBoardGame from: aCardPlayers affecting: aCell [ 
	(aBoardGame lastCardPlayed) isPlayedOn: aBoardGame from: aCardPlayers affecting: aCell .
]

{ #category : #play }
RedoCard >> isPlayedOn: aBoardGame from: aSpaceship choosing: aCard [ 
	(aBoardGame lastCardPlayed) isPlayedOn: aBoardGame from: aSpaceship choosing: aCard
]

{ #category : #play }
RedoCard >> isPlayedOn: aBoardGame from: aSpaceship to: anotherSpaceship [
	(aBoardGame lastCardPlayed) isPlayedOn: aBoardGame from: aSpaceship to: anotherSpaceship.
]

{ #category : #play }
RedoCard >> isPlayedOn: aBoardGame from: aSpaceship toAll: spaceships [ 
	(aBoardGame lastCardPlayed) isPlayedOn: aBoardGame from: aSpaceship toAll: spaceships.
]
