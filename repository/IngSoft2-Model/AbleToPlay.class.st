Class {
	#name : #AbleToPlay,
	#superclass : #Object,
	#instVars : [
		'spaceships',
		'disabledSpaceships'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #enable }
AbleToPlay class >> enable: someSpaceships [
	^ self new enable: someSpaceships.
]

{ #category : #disable }
AbleToPlay >> disable: aSpaceship [
	spaceships remove: aSpaceship.
	disabledSpaceships add: aSpaceship.
]

{ #category : #enable }
AbleToPlay >> enable: someSpaceships [
	spaceships := OrderedCollection new.
	disabledSpaceships := OrderedCollection new.
	spaceships addAll: someSpaceships.

]

{ #category : #enable }
AbleToPlay >> enableA: aSpaceship [
	disabledSpaceships remove: aSpaceship.
	spaceships add: aSpaceship.

]

{ #category : #enable }
AbleToPlay >> forA: aSpaceship [
	(spaceships includes: aSpaceship)
	ifTrue: [ ^true ]ifFalse: [ ^false ]
]
