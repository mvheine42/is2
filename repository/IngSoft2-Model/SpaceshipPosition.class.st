Class {
	#name : #SpaceshipPosition,
	#superclass : #Object,
	#instVars : [
		'spaceship',
		'position',
		'ableToPlay'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
SpaceshipPosition class >> named: spaceshipName on: aPosition [

	^ self new initializeNamed: spaceshipName on: aPosition
]

{ #category : #'instance variables' }
SpaceshipPosition >> >= anObject [
	^ (position cellNumber >= anObject position cellNumber) and: (position round >= anObject position round).
]

{ #category : #'instance variable' }
SpaceshipPosition >> ableToPlay [
	^ ableToPlay
]

{ #category : #action }
SpaceshipPosition >> disableToPlay [
	ableToPlay := false.
]

{ #category : #actions }
SpaceshipPosition >> enableToPlay [
	ableToPlay := true.
]

{ #category : #'instance creation' }
SpaceshipPosition >> initializeNamed: spaceshipName on: aPosition [

	spaceship := spaceshipName.
	position := aPosition.
	ableToPlay := true.
]

{ #category : #'instance variables' }
SpaceshipPosition >> position [

	^ position
]

{ #category : #'instance variables' }
SpaceshipPosition >> spaceships [

	^ spaceship
]
