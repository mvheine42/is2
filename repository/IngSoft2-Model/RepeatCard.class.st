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
RepeatCard >> isPlayedOn: aBoardGame from: aSpaceship [
	aBoardGame repeatCardTo: ((aBoardGame spaceships)  at: 1)
]

{ #category : #play }
RepeatCard >> isPlayedOn: aBoardGame from: aSpaceship choosing: aCard [ 
	Error signal: 'To play card choose a player'
]

{ #category : #play }
RepeatCard >> isPlayedOn: aBoardGame from: aSpaceship to: anotherSpaceship [
	aBoardGame repeatCardTo: anotherSpaceship.
]

{ #category : #play }
RepeatCard >> isPlayedOn: aBoardGame from: aSpaceship toAll: spaceships [
	aBoardGame repeatCardTo: (spaceships at: 1)
]
