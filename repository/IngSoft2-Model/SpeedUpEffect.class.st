Class {
	#name : #SpeedUpEffect,
	#superclass : #Object,
	#instVars : [
		'isReversed'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #action }
SpeedUpEffect >> implementOn: aBoardGame [

	isReversed ifTrue:[aBoardGame applyMovingEffect: -4.]
	ifFalse:[aBoardGame applyMovingEffect: 4.].
]

{ #category : #initialization }
SpeedUpEffect >> initializeEffect [
	isReversed := false.
]

{ #category : #reverse }
SpeedUpEffect >> reverseEffect [

	isReversed
		ifTrue: [ isReversed := false. ]
		ifFalse: [ isReversed := true. ]
]
