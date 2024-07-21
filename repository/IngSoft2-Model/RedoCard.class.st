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

{ #category : #cancellation }
RedoCard >> isPlayedBy: aCroupier from: aSpaceship choosing: aCard [ 
	aCroupier play: aCroupier lastCardPlayed forSelected: aCard.
]

{ #category : #play }
RedoCard >> isThrownOn: aBoardGame from: aSpaceship to: anotherSpaceship [
	(aBoardGame lastCardPlayed) isThrownOn: aBoardGame from: aSpaceship to: anotherSpaceship.
]

{ #category : #play }
RedoCard >> isThrownOn: aBoardGame from: aSpaceship toAll: spaceships [ 
	(aBoardGame lastCardPlayed) isThrownOn: aBoardGame from: aSpaceship toAll: spaceships .
]

{ #category : #'instance variables' }
RedoCard >> name [

	^ 'redo'
]

{ #category : #action }
RedoCard >> playOn: aCroupier toSelected: card [

	"aCroupier play: aCroupier lastCardPlayed forSelected: card"
]
