Class {
	#name : #NoEffect,
	#superclass : #Object,
	#instVars : [
		'isReversed'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #action }
NoEffect >> implementOn: aBoardGame [
	
]

{ #category : #intialization }
NoEffect >> initializeEffect [
	isReversed := false.
]

{ #category : #reverse }
NoEffect >> reverseEffect [
	isReversed := true.
]
