Class {
	#name : #ReversalCard,
	#superclass : #Object,
	#instVars : [
		'cardId',
		'cellNumber'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #action }
ReversalCard >> canBePlayedIn: aBoardGame for: aSpaceship [
	aBoardGame validatePermanentPlayFor: aSpaceship.
]

{ #category : #'instance variable' }
ReversalCard >> cellNumber [
	^cellNumber.
]

{ #category : #'instance variables' }
ReversalCard >> id [
	^cardId.
]

{ #category : #'instance variable' }
ReversalCard >> id: number [
	cardId := number.
]

{ #category : #action }
ReversalCard >> implementOn: aCroupier [ 
	^0.
]

{ #category : #reverse }
ReversalCard >> keepACellToReverse: aCell [ 
	cellNumber := aCell quantity.
	
]

{ #category : #'instance variable' }
ReversalCard >> name [
	^'reversal'.
]

{ #category : #action }
ReversalCard >> playOn: aCroupier toAll: aCardPlayers [ 
	aCroupier recordPermanent: aCardPlayers.
]
