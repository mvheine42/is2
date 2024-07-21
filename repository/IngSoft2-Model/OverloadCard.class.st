Class {
	#name : #OverloadCard,
	#superclass : #Object,
	#instVars : [
		'cardId'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance variables' }
OverloadCard >> id [

	^ cardId
]

{ #category : #initialization }
OverloadCard >> id: number [ 

	cardId:= number.
]

{ #category : #action }
OverloadCard >> implementOn: aBoardGame [

	^ -2
]

{ #category : #testing }
OverloadCard >> isCancelledBecauseOf: aCroupier [ 
	aCroupier cancellationCardAffectingCardOn: self.
]

{ #category : #play }
OverloadCard >> isPlayedOn: aBoardGame from: aSpaceship choosing: aCard [ 
	Error signal: 'To play card choose a player'
]

{ #category : #play }
OverloadCard >> isThrownOn: aBoardGame from: aSpaceship affecting: aCell [ 
	Error signal: 'To play card choose a player'.
]

{ #category : #play }
OverloadCard >> isThrownOn: aBoardGame from: aSpaceship to: anotherSpaceship [
	|aCardPlayers|
	(aBoardGame validateSpaceshipTurnFor: aSpaceship)ifTrue:[
	aCardPlayers := CardPlayers
		                of: self
		                with: (OrderedCollection with: anotherSpaceship).
	aBoardGame recordPermanent: aCardPlayers.]ifFalse: [  ].
]

{ #category : #play }
OverloadCard >> isThrownOn: aBoardGame from: aSpaceship toAll: spaceships [
	Error signal: 'To play card choose a player'
]
