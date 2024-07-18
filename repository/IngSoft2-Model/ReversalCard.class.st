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
ReversalCard >> name [
	^'reversal'.
]

{ #category : #play }
ReversalCard >> playOn: aCroupier reversing: aCell affecting: aCardPlayers [ 
	aCell effect reverseEffect.
	cell := aCell.
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
