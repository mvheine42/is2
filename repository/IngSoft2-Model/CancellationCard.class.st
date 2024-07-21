Class {
	#name : #CancellationCard,
	#superclass : #Object,
	#instVars : [
		'cardId'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance variable' }
CancellationCard >> id [
	^cardId 
]

{ #category : #'instance variable' }
CancellationCard >> id: number [ 
	cardId:= number.
]

{ #category : #cancellation }
CancellationCard >> isCancelledBecauseOf: aCroupier [ 
	Error signal: 'To play card choose permanent card'.
]

{ #category : #play }
CancellationCard >> isPlayedBy: aCroupier from: aCardPlayers affecting: aCell [ 
	Error signal: 'You have to choose a card'.
]

{ #category : #cancellation }
CancellationCard >> isPlayedBy: aCroupier from: aSpaceship choosing: anotherCard [
	aCroupier play: self from: aSpaceship choosing: anotherCard.
]

{ #category : #play }
CancellationCard >> isThrownOn: aBoardGame from: aSpaceship to: anotherSpaceship [ 
	Error signal: 'You have to choose a card.'
]

{ #category : #play }
CancellationCard >> isThrownOn: aBoardGame from: aSpaceship toAll: spaceships [
	Error signal: 'To play card choose a card'
]

{ #category : #'instance variable' }
CancellationCard >> name [
	^'cancellation'.
]

{ #category : #action }
CancellationCard >> playOn: aCroupier toSelected: card [ 
	
	aCroupier cancellationCardTo: card
]
