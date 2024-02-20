Class {
	#name : #HyperJumpEffect,
	#superclass : #Object,
	#instVars : [
		'jumps',
		'jumpsIndex',
		'isReversed'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
HyperJumpEffect class >> with: aSequenceOfJumps [

	^ self new initializeWith: aSequenceOfJumps
]

{ #category : #action }
HyperJumpEffect >> implementOn: aBoardGame [

	| value |
	value := jumps at: jumpsIndex .
	jumpsIndex := jumpsIndex \\ jumps size + 1.
	
	isReversed ifTrue:[aBoardGame applyHyperJumpEffect: (value parsecs quantity) negated]
	ifFalse:[aBoardGame applyHyperJumpEffect: (value parsecs quantity)].
]

{ #category : #initialize }
HyperJumpEffect >> initializeEffect [
	isReversed := false.
]

{ #category : #'instance creation' }
HyperJumpEffect >> initializeWith: aSequenceOfJumps [

	jumps := aSequenceOfJumps.
	jumpsIndex := 1
]

{ #category : #reverse }
HyperJumpEffect >> reverseEffect [
	isReversed
		ifTrue: [ isReversed := false. ]
		ifFalse: [ isReversed := true. ]
]
