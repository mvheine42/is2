Class {
	#name : #ReversalCardTest,
	#superclass : #TestCase,
	#instVars : [
		'aReversalCard',
		'aCancellationCard',
		'aDeckOfCards',
		'aCroupier'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #running }
ReversalCardTest >> setUp [
	
	super setUp.

	aReversalCard := ReversalCard new.
	aCancellationCard := CancellationCard new.
	aDeckOfCards := DeckOfCards with: (OrderedCollection
			                 with: aReversalCard
			                 with: aCancellationCard).
			
	aCroupier := Croupier handling: aDeckOfCards.
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

	| spaceships aBoard aBoardGame cellEffects aMoonWalkEffect|
	
	aMoonWalkEffect := MoonWalkEffect with: 5.
	
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
	cellEffects add: (Cell on: 10 of: SpeedUpEffect new).
	
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.

	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling: (OrderedCollection with: (LoadedDie of: #( 9 9 3 )))
		              on: aBoard
		              with: 2 managedBy: aCroupier.
		
	aBoardGame throw: aReversalCard from: 'Vicky' affectingOnCell: 10.

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

	| spaceships aBoard aBoardGame cellEffects aMoonWalkEffect|
	
	aMoonWalkEffect := MoonWalkEffect with: 5.
	
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
	cellEffects add: (Cell on: 10 of: SpeedUpEffect new).
	
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
		
	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling: (OrderedCollection with: (LoadedDie of: #( 3 9 3 )))
		              on: aBoard
		              with: 2 managedBy: aCroupier.
		
	aBoardGame throw: aReversalCard from: 'Vicky' affectingOnCell: 4.

	aBoardGame playTurnFor: 'Vicky'.
	
	aBoardGame throw: aReversalCard from: 'Cami' affectingOnCell: 10.
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

	| spaceships aBoard aBoardGame cellEffects aMoonWalkEffect|
	
	aMoonWalkEffect := MoonWalkEffect with: 5.
	
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
	cellEffects add: (Cell on: 10 of: SpeedUpEffect new).
	
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
		
	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling: (OrderedCollection with: (LoadedDie of: #( 5 9 3 )))
		              on: aBoard
		              with: 2 managedBy: aCroupier.
		
	aBoardGame throw: aReversalCard from: 'Vicky' affectingOnCell: 6.

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

	| spaceships aBoard aBoardGame cellEffects aHyperJumpEffect |
	
	cellEffects := OrderedCollection new.
	aHyperJumpEffect := HyperJumpEffect with: (OrderedCollection with: (Parsec of: 5)).
	cellEffects add: (Cell on: 1 of: NoEffect new).
	cellEffects add: (Cell on: 2 of: aHyperJumpEffect).
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
		              with: 3 managedBy: aCroupier.
		
	aBoardGame throw: aReversalCard from: 'Vicky' affectingOnCell: 2.

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

	| spaceships aBoard aBoardGame cellEffects aMoonWalkEffect|
	
	aMoonWalkEffect := MoonWalkEffect with: 5.
	
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
	cellEffects add: (Cell on: 10 of: SpeedUpEffect new).
	
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
		
	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling: (OrderedCollection with: (LoadedDie of: #( 1 7 3 )))
		              on: aBoard
		              with: 2 managedBy: aCroupier.
		
	aBoardGame throw: aReversalCard from: 'Vicky' affectingOnCell: 8.

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

	| spaceships aBoard aBoardGame cellEffects aMoonWalkEffect|
	
	aMoonWalkEffect := MoonWalkEffect with: 5.
	
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
	cellEffects add: (Cell on: 10 of: SpeedUpEffect new).
	
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
		
	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling: (OrderedCollection with: (LoadedDie of: #( 8 7 3 )))
		              on: aBoard
		              with: 2 managedBy: aCroupier.
		
	aBoardGame throw: aReversalCard from: 'Vicky' affectingOnCell: 9.

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
ReversalCardTest >> test08WhenASpaceshipThrowsReversalCardAffectingAtomicBombEffectThenSpaceshipsNotAffected [

	| spaceships aBoard aBoardGame cellEffects aMoonWalkEffect|
	
	aMoonWalkEffect := MoonWalkEffect with: 5.
	
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
	cellEffects add: (Cell on: 10 of: SpeedUpEffect new).
	
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
		
	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling: (OrderedCollection with: (LoadedDie of: #( 8 7 3 )))
		              on: aBoard
		              with: 2 managedBy: aCroupier.
		
	aBoardGame throw: aReversalCard from: 'Vicky' affectingOnCell: 9.

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
ReversalCardTest >> test09WhenASpaceshipThrowsReversalCardAffectingDrawCardEffectThenNoEffect [

	| spaceships aBoard aBoardGame cellEffects aMoonWalkEffect|
	
	aMoonWalkEffect := MoonWalkEffect with: 5.
	
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
	cellEffects add: (Cell on: 10 of: SpeedUpEffect new).
	
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
		
	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling: (OrderedCollection with: (LoadedDie of: #( 4 7 3 )))
		              on: aBoard
		              with: 2 managedBy: aCroupier.
		
	aBoardGame throw: aReversalCard from: 'Vicky' affectingOnCell: 5.

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
ReversalCardTest >> test10WhenASpaceshipThrowsReversalCardOnSpeedUpEffectAndOtherSpaceshipRevertsTheEffectThenSpaceshipsAffected [

	| spaceships aBoard aBoardGame cellEffects|
	
	cellEffects := OrderedCollection new.
	cellEffects add: (Cell on: 1 of: NoEffect new).
	cellEffects add: (Cell on: 2 of: NoEffect new).
	cellEffects add: (Cell on: 3 of: NoEffect new).
	cellEffects add: (Cell on: 4 of: NoEffect new).
	cellEffects add: (Cell on: 5 of: SpeedUpEffect new).

	
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.

	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling: (OrderedCollection with: (LoadedDie of: #( 4 4 3 )))
		              on: aBoard
		              with: 4 managedBy: aCroupier.
		
	aBoardGame throw: aReversalCard from: 'Vicky' affectingOnCell: 5.

	aBoardGame playTurnFor: 'Vicky'.
	
	aBoardGame throw: aReversalCard from: 'Cami' affectingOnCell: 5.
	
	aBoardGame playTurnFor: 'Cami'.
	
	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 1.

	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 4.
]

{ #category : #tests }
ReversalCardTest >> test11WheASpaceshipThrowsReversalCardAffectingWormHoleEffectAndOtherSpaceshipThrowsCancellationCardThenSpaceshipsAffected [

	| spaceships aBoard aBoardGame cellEffects|
	
	cellEffects := OrderedCollection new.
	cellEffects add: (Cell on: 1 of: NoEffect new).
	cellEffects add: (Cell on: 2 of: NoEffect new).
	cellEffects add: (Cell on: 3 of: NoEffect new).
	cellEffects add: (Cell on: 4 of: NoEffect new).
	cellEffects add: (Cell on: 5 of: WormHoleEffect new).

	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.

	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling: (OrderedCollection with: (LoadedDie of: #( 4 4 3 )))
		              on: aBoard
		              with: 4 managedBy: aCroupier.
		
	aBoardGame throw: aReversalCard from: 'Vicky' affectingOnCell: 5.

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
ReversalCardTest >> test12WheASpaceshipThrowsReversalCardAffectingSpeedUpEffectAndOtherSpaceshipThrowsCancellationCardThenSpaceshipsAffected [

	| spaceships aBoard aBoardGame cellEffects|
	
	cellEffects := OrderedCollection new.
	cellEffects add: (Cell on: 1 of: NoEffect new).
	cellEffects add: (Cell on: 2 of: NoEffect new).
	cellEffects add: (Cell on: 3 of: NoEffect new).
	cellEffects add: (Cell on: 4 of: NoEffect new).
	cellEffects add: (Cell on: 5 of: SpeedUpEffect new).

	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.

	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling: (OrderedCollection with: (LoadedDie of: #( 4 4 3 )))
		              on: aBoard
		              with: 4 managedBy: aCroupier.
		
	aBoardGame throw: aReversalCard from: 'Vicky' affectingOnCell: 5.

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
ReversalCardTest >> test13WheASpaceshipThrowsReversalCardAffectingHyperJumpEffectAndOtherSpaceshipThrowsCancellationCardThenSpaceshipsAffected [

	| spaceships aBoard aBoardGame cellEffects aHyperJumpEffect|
	
	aHyperJumpEffect := HyperJumpEffect with: (OrderedCollection with: (Parsec of: 5)).
	
	cellEffects := OrderedCollection new.
	cellEffects add: (Cell on: 1 of: NoEffect new).
	cellEffects add: (Cell on: 2 of: NoEffect new).
	cellEffects add: (Cell on: 3 of: NoEffect new).
	cellEffects add: (Cell on: 4 of: NoEffect new).
	cellEffects add: (Cell on: 5 of: aHyperJumpEffect).

	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.

	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling: (OrderedCollection with: (LoadedDie of: #( 4 4 3 )))
		              on: aBoard
		              with: 4 managedBy: aCroupier.
		
	aBoardGame throw: aReversalCard from: 'Vicky' affectingOnCell: 5.

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
ReversalCardTest >> test14WheASpaceshipThrowsReversalCardAffectingMoonWalkEffectAndOtherSpaceshipThrowsCancellationCardThenSpaceshipsAffected [

	| spaceships aBoard aBoardGame cellEffects aMoonWalkEffect |
	aMoonWalkEffect := MoonWalkEffect with: 5.

	cellEffects := OrderedCollection new.
	cellEffects add: (Cell on: 1 of: NoEffect new).
	cellEffects add: (Cell on: 2 of: NoEffect new).
	cellEffects add: (Cell on: 3 of: NoEffect new).
	cellEffects add: (Cell on: 4 of: NoEffect new).
	cellEffects add: (Cell on: 5 of: aMoonWalkEffect).

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
		              managedBy: aCroupier.

	aBoardGame throw: aReversalCard from: 'Vicky' affectingOnCell: 5.

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
ReversalCardTest >> test15WheASpaceshipThrowsReversalCardAffectingAtomicBombEffectAndOtherSpaceshipThrowsCancellationCardThenSpaceshipsAffected [

	| spaceships aBoard aBoardGame cellEffects|
	
	cellEffects := OrderedCollection new.
	cellEffects add: (Cell on: 1 of: NoEffect new).
	cellEffects add: (Cell on: 2 of: NoEffect new).
	cellEffects add: (Cell on: 3 of: NoEffect new).
	cellEffects add: (Cell on: 4 of: NoEffect new).
	cellEffects add: (Cell on: 5 of: AtomicBombEffect new).

	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.

	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling: (OrderedCollection with: (LoadedDie of: #( 4 4 3 )))
		              on: aBoard
		              with: 4 managedBy: aCroupier.
		
	aBoardGame throw: aReversalCard from: 'Vicky' affectingOnCell: 5.

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
ReversalCardTest >> test16WhenASpaceshipThrowsAReversalCardChoosingAnotherSpacheshipThenCannotThrowCard [

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
		              managedBy: aCroupier.

	self
		should: [ aBoardGame throw: aReversalCard from: 'Vicky' to: 'Vicky' ]
		raise: Error
		withMessage: 'To play Reversal Card, please choose a cell number.'
]

{ #category : #asserting }
ReversalCardTest >> test17WhenASpaceshipThrowsReversalCardChoosingACardNumberThenCannotThrowCard [

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
		              managedBy: aCroupier.

	self
		should: [ aBoardGame throw: aReversalCard from: 'Vicky' choosing: 1 ]
		raise: Error
		withMessage: 'To play Reversal Card, please choose a cell number.'
]

{ #category : #asserting }
ReversalCardTest >> test18WhenASpaceshipThrowsReversalCardNotChoosingACellNumberThenCannotThrowCard [

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
		              managedBy: aCroupier.
	
	self
		should: [ aBoardGame throw: aReversalCard from: 'Vicky'. ]
		raise: Error
		withMessage: 'To play Reversal Card, choose a cell number'

]
