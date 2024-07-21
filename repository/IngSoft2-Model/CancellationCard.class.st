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

{ #category : #cancellation }
CancellationCard >> isPlayedBy: aCroupier from: aSpaceship choosing: anotherCard [
	aCroupier play: self from: aSpaceship choosing: anotherCard.
]

{ #category : #play }
CancellationCard >> isPlayedOn: aBoardGame from: aSpaceship choosing: aCard [ 
	aBoardGame cancellationCardTo: aCard.
]

{ #category : #play }
CancellationCard >> isThrownOn: aBoardGame from: aSpaceship affecting: aCell [ 
	Error signal: 'To play card choose a card'.
]

{ #category : #play }
CancellationCard >> isThrownOn: aBoardGame from: aSpaceship to: anotherSpaceship [ 
	Error signal: 'You have to choose a card.'
]

{ #category : #play }
CancellationCard >> isThrownOn: aBoardGame from: aSpaceship toAll: spaceships [
	Error signal: 'To play card choose a card'
]
