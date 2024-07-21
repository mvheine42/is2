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
SpeedCard >> isCancelledBy: aCroupier [ 
	aCroupier cancellationCardAffectingCardOn: self .
]

{ #category : #play }
SpeedCard >> isPlayedOn: aBoardGame from: aSpaceship [
	Error signal: 'To play card choose a player'.
]

{ #category : #play }
SpeedCard >> isPlayedOn: aBoardGame from: aSpaceship affecting: aCell [ 
	Error signal: 'To play card choose a player'.
]

{ #category : #play }
SpeedCard >> isPlayedOn: aBoardGame from: aSpaceship choosing: aCard [ 
	Error signal: 'To play card choose a player'
]

{ #category : #play }
SpeedCard >> isPlayedOn: aBoardGame from: aSpaceship to: anotherSpaceship [
	| aCardPlayers |
	aBoardGame validateSpaceshipExists: anotherSpaceship.
	(aBoardGame validateAbilityToPlayOf: aSpaceship)
		ifTrue: [ 
			(aBoardGame validateSpaceshipTurnFor: aSpaceship on: self)
				ifTrue: [ 
					aCardPlayers := CardPlayers
						                of: self
						                with: (OrderedCollection with: anotherSpaceship).
					aBoardGame recordPermanent: aCardPlayers ]
				ifFalse: [  ] ]
		ifFalse: [  ].
]
