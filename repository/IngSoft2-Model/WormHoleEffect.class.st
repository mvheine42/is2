Class {
	#name : #WormHoleEffect,
	#superclass : #Object,
	#instVars : [
		'isReversed'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #action }
WormHoleEffect >> implementOn: aBoardGame [

	isReversed ifTrue:[aBoardGame applyMovingEffect: 4.]
	ifFalse:[aBoardGame applyMovingEffect: -4.].
]

{ #category : #initialization }
WormHoleEffect >> initializeEffect [
	isReversed := false.
]

{ #category : #reverse }
WormHoleEffect >> reverseEffect [
	isReversed
		ifTrue: [ isReversed := false. ]
		ifFalse: [ isReversed := true. ]
]
