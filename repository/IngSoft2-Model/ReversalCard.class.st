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

{ #category : #cancellation }
ReversalCard >> isCancelledBecauseOf: aCroupier [ 
	aCroupier cancellationCardAffectingCell: self.
]

{ #category : #play }
ReversalCard >> isPlayedBy: aCroupier from: aCardPlayers affecting: aCell [ 
	aCell effect reverseEffect.
	cell := aCell.
	aCroupier recordPermanent: aCardPlayers.
]

{ #category : #play }
ReversalCard >> isPlayedBy: aCroupier from: aSpaceship choosing: aCard [ 
	Error signal: 'To play reversal card, please choose a cell'.
]

{ #category : #play }
ReversalCard >> isThrownOn: aBoardGame from: aSpaceship to: anotherSpaceship [
	Error signal: 'To play Reversal Card, please choose a cell'
]

{ #category : #play }
ReversalCard >> isThrownOn: aBoardGame from: aSpaceship toAll: spaceships [
	Error signal: 'To play Reversal Card, choose a cell'
]

{ #category : #'instance variable' }
ReversalCard >> name [
	^'reversal'.
]

{ #category : #action }
ReversalCard >> playOn: aCroupier toSelected: anInteger [ 
	Error signal: 'To play Reversal Card, please choose a cell number.'.
]
