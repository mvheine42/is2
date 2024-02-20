Class {
	#name : #MoonWalkEffect,
	#superclass : #Object,
	#instVars : [
		'number',
		'isReversed'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
MoonWalkEffect class >> with: aNumber [

	^ self new initializeWith: aNumber
]

{ #category : #action }
MoonWalkEffect >> implementOn: aBoardGame [

	isReversed
		ifTrue: [ aBoardGame applyMoonWalkEffect: number negated]
		ifFalse: [ aBoardGame applyMoonWalkEffect: number ]
]

{ #category : #initialize }
MoonWalkEffect >> initializeEffect [
	isReversed := false.
]

{ #category : #'instance creation' }
MoonWalkEffect >> initializeWith: aNumber [

	number := aNumber
]

{ #category : #reverse }
MoonWalkEffect >> reverseEffect [
	isReversed
		ifTrue: [ isReversed := false. ]
		ifFalse: [ isReversed := true. ]
]
