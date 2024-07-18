Class {
	#name : #Penalizer,
	#superclass : #Object,
	#instVars : [
		'ableToPlay'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #enable }
Penalizer >> enableToPlay: aSpaceship [
	ableToPlay enableA: aSpaceship.
]

{ #category : #enable }
Penalizer >> enableToPlayAll: someSpaceships [
	ableToPlay := AbleToPlay enable: someSpaceships.
	
]

{ #category : #penalize }
Penalizer >> move: aSpaceship backwardsOn: aBoardGame [ 
	aBoardGame moveCheaterBackwards: aSpaceship.
	ableToPlay disable: aSpaceship.
]

{ #category : #validation }
Penalizer >> validatesTurnFor: aSpaceship [
	(ableToPlay forA: aSpaceship)ifTrue: [ ^true ] ifFalse: [ ^false ]
]
