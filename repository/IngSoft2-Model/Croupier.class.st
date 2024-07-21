Class {
	#name : #Croupier,
	#superclass : #Object,
	#instVars : [
		'deckOfCards',
		'playersCards',
		'indexCards',
		'permanentCardsPlayers',
		'lastCardPlayed'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Croupier class >> handling: aDeckOfCards [ 
	^(self new) handling: aDeckOfCards.
]

{ #category : #cancellation }
Croupier >> cancellationCardAffectingCardOn: aCard [ 
	| aCardPlayers |
	aCardPlayers := permanentCardsPlayers detect: [ :cardPlayers | 
		                cardPlayers cards id = aCard id ]ifNone:[Error signal: 'That card does not exist'].
	
	permanentCardsPlayers remove: aCardPlayers .
	lastCardPlayed := CancellationCard new.
]

{ #category : #cancellation }
Croupier >> cancellationCardAffectingCell: aCard [ 
	((aCard acell effect) reverseEffect).
]

{ #category : #action }
Croupier >> cancellationCardTo: aCard [
	aCard isCancelledBy: self.
]

{ #category : #action }
Croupier >> dealACardTo: aSpaceship [
		playersCards do: [ :playerCards | 
		(playerCards spaceships = aSpaceship) ifTrue: [ 
			playerCards cards add: (deckOfCards cards at: indexCards).
			indexCards := indexCards \\ deckOfCards cards size + 1]].
]

{ #category : #'instance creation' }
Croupier >> dealCardsWhenGameIsStartedTo: spaceships [
	| size amountOfCards |
	size := 0.
	amountOfCards := 0.
	playersCards := OrderedCollection new.
	
	[ spaceships size > size ] whileTrue: [ 
		playersCards add: (PlayerCards
				 of: (spaceships at: size + 1)).
		self dealACardTo: (spaceships at: size + 1).
		self dealACardTo: (spaceships at: size + 1).
		
		size := size + 1 ]
	
	
]

{ #category : #'instance creation' }
Croupier >> handling: aDeckOfCards [ 
	deckOfCards := aDeckOfCards.
	indexCards := 1.
	permanentCardsPlayers:= OrderedCollection new.
]

{ #category : #action }
Croupier >> lastCardPlayed [
	^lastCardPlayed .
]

{ #category : #action }
Croupier >> permanentCardsOf: aSpaceship [

	| anAmount |
	anAmount := 0.
	permanentCardsPlayers do: [ :cardPlayers | 
		(cardPlayers spaceships includes: aSpaceship) ifTrue: [ 
			anAmount := anAmount + (cardPlayers cards implementOn: self) ] ].
	^ anAmount
]

{ #category : #action }
Croupier >> playerCardOf: aSpaceship [

	| aPlayerCards |
	aPlayerCards := playersCards
		                detect: [ :playerCards | 
		                playerCards spaceships = aSpaceship ]
		                ifNone: [ Error signal: 'You are not playing' ].
	^ aPlayerCards
]

{ #category : #action }
Croupier >> recordPermanent: aCardPlayers [
	permanentCardsPlayers add: aCardPlayers.
	lastCardPlayed := aCardPlayers cards
]

{ #category : #play }
Croupier >> take: aCard fromTheHandOf: aSpaceship [
	| aPlayerCards |
	aPlayerCards:= self playerCardOf: aSpaceship.
	aPlayerCards removeCard: aCard id.
]

{ #category : #action }
Croupier >> takeACardFrom: aSpaceship [
	| aPlayerCards aCard|
	aPlayerCards:= self playerCardOf: aSpaceship.
	aCard := (aPlayerCards cards at: 1).
	aPlayerCards removeCard: aCard id.
]
