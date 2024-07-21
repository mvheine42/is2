Class {
	#name : #SpeedCard,
	#superclass : #Object,
	#instVars : [
		'cardId'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance variable' }
SpeedCard >> id [

	^ cardId
]

{ #category : #initialization }
SpeedCard >> id: number [

	cardId := number
]

{ #category : #action }
SpeedCard >> implementOn: aBoardGame [

	^ 1
]

{ #category : #cancellation }
SpeedCard >> isCancelledBecauseOf: aCroupier [ 
	aCroupier cancellationCardAffectingCardOn: self .
]

{ #category : #play }
SpeedCard >> isPlayedBy: aCroupier from: aCardPlayers affecting: aCell [ 
	Error signal: 'To play card choose a player'.
]

{ #category : #cancellation }
SpeedCard >> isPlayedBy: aCroupier from: aSpaceship choosing: aCard [ 
	Error signal: 'To play card choose a player'.
]

{ #category : #play }
SpeedCard >> isThrownOn: aBoardGame from: aSpaceship to: anotherSpaceship [
	|aCardPlayers|
	(aBoardGame validateSpaceshipTurnFor: aSpaceship)ifTrue:[
	aCardPlayers := CardPlayers
		                of: self
		                with: (OrderedCollection with: anotherSpaceship).
	aBoardGame recordPermanent: aCardPlayers.]ifFalse: [  ].
]

{ #category : #play }
SpeedCard >> isThrownOn: aBoardGame from: aSpaceship toAll: spaceships [
	Error signal: 'To play card choose a player'.
]

{ #category : #'instance variable' }
SpeedCard >> name [

	^ 'speed'
]

{ #category : #action }
SpeedCard >> playOn: aBoardGame toSelected: aSpaceshipCard [ 
	
	Error signal: 'To play card, choose a player'.
]
