Class {
	#name : #DrawCardEffect,
	#superclass : #Object,
	#instVars : [
		'isReversed'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #action }
DrawCardEffect >> implementOn: aBoardGame [ 
	aBoardGame dealACardEffect.
]

{ #category : #initialize }
DrawCardEffect >> initializeEffect [
	isReversed := false.
]

{ #category : #reverse }
DrawCardEffect >> reverseEffect [
	isReversed
		ifTrue: [ isReversed := false. ]
		ifFalse: [ isReversed := true. ]
]
