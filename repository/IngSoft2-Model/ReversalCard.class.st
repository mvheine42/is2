Class {
	#name : #ReversalCard,
	#superclass : #Object,
	#instVars : [
		'cardId',
		'cell'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance variable' }
ReversalCard >> acell [
	^cell.
]

{ #category : #action }
ReversalCard >> canBePlayedIn: aBoardGame for: aSpaceship [
	aBoardGame validatePermanentPlayFor: aSpaceship.
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

{ #category : #'instance variable' }
ReversalCard >> keepACellToReverse: aCell [
	cell := aCell.
]

{ #category : #'instance variable' }
ReversalCard >> name [
	^'reversal'.
]

{ #category : #reversal }
ReversalCard >> playOn: aCroupier affectingAll: aCardPlayers [ 
	aCroupier recordPermanent: aCardPlayers.
]

{ #category : #action }
ReversalCard >> playOn: aCroupier to: aCardPlayers [ 
	Error signal: 'To play Reversal Card, please choose a cell number.'
]

{ #category : #action }
ReversalCard >> playOn: aCroupier toAll: aCardPlayers [ 
	Error signal: 'To play Reversal Card, choose a cell number'.
]

{ #category : #action }
ReversalCard >> playOn: aCroupier toSelected: anInteger [ 
	Error signal: 'To play Reversal Card, please choose a cell number.'.
]
