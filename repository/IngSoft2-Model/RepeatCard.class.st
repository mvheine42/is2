Class {
	#name : #RepeatCard,
	#superclass : #Object,
	#instVars : [
		'cardId'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance variable' }
RepeatCard >> id [

	^ cardId
]

{ #category : #'instance variable' }
RepeatCard >> id: number [

	cardId := number
]

{ #category : #play }
RepeatCard >> isPlayedBy: aCroupier from: aSpaceship choosing: aCard [ 
	Error signal: 'To play card choose a player'
]

{ #category : #play }
RepeatCard >> isThrownOn: aBoardGame from: aSpaceship to: anotherSpaceship [
	aBoardGame repeatCardTo: anotherSpaceship.
]

{ #category : #play }
RepeatCard >> isThrownOn: aBoardGame from: aSpaceship toAll: spaceships [
	aBoardGame repeatCardTo: (spaceships at: 1)
]

{ #category : #'instance variable' }
RepeatCard >> name [

	^ 'repeat'
]

{ #category : #action }
RepeatCard >> playOn: aBoardGame to: aCardPlayers [

	aBoardGame repeatCardTo: (aCardPlayers spaceships at: 1)
]

{ #category : #action }
RepeatCard >> playOn: aCroupier toSelected: aSpeedCard [ 
	Error signal: 'To play card, choose a player'.
]
