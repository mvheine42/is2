Class {
	#name : #ReversalCardTest,
	#superclass : #TestCase,
	#instVars : [
		'aReversalCard',
		'aCancellationCard',
		'aDeckOfCards',
		'aCroupier',
		'anOverloadCard',
		'aPenalizer'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #running }
ReversalCardTest >> setUp [

	super setUp.

	aReversalCard := ReversalCard new.
	aCancellationCard := CancellationCard new.
	anOverloadCard := OverloadCard new.
	aDeckOfCards := DeckOfCards with: (OrderedCollection
			                 with: aReversalCard
			                 with: aCancellationCard).

	aCroupier := Croupier handling: aDeckOfCards.
	aPenalizer := Penalizer new.
]

{ #category : #running }
ReversalCardTest >> should: anErrorBlock raise: anExceptionClass withMessage: anErrorMessage [

	self
		should: anErrorBlock
		raise: anExceptionClass
		withExceptionDo: [ :error | 
			self assert: error messageText equals: anErrorMessage ].
]

{ #category : #tests }
ReversalCardTest >> test01WhenASpaceshipThrowsReversalCardOnSpeedUpCellThenSpaceshipGoesBackwardsWhenLandingOnCell [

	| spaceships aBoard aBoardGame cellEffects aMoonWalkEffect aSpeedUpCell|
	
	aMoonWalkEffect := MoonWalkEffect with: 5.
	
	aSpeedUpCell := (Cell on: 10 of: SpeedUpEffect new).
	
	cellEffects := OrderedCollection new.
	cellEffects add: (Cell on: 1 of: NoEffect new).
	cellEffects add: (Cell on: 2 of: NoEffect new).
	cellEffects add: (Cell on: 3 of: HyperJumpEffect new).
	cellEffects add: (Cell on: 4 of: NoEffect new).
	cellEffects add: (Cell on: 5 of: DrawCardEffect new).
	cellEffects add: (Cell on: 6 of: WormHoleEffect new).
	cellEffects add: (Cell on: 7 of: NoEffect new).
	cellEffects add: (Cell on: 8 of: aMoonWalkEffect).
	cellEffects add: (Cell on: 9 of: AtomicBombEffect new).
	cellEffects add: aSpeedUpCell.
	
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.

	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling: (OrderedCollection with: (LoadedDie of: #( 9 9 3 )))
		              on: aBoard
		              with: 2 managedBy: aCroupier controlledBy: aPenalizer.
		
	aBoardGame throw: aReversalCard from: 'Vicky' affectingOnCell: aSpeedUpCell.

	aBoardGame playTurnFor: 'Vicky'.
	aBoardGame playTurnFor: 'Cami'.
	
	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 6.

	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 6.
]

{ #category : #tests }
ReversalCardTest >> test02WhenASpaceshipThrowsReversalCardOnNoEffectCellAndOnSpeedUpCellThenOneReversesAndTheOtherDoesNot [

	| spaceships aBoard aBoardGame cellEffects aMoonWalkEffect aSpeedUpCell aNoEffectCell|
	
	aMoonWalkEffect := MoonWalkEffect with: 5.
	aNoEffectCell := (Cell on: 4 of: NoEffect new).
	aSpeedUpCell := (Cell on: 10 of: SpeedUpEffect new).
	
	cellEffects := OrderedCollection new.
	cellEffects add: (Cell on: 1 of: NoEffect new).
	cellEffects add: (Cell on: 2 of: NoEffect new).
	cellEffects add: (Cell on: 3 of: HyperJumpEffect new).
	cellEffects add: aNoEffectCell.
	cellEffects add: (Cell on: 5 of: DrawCardEffect new).
	cellEffects add: (Cell on: 6 of: WormHoleEffect new).
	cellEffects add: (Cell on: 7 of: NoEffect new).
	cellEffects add: (Cell on: 8 of: aMoonWalkEffect).
	cellEffects add: (Cell on: 9 of: AtomicBombEffect new).
	cellEffects add: aSpeedUpCell.
	
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
		
	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling: (OrderedCollection with: (LoadedDie of: #( 3 9 3 )))
		              on: aBoard
		              with: 2 managedBy: aCroupier controlledBy: aPenalizer.
		
	aBoardGame throw: aReversalCard from: 'Vicky' affectingOnCell: aNoEffectCell.

	aBoardGame playTurnFor: 'Vicky'.
	
	aBoardGame throw: aReversalCard from: 'Cami' affectingOnCell: aSpeedUpCell.
	aBoardGame playTurnFor: 'Cami'.
	
	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 4.

	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 6.
]

{ #category : #tests }
ReversalCardTest >> test03WhenASpaceshipThrowsAReversalCardAffectingWormHoleEffectThenWormHoleForwardsFourPositions [

	| spaceships aBoard aBoardGame cellEffects aMoonWalkEffect aWormHoleCell |
	
	aMoonWalkEffect := MoonWalkEffect with: 5.
	aWormHoleCell := Cell on: 6 of: WormHoleEffect new.
	
	cellEffects := OrderedCollection new.
	cellEffects add: (Cell on: 1 of: NoEffect new).
	cellEffects add: (Cell on: 2 of: NoEffect new).
	cellEffects add: (Cell on: 3 of: HyperJumpEffect new).
	cellEffects add: (Cell on: 4 of: NoEffect new).
	cellEffects add: (Cell on: 5 of: DrawCardEffect new).
	cellEffects add: aWormHoleCell.
	cellEffects add: (Cell on: 7 of: NoEffect new).
	cellEffects add: (Cell on: 8 of: aMoonWalkEffect).
	cellEffects add: (Cell on: 9 of: AtomicBombEffect new).
	cellEffects add: (Cell on: 10 of: SpeedUpEffect new).
	
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
		
	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling: (OrderedCollection with: (LoadedDie of: #( 5 9 3 )))
		              on: aBoard
		              with: 2 managedBy: aCroupier controlledBy: aPenalizer.
		
	aBoardGame throw: aReversalCard from: 'Vicky' affectingOnCell: aWormHoleCell.

	aBoardGame playTurnFor: 'Vicky'.
	
	aBoardGame playTurnFor: 'Cami'.
	
	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 10.

	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 4.
]

{ #category : #tests }
ReversalCardTest >> test04ASpaceshipThrowsAReservalCardAffectingHyperJumpCellThenSpaceshipsAffected [

	| spaceships aBoard aBoardGame cellEffects aHyperJumpEffect aHyperJumpCell |
	
	cellEffects := OrderedCollection new.
	aHyperJumpEffect := HyperJumpEffect with: (OrderedCollection with: (Parsec of: 5)).
	aHyperJumpCell := Cell on: 2 of: aHyperJumpEffect.
	cellEffects add: (Cell on: 1 of: NoEffect new).
	cellEffects add: aHyperJumpCell.
	cellEffects add: (Cell on: 3 of: NoEffect new).
	cellEffects add: (Cell on: 4 of: NoEffect new).
	cellEffects add: (Cell on: 5 of: NoEffect new).
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
		
	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling: (OrderedCollection with: (LoadedDie of: #( 6 3 3 )))
		              on: aBoard
		              with: 3 managedBy: aCroupier controlledBy: aPenalizer.
		
	aBoardGame throw: aReversalCard from: 'Vicky' affectingOnCell: aHyperJumpCell.

	aBoardGame playTurnFor: 'Vicky'.
	
	aBoardGame playTurnFor: 'Cami'.
	
	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 5.
		self assert: (aBoardGame spaceshipPosition: 'Vicky') round
		equals: 1.

	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 4.
]

{ #category : #tests }
ReversalCardTest >> test06WhenASpaceshipThrowsAReversalCardAffectingMoonWalkEffectThenSpaceshipsAffected [

	| spaceships aBoard aBoardGame cellEffects aMoonWalkEffect aMoonWalkCell|
	
	aMoonWalkEffect := MoonWalkEffect with: 5.
	aMoonWalkCell := Cell on: 8 of: aMoonWalkEffect.
	
	cellEffects := OrderedCollection new.
	cellEffects add: (Cell on: 1 of: NoEffect new).
	cellEffects add: (Cell on: 2 of: NoEffect new).
	cellEffects add: (Cell on: 3 of: HyperJumpEffect new).
	cellEffects add: (Cell on: 4 of: NoEffect new).
	cellEffects add: (Cell on: 5 of: DrawCardEffect new).
	cellEffects add: (Cell on: 6 of: WormHoleEffect new).
	cellEffects add: (Cell on: 7 of: NoEffect new).
	cellEffects add: aMoonWalkCell.
	cellEffects add: (Cell on: 9 of: AtomicBombEffect new).
	cellEffects add: (Cell on: 10 of: SpeedUpEffect new).
	
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
		
	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling: (OrderedCollection with: (LoadedDie of: #( 1 7 3 )))
		              on: aBoard
		              with: 2 managedBy: aCroupier controlledBy: aPenalizer.
		
	aBoardGame throw: aReversalCard from: 'Vicky' affectingOnCell: aMoonWalkCell .

	aBoardGame playTurnFor: 'Vicky'.
	
	aBoardGame playTurnFor: 'Cami'.
	
	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 7.

	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 8.
]

{ #category : #tests }
ReversalCardTest >> test07WhenASpaceshipThrowsReversalCardAffectingAtomicBombEffectThenSpaceshipsNotAffected [

	| spaceships aBoard aBoardGame cellEffects aMoonWalkEffect anAtomicBombCell|
	
	aMoonWalkEffect := MoonWalkEffect with: 5.
	
	anAtomicBombCell := Cell on: 9 of: AtomicBombEffect new.
	
	cellEffects := OrderedCollection new.
	cellEffects add: (Cell on: 1 of: NoEffect new).
	cellEffects add: (Cell on: 2 of: NoEffect new).
	cellEffects add: (Cell on: 3 of: HyperJumpEffect new).
	cellEffects add: (Cell on: 4 of: NoEffect new).
	cellEffects add: (Cell on: 5 of: DrawCardEffect new).
	cellEffects add: (Cell on: 6 of: WormHoleEffect new).
	cellEffects add: (Cell on: 7 of: NoEffect new).
	cellEffects add: (Cell on: 8 of: aMoonWalkEffect).
	cellEffects add: anAtomicBombCell.
	cellEffects add: (Cell on: 10 of: SpeedUpEffect new).
	
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
		
	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling: (OrderedCollection with: (LoadedDie of: #( 8 7 3 )))
		              on: aBoard
		              with: 2 managedBy: aCroupier controlledBy: aPenalizer.
		
	aBoardGame throw: aReversalCard from: 'Vicky' affectingOnCell: anAtomicBombCell.

	aBoardGame playTurnFor: 'Vicky'.
	
	aBoardGame playTurnFor: 'Cami'.
	
	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 1.

	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 8.
]

{ #category : #tests }
ReversalCardTest >> test08WhenASpaceshipThrowsReversalCardAffectingDrawCardEffectThenNoEffect [

	| spaceships aBoard aBoardGame cellEffects aMoonWalkEffect aDrawCardCell |
	
	aMoonWalkEffect := MoonWalkEffect with: 5.
	
	aDrawCardCell := Cell on: 5 of: DrawCardEffect new.
	
	cellEffects := OrderedCollection new.
	cellEffects add: (Cell on: 1 of: NoEffect new).
	cellEffects add: (Cell on: 2 of: NoEffect new).
	cellEffects add: (Cell on: 3 of: HyperJumpEffect new).
	cellEffects add: (Cell on: 4 of: NoEffect new).
	cellEffects add: aDrawCardCell.
	cellEffects add: (Cell on: 6 of: WormHoleEffect new).
	cellEffects add: (Cell on: 7 of: NoEffect new).
	cellEffects add: (Cell on: 8 of: aMoonWalkEffect).
	cellEffects add: (Cell on: 9 of: AtomicBombEffect new).
	cellEffects add: (Cell on: 10 of: SpeedUpEffect new).
	
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
		
	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling: (OrderedCollection with: (LoadedDie of: #( 4 7 3 )))
		              on: aBoard
		              with: 2 managedBy: aCroupier controlledBy: aPenalizer.
		
	aBoardGame throw: aReversalCard from: 'Vicky' affectingOnCell: aDrawCardCell.

	aBoardGame playTurnFor: 'Vicky'.
	
	aBoardGame playTurnFor: 'Cami'.
	
	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 1.

	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 8.
]

{ #category : #tests }
ReversalCardTest >> test09WhenASpaceshipThrowsReversalCardOnSpeedUpEffectAndOtherSpaceshipRevertsTheEffectThenSpaceshipsAffected [

	| spaceships aBoard aBoardGame cellEffects aSpeedUpCell|
	
	aSpeedUpCell := Cell on: 5 of: SpeedUpEffect new.
	
	cellEffects := OrderedCollection new.
	cellEffects add: (Cell on: 1 of: NoEffect new).
	cellEffects add: (Cell on: 2 of: NoEffect new).
	cellEffects add: (Cell on: 3 of: NoEffect new).
	cellEffects add: (Cell on: 4 of: NoEffect new).
	cellEffects add: aSpeedUpCell.

	
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.

	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling: (OrderedCollection with: (LoadedDie of: #( 4 4 3 )))
		              on: aBoard
		              with: 4 managedBy: aCroupier controlledBy: aPenalizer.
		
	aBoardGame throw: aReversalCard from: 'Vicky' affectingOnCell: aSpeedUpCell.

	aBoardGame playTurnFor: 'Vicky'.
	
	aBoardGame throw: aReversalCard from: 'Cami' affectingOnCell: aSpeedUpCell.
	
	aBoardGame playTurnFor: 'Cami'.
	
	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 1.

	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 4.
]

{ #category : #tests }
ReversalCardTest >> test10WheASpaceshipThrowsReversalCardAffectingWormHoleEffectAndOtherSpaceshipThrowsCancellationCardThenSpaceshipsAffected [

	| spaceships aBoard aBoardGame cellEffects aWormHoleCell |
	
	aWormHoleCell := Cell on: 5 of: WormHoleEffect new.
	
	cellEffects := OrderedCollection new.
	cellEffects add: (Cell on: 1 of: NoEffect new).
	cellEffects add: (Cell on: 2 of: NoEffect new).
	cellEffects add: (Cell on: 3 of: NoEffect new).
	cellEffects add: (Cell on: 4 of: NoEffect new).
	cellEffects add: aWormHoleCell.

	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.

	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling: (OrderedCollection with: (LoadedDie of: #( 4 4 3 )))
		              on: aBoard
		              with: 4 managedBy: aCroupier controlledBy: aPenalizer.
		
	aBoardGame throw: aReversalCard from: 'Vicky' affectingOnCell: aWormHoleCell.

	aBoardGame playTurnFor: 'Vicky'.
	
	aBoardGame throw: aCancellationCard from: 'Cami' choosing: aReversalCard.
	
	aBoardGame playTurnFor: 'Cami'.
	
	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 4.

	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 1.
]

{ #category : #tests }
ReversalCardTest >> test11WheASpaceshipThrowsReversalCardAffectingSpeedUpEffectAndOtherSpaceshipThrowsCancellationCardThenSpaceshipsAffected [

	| spaceships aBoard aBoardGame cellEffects aSpeedUpCell|
	
	aSpeedUpCell := Cell on: 5 of: SpeedUpEffect new.
	
	cellEffects := OrderedCollection new.
	cellEffects add: (Cell on: 1 of: NoEffect new).
	cellEffects add: (Cell on: 2 of: NoEffect new).
	cellEffects add: (Cell on: 3 of: NoEffect new).
	cellEffects add: (Cell on: 4 of: NoEffect new).
	cellEffects add: aSpeedUpCell.

	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.

	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling: (OrderedCollection with: (LoadedDie of: #( 4 4 3 )))
		              on: aBoard
		              with: 4 managedBy: aCroupier controlledBy: aPenalizer.
		
	aBoardGame throw: aReversalCard from: 'Vicky' affectingOnCell: aSpeedUpCell.

	aBoardGame playTurnFor: 'Vicky'.
	
	aBoardGame throw: aCancellationCard from: 'Cami' choosing: aReversalCard.
	
	aBoardGame playTurnFor: 'Cami'.
	
	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 1.

	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 4.
]

{ #category : #tests }
ReversalCardTest >> test12WheASpaceshipThrowsReversalCardAffectingHyperJumpEffectAndOtherSpaceshipThrowsCancellationCardThenSpaceshipsAffected [

	| spaceships aBoard aBoardGame cellEffects aHyperJumpEffect aHyperJumpCell|
	
	aHyperJumpEffect := HyperJumpEffect with: (OrderedCollection with: (Parsec of: 5)).
	
	aHyperJumpCell := Cell on: 5 of: aHyperJumpEffect.
	
	cellEffects := OrderedCollection new.
	cellEffects add: (Cell on: 1 of: NoEffect new).
	cellEffects add: (Cell on: 2 of: NoEffect new).
	cellEffects add: (Cell on: 3 of: NoEffect new).
	cellEffects add: (Cell on: 4 of: NoEffect new).
	cellEffects add: aHyperJumpCell.

	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.

	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling: (OrderedCollection with: (LoadedDie of: #( 4 4 3 )))
		              on: aBoard
		              with: 4 managedBy: aCroupier controlledBy: aPenalizer.
		
	aBoardGame throw: aReversalCard from: 'Vicky' affectingOnCell: aHyperJumpCell.

	aBoardGame playTurnFor: 'Vicky'.
	
	aBoardGame throw: aCancellationCard from: 'Cami' choosing: aReversalCard.
	
	aBoardGame playTurnFor: 'Cami'.
	
	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 3.
		
	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') round
		equals: 1.

	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 1.
	self
		assert: (aBoardGame spaceshipPosition: 'Cami') round
		equals: 2.
]

{ #category : #tests }
ReversalCardTest >> test13WheASpaceshipThrowsReversalCardAffectingMoonWalkEffectAndOtherSpaceshipThrowsCancellationCardThenSpaceshipsAffected [

	| spaceships aBoard aBoardGame cellEffects aMoonWalkEffect aMoonWalkCell|
	aMoonWalkEffect := MoonWalkEffect with: 5.
	
	aMoonWalkCell := (Cell on: 5 of: aMoonWalkEffect).
	
	cellEffects := OrderedCollection new.
	cellEffects add: (Cell on: 1 of: NoEffect new).
	cellEffects add: (Cell on: 2 of: NoEffect new).
	cellEffects add: (Cell on: 3 of: NoEffect new).
	cellEffects add: (Cell on: 4 of: NoEffect new).
	cellEffects add: aMoonWalkCell.

	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.

	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 4 4 3 )))
		              on: aBoard
		              with: 4
		              managedBy: aCroupier controlledBy: aPenalizer.

	aBoardGame throw: aReversalCard from: 'Vicky' affectingOnCell: aMoonWalkCell.

	aBoardGame playTurnFor: 'Vicky'.

	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 5.
	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 1.
	self
		assert: (aBoardGame spaceshipPosition: 'Cami') round
		equals: 2.

	aBoardGame
		throw: aCancellationCard
		from: 'Cami'
		choosing: aReversalCard.

	aBoardGame playTurnFor: 'Cami'.
	
	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 1.
	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 1.


]

{ #category : #tests }
ReversalCardTest >> test14WheASpaceshipThrowsReversalCardAffectingAtomicBombEffectAndOtherSpaceshipThrowsCancellationCardThenSpaceshipsAffected [

	| spaceships aBoard aBoardGame cellEffects anAtomicBombCell|
	
	anAtomicBombCell := Cell on: 5 of: AtomicBombEffect new.
	
	cellEffects := OrderedCollection new.
	cellEffects add: (Cell on: 1 of: NoEffect new).
	cellEffects add: (Cell on: 2 of: NoEffect new).
	cellEffects add: (Cell on: 3 of: NoEffect new).
	cellEffects add: (Cell on: 4 of: NoEffect new).
	cellEffects add: anAtomicBombCell.

	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.

	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling: (OrderedCollection with: (LoadedDie of: #( 4 4 3 )))
		              on: aBoard
		              with: 4 managedBy: aCroupier controlledBy: aPenalizer.
		
	aBoardGame throw: aReversalCard from: 'Vicky' affectingOnCell: anAtomicBombCell.

	aBoardGame playTurnFor: 'Vicky'.
	
	aBoardGame throw: aCancellationCard from: 'Cami' choosing: aReversalCard.
	
	aBoardGame playTurnFor: 'Cami'.
	
	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 1.

	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 1.
]

{ #category : #asserting }
ReversalCardTest >> test15WhenASpaceshipThrowsAReversalCardChoosingAnotherSpacheshipThenCannotThrowCard [

	| spaceships aBoard aBoardGame cellEffects |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.

	cellEffects := OrderedCollection new.
	cellEffects add: (Cell on: 1 of: NoEffect new).
	cellEffects add: (Cell on: 2 of: NoEffect new).
	cellEffects add: (Cell on: 3 of: NoEffect new).
	cellEffects add: (Cell on: 4 of: NoEffect new).
	cellEffects add: (Cell on: 5 of: DrawCardEffect new).
	cellEffects add: (Cell on: 6 of: NoEffect new).
	cellEffects add: (Cell on: 7 of: NoEffect new).
	cellEffects add: (Cell on: 8 of: NoEffect new).
	cellEffects add: (Cell on: 9 of: AtomicBombEffect new).
	cellEffects add: (Cell on: 10 of: SpeedUpEffect new).


	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 3 9 3 )))
		              on: aBoard
		              with: 2
		              managedBy: aCroupier controlledBy: aPenalizer.
	self
		should: [ aBoardGame throw: aReversalCard from: 'Vicky' to: 'Vicky' ]
		raise: Error
		withMessage: 'To play Reversal Card, please choose a cell'
]

{ #category : #asserting }
ReversalCardTest >> test16WhenASpaceshipThrowsReversalCardChoosingACardNumberThenCannotThrowCard [

	| spaceships aBoard aBoardGame cellEffects |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.

	cellEffects := OrderedCollection new.
	cellEffects add: (Cell on: 1 of: NoEffect new).
	cellEffects add: (Cell on: 2 of: NoEffect new).
	cellEffects add: (Cell on: 3 of: NoEffect new).
	cellEffects add: (Cell on: 4 of: NoEffect new).
	cellEffects add: (Cell on: 5 of: DrawCardEffect new).
	cellEffects add: (Cell on: 6 of: NoEffect new).
	cellEffects add: (Cell on: 7 of: NoEffect new).
	cellEffects add: (Cell on: 8 of: NoEffect new).
	cellEffects add: (Cell on: 9 of: AtomicBombEffect new).
	cellEffects add: (Cell on: 10 of: SpeedUpEffect new).


	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 3 9 3 )))
		              on: aBoard
		              with: 2
		              managedBy: aCroupier controlledBy: aPenalizer.
	self
		should: [ aBoardGame throw: aReversalCard from: 'Vicky' choosing: anOverloadCard]
		raise: Error
		withMessage: 'To play reversal card, please choose a cell'
]

{ #category : #asserting }
ReversalCardTest >> test17WhenASpaceshipThrowsReversalCardNotChoosingACellNumberThenCannotThrowCard [

	| spaceships aBoard aBoardGame cellEffects |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.

	cellEffects := OrderedCollection new.
	cellEffects add: (Cell on: 1 of: NoEffect new).
	cellEffects add: (Cell on: 2 of: NoEffect new).
	cellEffects add: (Cell on: 3 of: NoEffect new).
	cellEffects add: (Cell on: 4 of: NoEffect new).
	cellEffects add: (Cell on: 5 of: DrawCardEffect new).
	cellEffects add: (Cell on: 6 of: NoEffect new).
	cellEffects add: (Cell on: 7 of: NoEffect new).
	cellEffects add: (Cell on: 8 of: NoEffect new).
	cellEffects add: (Cell on: 9 of: AtomicBombEffect new).
	cellEffects add: (Cell on: 10 of: SpeedUpEffect new).


	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 3 9 3 )))
		              on: aBoard
		              with: 2
		              managedBy: aCroupier controlledBy: aPenalizer.
	self
		should: [ aBoardGame throw: aReversalCard from: 'Vicky'. ]
		raise: Error
		withMessage: 'To play Reversal Card, choose a cell'

]

{ #category : #tests }
ReversalCardTest >> test18WhenASpaceshipThrowsAReversalCardAffectingDrawCardEffectThenASpaceshipHasCardRemoved [

	| spaceships aBoard aBoardGame cellEffects aMoonWalkEffect anAtomicBombCell aDrawCardCell|
	
	aMoonWalkEffect := MoonWalkEffect with: 5.
	
	aDrawCardCell := Cell on: 5 of: DrawCardEffect new.
	
	anAtomicBombCell := Cell on: 9 of: AtomicBombEffect new.
	
	cellEffects := OrderedCollection new.
	cellEffects add: (Cell on: 1 of: NoEffect new).
	cellEffects add: (Cell on: 2 of: NoEffect new).
	cellEffects add: (Cell on: 3 of: HyperJumpEffect new).
	cellEffects add: (Cell on: 4 of: NoEffect new).
	cellEffects add: aDrawCardCell.
	cellEffects add: (Cell on: 6 of: WormHoleEffect new).
	cellEffects add: (Cell on: 7 of: NoEffect new).
	cellEffects add: (Cell on: 8 of: aMoonWalkEffect).
	cellEffects add: anAtomicBombCell.
	cellEffects add: (Cell on: 10 of: SpeedUpEffect new).
	
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
		
	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling: (OrderedCollection with: (LoadedDie of: #( 4 7 3 )))
		              on: aBoard
		              with: 2 managedBy: aCroupier controlledBy: aPenalizer.
	
	aBoardGame throw: aReversalCard from: 'Vicky' affectingOnCell: aDrawCardCell.

	aBoardGame playTurnFor: 'Vicky'.
	
	aBoardGame throw: aReversalCard from: 'Cami' affectingOnCell: anAtomicBombCell.
	
	aBoardGame playTurnFor: 'Cami'.
	
	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 1.

	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 8.
]
