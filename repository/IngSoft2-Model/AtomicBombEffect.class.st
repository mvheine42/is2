Class {
	#name : #AtomicBombEffect,
	#superclass : #Object,
	#instVars : [
		'isReversed'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #action }
AtomicBombEffect >> implementOn: aBoardGame [

	aBoardGame applyAtomicBombEffect
]

{ #category : #initialization }
AtomicBombEffect >> initializeEffect [
	isReversed := false.
]

{ #category : #reverse }
AtomicBombEffect >> reverseEffect [
	isReversed
		ifTrue: [ isReversed := false. ]
		ifFalse: [ isReversed := true. ]
]
