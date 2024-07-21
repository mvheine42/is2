Class {
	#name : #AccelerationCard,
	#superclass : #Object,
	#instVars : [
		'cardId'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance variable' }
AccelerationCard >> id [
	^cardId 
]

{ #category : #'instance variable' }
AccelerationCard >> id: number [ 
	cardId:= number.
]

{ #category : #action }
AccelerationCard >> implementOn: aBoardGame [ 
	^1
]

{ #category : #cancellation }
AccelerationCard >> isCancelledBecauseOf: aCroupier [ 
	aCroupier cancellationCardAffectingCardOn: self.
]

{ #category : #play }
AccelerationCard >> isPlayedBy: aCroupier from: aCardPlayers affecting: aCell [ 
	Error signal: 'You cannot choose a cell for acceleration card'.
]

{ #category : #play }
AccelerationCard >> isPlayedBy: aCroupier from: aSpaceship choosing: aCard [ 
	Error signal: 'You cannot choose a card for acceleration card.'
]

{ #category : #play }
AccelerationCard >> isThrownOn: aBoardGame from: aSpaceship to: anotherSpaceship [
	Error signal: 'You cannot choose a player for acceleration card.'
]

{ #category : #play }
AccelerationCard >> isThrownOn: aBoardGame from: aSpaceship toAll: spaceships [ 
	|aCardPlayers|
	(aBoardGame validateSpaceshipTurnFor: aSpaceship)ifTrue:[
	aCardPlayers := CardPlayers
		                of: self
		                with: spaceships.
	aBoardGame recordPermanent: aCardPlayers.]ifFalse: [  ].
]

{ #category : #'instance variable' }
AccelerationCard >> name [
	'acceleration'.
]

{ #category : #action }
AccelerationCard >> playOn: aCroupier to: aCardPlayers [ 
	Error signal: 'You cannot choose a player for acceleration card.'
]

{ #category : #action }
AccelerationCard >> playOn: aCroupier toAll: aCardPlayers [ 
	aCroupier recordPermanent: aCardPlayers
]

{ #category : #action }
AccelerationCard >> playOn: aBoardGame toSelected: aCard [ 
	
	Error signal: 'You cannot choose a card for acceleration card.'
]
