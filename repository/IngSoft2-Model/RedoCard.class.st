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
RedoCard >> isPlayedOn: aBoardGame from: aSpaceship [
	| aCardPlayers |
	(aBoardGame validateAbilityToPlayOf: aSpaceship)
		ifTrue: [ 
			(aBoardGame validateSpaceshipTurnFor: aSpaceship on: self)
				ifTrue: [ 
					aCardPlayers := CardPlayers
						                of: aBoardGame lastCardPlayed
						                with: aBoardGame spaceships.
					aBoardGame recordPermanent: aCardPlayers ]
				ifFalse: [  ] ]
		ifFalse: [  ]
]

{ #category : #play }
RedoCard >> isPlayedOn: aBoardGame from: aSpaceship affecting: aCell [ 
	|aCardPlayers|
	(aBoardGame validateAbilityToPlayOf: aSpaceship)
		ifTrue: [ 
			(aBoardGame validateSpaceshipTurnFor: aSpaceship on: self)ifTrue:[
		aCell effect reverseEffect.
		aCardPlayers := CardPlayers
		                of: self
		                with: (aBoardGame spaceships).
		]ifFalse: [  ]].
]

{ #category : #play }
RedoCard >> isPlayedOn: aBoardGame from: aSpaceship choosing: aCard [ 
	(aBoardGame lastCardPlayed) isPlayedOn: aBoardGame from: aSpaceship choosing: aCard
]

{ #category : #play }
RedoCard >> isPlayedOn: aBoardGame from: aSpaceship to: anotherSpaceship [
	| aCardPlayers |
	aBoardGame validateSpaceshipExists: anotherSpaceship.
	(aBoardGame validateAbilityToPlayOf: aSpaceship)
		ifTrue: [ 
			(aBoardGame validateSpaceshipTurnFor: aSpaceship on: self)
				ifTrue: [ 
					aCardPlayers := CardPlayers
						                of: aBoardGame lastCardPlayed
						                with: (OrderedCollection with: anotherSpaceship).
					aBoardGame recordPermanent: aCardPlayers ]
				ifFalse: [  ] ]
		ifFalse: [  ].
]

{ #category : #play }
RedoCard >> isPlayedOn: aBoardGame from: aSpaceship toAll: spaceships [ 
	(aBoardGame lastCardPlayed) isPlayedOn: aBoardGame from: aSpaceship toAll: spaceships.
]
