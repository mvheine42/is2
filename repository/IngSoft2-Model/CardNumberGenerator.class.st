Class {
	#name : #CardNumberGenerator,
	#superclass : #Object,
	#instVars : [
		'amountOfCards',
		'speeds',
		'overloads',
		'accelerations',
		'cancellations',
		'redos',
		'repeats',
		'cards',
		'reversals'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialize }
CardNumberGenerator class >> setWithCards: aNumber [ 
	^(self new) initializeWithCards: aNumber.
]

{ #category : #'instance variable' }
CardNumberGenerator >> accelerations [
	^ accelerations
]

{ #category : #'instance variable' }
CardNumberGenerator >> cancellations [
	^ cancellations
]

{ #category : #'instance creation' }
CardNumberGenerator >> cards [

	^ cards
]

{ #category : #'instance creation' }
CardNumberGenerator >> initializeDeck [
	1 to: amountOfCards do: [ :index | 
		| aNumber |
		aNumber := 70 atRandom.
		(aNumber > 0 and: aNumber <= 10) ifTrue: [ 
			cards add: SpeedCard new.
			speeds := speeds + 1 ].
		(aNumber > 10 and: aNumber <= 20) ifTrue: [ 
			cards add: OverloadCard new.
			overloads := overloads + 1 ].
		(aNumber > 20 and: aNumber <= 30) ifTrue: [ 
			cards add: AccelerationCard new.
			accelerations := accelerations + 1 ].
		(aNumber > 30 and: aNumber <= 40) ifTrue: [ 
			cards add: CancellationCard new.
			cancellations := cancellations + 1 ].
		(aNumber > 40 and: aNumber <= 50) ifTrue: [ 
			cards add: RedoCard new.
			redos := redos + 1 ].
		(aNumber > 50 and: aNumber <= 60) ifTrue: [ 
			cards add: RepeatCard new.
			repeats := repeats + 1 ].
		(aNumber > 60 and: aNumber <= 70) ifTrue: [ 
			cards add: ReversalCard new.
			reversals := reversals + 1 ] ].
]

{ #category : #'instance creation' }
CardNumberGenerator >> initializeWithCards: aNumber [
	cards:= OrderedCollection new.
	amountOfCards := aNumber.
	speeds := 0.
	overloads := 0.
	accelerations := 0.
	cancellations := 0.
	redos := 0.
	repeats := 0.
	reversals := 0.
	self initializeDeck.
	
]

{ #category : #'instance variable' }
CardNumberGenerator >> overloads [
	^ overloads
]

{ #category : #'instance variable' }
CardNumberGenerator >> redos [
	^ redos
]

{ #category : #'instance variable' }
CardNumberGenerator >> repeats [
	^ repeats
]

{ #category : #'instance variable' }
CardNumberGenerator >> reversals [

	^ reversals
]

{ #category : #'instance variable' }
CardNumberGenerator >> speeds [
	^ speeds
]
