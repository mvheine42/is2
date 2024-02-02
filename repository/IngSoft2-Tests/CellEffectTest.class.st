Class {
	#name : #CellEffectTest,
	#superclass : #TestCase,
	#instVars : [
		'aDeckOfCards',
		'aCroupier',
		'aReversalCard',
		'aCancellationCard'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #running }
CellEffectTest >> setUp [

	super setUp.

	aReversalCard := ReversalCard new.
	aCancellationCard := CancellationCard new.
	aDeckOfCards := DeckOfCards with: (OrderedCollection
			                 with: aReversalCard
			                 with: aCancellationCard).
			
	aCroupier := Croupier handling: aDeckOfCards.
]

{ #category : #tests }
CellEffectTest >> test01WhenACellIsSpeedUpThenSpaceshipMovesFourPositions [

	| spaceships aBoard aBoardGame cellEffects |
	cellEffects := OrderedCollection new.

	cellEffects add: (Cell on: 1 of: NoEffect new).
	cellEffects add: (Cell on: 2 of: SpeedUpEffect new).
	cellEffects add: (Cell on: 3 of: NoEffect new).

	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.

	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 1 3 )))
		              on: aBoard
		              with: 2 managedBy: aCroupier.
		

	aBoardGame playTurnFor: 'Vicky'.

	self assert: (aBoardGame spaceshipPosition: 'Vicky')cellNumber equals: 3.
	self assert: (aBoardGame spaceshipPosition: 'Vicky')round equals: 2.
]

{ #category : #tests }
CellEffectTest >> test02WhenACellSpeedUpThenSpaceshipMovesTwoRounds [

	| spaceships aBoard aBoardGame cellEffects |
	cellEffects := OrderedCollection new.

	cellEffects add: (Cell on: 1 of: NoEffect new).
	cellEffects add: (Cell on: 2 of: NoEffect new).
	cellEffects add: (Cell on: 3 of: SpeedUpEffect new).

	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	
	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 2 2 1 )))
		              on: aBoard
		              with: 4 managedBy: aCroupier.

	aBoardGame playTurnFor: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 1.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 3.
]

{ #category : #tests }
CellEffectTest >> test03WhenAllSpaceshipsLandOnSpeedUpCellsThenEffectIsApplied [

	| spaceships aBoard aBoardGame cellEffects |
	cellEffects := OrderedCollection new.
	cellEffects add: (Cell on: 1 of: NoEffect new).
	cellEffects add: (Cell on: 2 of: SpeedUpEffect new).
	cellEffects add: (Cell on: 3 of: SpeedUpEffect new).
	cellEffects add: (Cell on: 4 of: NoEffect new).
	cellEffects add: (Cell on: 5 of: NoEffect new).
	cellEffects add: (Cell on: 6 of: NoEffect new).
	cellEffects add: (Cell on: 7 of: SpeedUpEffect new).
	cellEffects add: (Cell on: 8 of: NoEffect new).
	cellEffects add: (Cell on: 9 of: NoEffect new).
	cellEffects add: (Cell on: 10 of: NoEffect new).
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	
	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 1 )))
		              on: aBoard
		              with: 4 managedBy: aCroupier.

	aBoardGame playTurnFor: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 6.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1.

	aBoardGame playTurnFor: 'Cami'.
	self assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber equals: 7.
	self assert: (aBoardGame spaceshipPosition: 'Cami') round equals: 1.

	aBoardGame playTurnFor: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 1.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 2
]

{ #category : #tests }
CellEffectTest >> test04WhenACellIsWormHoleThenSpaceshipMovesBackwardsFourPositions [

	| spaceships aBoard aBoardGame cellEffects |
	cellEffects := OrderedCollection new.

	cellEffects add: (Cell on: 1 of: NoEffect new).
	cellEffects add: (Cell on: 2 of: NoEffect new).
	cellEffects add: (Cell on: 3 of: NoEffect new).
	cellEffects add: (Cell on: 4 of: NoEffect new).
	cellEffects add: (Cell on: 5 of: NoEffect new).
	cellEffects add: (Cell on: 6 of: WormHoleEffect new).
	cellEffects add: (Cell on: 7 of: NoEffect new).
	cellEffects add: (Cell on: 8 of: NoEffect new).
	cellEffects add: (Cell on: 9 of: NoEffect new).
	cellEffects add: (Cell on: 10 of: NoEffect new).

	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	
	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 5 1 3 )))
		              on: aBoard
		              with: 2 managedBy: aCroupier.

	aBoardGame playTurnFor: 'Vicky'.

	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 2.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1
]

{ #category : #tests }
CellEffectTest >> test05WhenABoardOfTwoCellsAndASpaceshipLandsOnWormHoleThenGoesBackTwoRounds [

	| spaceships aBoard aBoardGame cellEffects |
	cellEffects := OrderedCollection new.

	cellEffects add: (Cell on: 1 of: WormHoleEffect new).
	cellEffects add: (Cell on: 2 of: NoEffect new).

	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
		
	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 4 1 3 )))
		              on: aBoard
		              with: 4 managedBy: aCroupier.
		

	aBoardGame playTurnFor: 'Vicky'.

	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 1.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1
]

{ #category : #tests }
CellEffectTest >> test06WhenASpaceshipInRoundOneLandsOnWormHoleAndInPositionLessThanFourThenGoesToStart [

	| spaceships aBoard aBoardGame cellEffects |
	cellEffects := OrderedCollection new.

	cellEffects add: (Cell on: 1 of: NoEffect new).
	cellEffects add: (Cell on: 2 of: NoEffect new).
	cellEffects add: (Cell on: 3 of: WormHoleEffect new).
	cellEffects add: (Cell on: 4 of: NoEffect new).
	cellEffects add: (Cell on: 5 of: NoEffect new).
	cellEffects add: (Cell on: 6 of: NoEffect new).
	cellEffects add: (Cell on: 7 of: NoEffect new).
	cellEffects add: (Cell on: 8 of: NoEffect new).
	cellEffects add: (Cell on: 9 of: NoEffect new).
	cellEffects add: (Cell on: 10 of: NoEffect new).

	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	
		
	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 2 1 3 )))
		              on: aBoard
		              with: 2 managedBy: aCroupier.

	aBoardGame playTurnFor: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 1.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1
]

{ #category : #tests }
CellEffectTest >> test07WhenACellIsAtomicBombThenSpaceshipsMovesBackwardsToStart [

	| spaceships aBoard aBoardGame cellEffects |
	cellEffects := OrderedCollection new.

	cellEffects add: (Cell on: 1 of: NoEffect new).
	cellEffects add: (Cell on: 2 of: NoEffect new).
	cellEffects add: (Cell on: 3 of: NoEffect new).
	cellEffects add: (Cell on: 4 of: NoEffect new).
	cellEffects add: (Cell on: 5 of: NoEffect new).
	cellEffects add: (Cell on: 6 of: AtomicBombEffect new).
	cellEffects add: (Cell on: 7 of: NoEffect new).
	cellEffects add: (Cell on: 8 of: NoEffect new).
	cellEffects add: (Cell on: 9 of: NoEffect new).
	cellEffects add: (Cell on: 10 of: NoEffect new).

	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	
	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 5 1 3 )))
		              on: aBoard
		              with: 2 managedBy: aCroupier.

	aBoardGame playTurnFor: 'Vicky'.

	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 1.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1
]

{ #category : #tests }
CellEffectTest >> test08WhenACellIsAtomicBombThenAllSpaceshipsMovesBackwardsToStart [

	| spaceships aBoard aBoardGame cellEffects |
	cellEffects := OrderedCollection new.

	cellEffects add: (Cell on: 1 of: NoEffect new).
	cellEffects add: (Cell on: 2 of: NoEffect new).
	cellEffects add: (Cell on: 3 of: NoEffect new).
	cellEffects add: (Cell on: 4 of: NoEffect new).
	cellEffects add: (Cell on: 5 of: NoEffect new).
	cellEffects add: (Cell on: 6 of: AtomicBombEffect new).
	cellEffects add: (Cell on: 7 of: NoEffect new).
	cellEffects add: (Cell on: 8 of: NoEffect new).
	cellEffects add: (Cell on: 9 of: NoEffect new).
	cellEffects add: (Cell on: 10 of: NoEffect new).

	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	
	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 2 1 3 )))
		              on: aBoard
		              with: 2 managedBy: aCroupier.

	aBoardGame playTurnFor: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 3.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1.

	aBoardGame playTurnFor: 'Cami'.
	self assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber equals: 2.
	self assert: (aBoardGame spaceshipPosition: 'Cami') round equals: 1.

	aBoardGame playTurnFor: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 1.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1.

	self assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber equals: 1.
	self assert: (aBoardGame spaceshipPosition: 'Cami') round equals: 1
]

{ #category : #tests }
CellEffectTest >> test09WhenACellIsAtomicBombThenSpaceshipsMovesBackwardsAndRoundDoesNotChange [

	| spaceships aBoard aBoardGame cellEffects |
	cellEffects := OrderedCollection new.

	cellEffects add: (Cell on: 1 of: NoEffect new).
	cellEffects add: (Cell on: 2 of: NoEffect new).
	cellEffects add: (Cell on: 3 of: NoEffect new).
	cellEffects add: (Cell on: 4 of: AtomicBombEffect new).
	cellEffects add: (Cell on: 5 of: NoEffect new).

	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	
	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 11 2 3 )))
		              on: aBoard
		              with: 4 managedBy: aCroupier.
	
	aBoardGame playTurnFor: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 2.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 3.
	
	aBoardGame playTurnFor: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 1.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 3.
]

{ #category : #tests }
CellEffectTest >> test10WhenASpaceshipLandsOnMoonWalkThenOtherSpaceshipsChangePositions [

	| spaceships aBoard aBoardGame cellEffects aMoonWalkEffect |
	cellEffects := OrderedCollection new.
	aMoonWalkEffect := MoonWalkEffect with: 5.

	cellEffects add: (Cell on: 1 of: NoEffect new).
	cellEffects add: (Cell on: 2 of: NoEffect new).
	cellEffects add: (Cell on: 3 of: NoEffect new).
	cellEffects add: (Cell on: 4 of: NoEffect new).
	cellEffects add: (Cell on: 5 of: NoEffect new).
	cellEffects add: (Cell on: 6 of: aMoonWalkEffect).
	cellEffects add: (Cell on: 7 of: NoEffect new).
	cellEffects add: (Cell on: 8 of: NoEffect new).
	cellEffects add: (Cell on: 9 of: NoEffect new).
	cellEffects add: (Cell on: 10 of: NoEffect new).


	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
		
	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 7 5 3 )))
		              on: aBoard
		              with: 2 managedBy: aCroupier.

	aBoardGame playTurnFor: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 8.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1.

	aBoardGame playTurnFor: 'Cami'.
	self assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber equals: 6.
	self assert: (aBoardGame spaceshipPosition: 'Cami') round equals: 1.

	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 3.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1
]

{ #category : #tests }
CellEffectTest >> test11WhenASpaceshipsLandOnWormHoleEffectAndLandsOnCellWithEffectThenEffectNotApplied [

	| spaceships aBoard aBoardGame cellEffects |
	cellEffects := OrderedCollection new.

	cellEffects add: (Cell on: 1 of: NoEffect new).
	cellEffects add: (Cell on: 2 of: SpeedUpEffect new).
	cellEffects add: (Cell on: 3 of: NoEffect new).
	cellEffects add: (Cell on: 4 of: NoEffect new).
	cellEffects add: (Cell on: 5 of: NoEffect new).
	cellEffects add: (Cell on: 6 of: WormHoleEffect new).
	cellEffects add: (Cell on: 7 of: NoEffect new).
	cellEffects add: (Cell on: 8 of: NoEffect new).
	cellEffects add: (Cell on: 9 of: NoEffect new).
	cellEffects add: (Cell on: 10 of: NoEffect new).

	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	
	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 5 1 3 )))
		              on: aBoard
		              with: 2 managedBy: aCroupier.

	aBoardGame playTurnFor: 'Vicky'.

	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 2.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1
]

{ #category : #tests }
CellEffectTest >> test12WhenAGameIsPlayedWithCellsEffectThenSpaceshipsRanking [

	| spaceships aBoard aBoardGame cellEffects |
	cellEffects := OrderedCollection new.

	cellEffects add: (Cell on: 1 of: NoEffect new).
	cellEffects add: (Cell on: 2 of: SpeedUpEffect new).
	cellEffects add: (Cell on: 3 of: NoEffect new).
	cellEffects add: (Cell on: 4 of: NoEffect new).
	cellEffects add: (Cell on: 5 of: NoEffect new).
	cellEffects add: (Cell on: 6 of: WormHoleEffect new).
	cellEffects add: (Cell on: 7 of: NoEffect new).
	cellEffects add: (Cell on: 8 of: NoEffect new).
	cellEffects add: (Cell on: 9 of: NoEffect new).
	cellEffects add: (Cell on: 10 of: NoEffect new).

	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	spaceships add: 'Delfi'.
	
	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 5 1 3 )))
		              on: aBoard
		              with: 2 managedBy: aCroupier.

	aBoardGame playTurnFor: 'Vicky'.
	aBoardGame playTurnFor: 'Cami'.
	aBoardGame playTurnFor: 'Delfi'.

	self
		assert: aBoardGame ranking
		equals: (OrderedCollection with: 'Cami' with: 'Delfi' with: 'Vicky')
]

{ #category : #tests }
CellEffectTest >> test13ASpaceshipLandsOnHyperJumpThenMovesOneCell [

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
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 5 3 )))
		              on: aBoard
		              with: 2 managedBy: aCroupier.

	aBoardGame playTurnFor: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 3.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1
]

{ #category : #tests }
CellEffectTest >> test14ASpaceshipLandsOnHyperJumpThenMovesTwoRounds [

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
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 5 3 )))
		              on: aBoard
		              with: 2 managedBy: aCroupier.

	aBoardGame playTurnFor: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 3.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1
]

{ #category : #tests }
CellEffectTest >> test15ASpaceshipLandsOnHyperJumpThenMovesTwoCells [

	| spaceships aBoard aBoardGame cellEffects aHyperJumpEffect |
	cellEffects := OrderedCollection new.
	aHyperJumpEffect := HyperJumpEffect with: (OrderedCollection with: (Parsec of: 3)).
	cellEffects add: (Cell on: 1 of: NoEffect new).
	cellEffects add: (Cell on: 2 of: aHyperJumpEffect).
	cellEffects add: (Cell on: 3 of: NoEffect new).
	cellEffects add: (Cell on: 4 of: NoEffect new).
	cellEffects add: (Cell on: 5 of: NoEffect new).
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	
	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 5 3 )))
		              on: aBoard
		              with: 2 managedBy: aCroupier.

	aBoardGame playTurnFor: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 3.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1
]

{ #category : #tests }
CellEffectTest >> test16WhenTwoSpaceshipsLandsOnHyperJumpThenMovesToTheirNewPositions [

	| spaceships aBoard aBoardGame cellEffects |
	cellEffects := OrderedCollection new.
	cellEffects add: (Cell on: 1 of: NoEffect new).
	cellEffects add: (Cell
			 on: 2
			 of: (HyperJumpEffect with: (OrderedCollection with: (Parsec of: 6) with: (Parsec of: 5)))).
	cellEffects add: (Cell on: 3 of: NoEffect new).
	cellEffects add: (Cell on: 4 of: NoEffect new).
	cellEffects add: (Cell on: 5 of: NoEffect new).
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	
	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 1 3 )))
		              on: aBoard
		              with: 2 managedBy: aCroupier.

	aBoardGame playTurnFor: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 4.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1.

	aBoardGame playTurnFor: 'Cami'.
	self assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber equals: 3.
	self assert: (aBoardGame spaceshipPosition: 'Cami') round equals: 1.

	aBoardGame playTurnFor: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 4.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 2
]

{ #category : #tests }
CellEffectTest >> test17WhenASpaceshipLandsInAHyperJumpWithNegativeValuesThenMovesBackwards [

	| spaceships aBoard aBoardGame cellEffects aHyperJumpEffect |
	cellEffects := OrderedCollection new.
	aHyperJumpEffect := HyperJumpEffect with:
		                    (OrderedCollection with: (Parsec of: -4)).
	cellEffects add: (Cell on: 1 of: NoEffect new).
	cellEffects add: (Cell on: 2 of: NoEffect new).
	cellEffects add: (Cell on: 3 of: aHyperJumpEffect).
	cellEffects add: (Cell on: 4 of: NoEffect new).
	cellEffects add: (Cell on: 5 of: NoEffect new).
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	
	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 2 1 3 )))
		              on: aBoard
		              with: 2 managedBy: aCroupier.

	aBoardGame playTurnFor: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 1.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1
]

{ #category : #tests }
CellEffectTest >> test18WhenASpaceshipLandsInHyperJumpInRoundOneThenMovesToInitialPosition [

	| spaceships aBoard aBoardGame cellEffects aHyperJumpEffect |
	cellEffects := OrderedCollection new.
	aHyperJumpEffect := HyperJumpEffect with:
		                    (OrderedCollection with: (Parsec of: -5)).
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
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 1 3 )))
		              on: aBoard
		              with: 2 managedBy: aCroupier.

	aBoardGame playTurnFor: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 1.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1
]

{ #category : #tests }
CellEffectTest >> test19WhenSpaceshipLandsInHyperJumpThenGoesBackTwoRounds [

	| spaceships aBoard aBoardGame cellEffects aHyperJumpEffect |
	cellEffects := OrderedCollection new.
	aHyperJumpEffect := HyperJumpEffect with:
		                    (OrderedCollection with: (Parsec of: -30)).
	cellEffects add: (Cell on: 1 of: NoEffect new).
	cellEffects add: (Cell on: 2 of: aHyperJumpEffect).
	cellEffects add: (Cell on: 3 of: NoEffect new).
	cellEffects add: (Cell on: 4 of: NoEffect new).
	cellEffects add: (Cell on: 5 of: NoEffect new).

	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	
	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 10 1 3 )))
		              on: aBoard
		              with: 4 managedBy: aCroupier.

	aBoardGame playTurnFor: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 1.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 3.

	aBoardGame playTurnFor: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 2.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1
]

{ #category : #tests }
CellEffectTest >> test20WhenASpaceshipPlaysAnHyperJumpWithNegativeParsecValueThenGoesBack2Rounds [

	| spaceships aBoard aBoardGame cellEffects aHyperJumpEffect |
	cellEffects := OrderedCollection new.
	aHyperJumpEffect := HyperJumpEffect with:
		                    (OrderedCollection with: (Parsec of: -30)).
	cellEffects add: (Cell on: 1 of: NoEffect new).
	cellEffects add: (Cell on: 2 of: aHyperJumpEffect).
	cellEffects add: (Cell on: 3 of: NoEffect new).
	cellEffects add: (Cell on: 4 of: NoEffect new).
	cellEffects add: (Cell on: 5 of: NoEffect new).

	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	
	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 10 1 3 )))
		              on: aBoard
		              with: 4 managedBy: aCroupier.

	aBoardGame playTurnFor: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 1.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 3.

	aBoardGame playTurnFor: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 2.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1
]

{ #category : #tests }
CellEffectTest >> test21WhenThreeSpaceshipPlaysAndACellSpeedUpThenSpaceshipMovesWithEffect [

	| spaceships aBoard aBoardGame cellEffects |
	cellEffects := OrderedCollection new.

	cellEffects add: (Cell on: 1 of: NoEffect new).
	cellEffects add: (Cell on: 2 of: NoEffect new).
	cellEffects add: (Cell on: 3 of: SpeedUpEffect new).

	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	spaceships add: 'Delfi'.
	
	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 2 )))
		              on: aBoard
		              with: 4 managedBy: aCroupier.

	aBoardGame playTurnFor: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 1.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 3.
	
	aBoardGame playTurnFor: 'Cami'.
	self assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber equals: 1.
	self assert: (aBoardGame spaceshipPosition: 'Cami') round equals: 3.
	
	aBoardGame playTurnFor: 'Delfi'.
	self assert: (aBoardGame spaceshipPosition: 'Delfi') cellNumber equals: 1.
	self assert: (aBoardGame spaceshipPosition: 'Delfi') round equals: 3
]

{ #category : #tests }
CellEffectTest >> test22WhenASpaceshipThrowsReversalCardOnSpeedUpCellThenSpaceshipGoesBackwardsWhenLandingOnCell [

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
CellEffectTest >> test23WhenASpaceshipThrowsReversalCardOnNoEffectCellAndOnSpeedUpCellThenOneReversesAndTheOtherDoesNot [

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
CellEffectTest >> test24WhenASpaceshipThrowsAReversalCardAffectingWormHoleEffectThenWormHoleForwardsFourPositions [

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
CellEffectTest >> test25ASpaceshipThrowsAReservalCardAffectingHyperJumpCellThenSpaceshipsAffected [

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
CellEffectTest >> test25WhenASpaceshipThrowsAReversalCardAffectingMoonWalkEffectThenSpaceshipsAffected [

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
CellEffectTest >> test26WhenASpaceshipThrowsReversalCardAffectingAtomicBombEffectThenSpaceshipsNotAffected [

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
CellEffectTest >> test27WhenASpaceshipThrowsReversalCardAffectingDrawCardEffectThenNoEffect [

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
CellEffectTest >> test28WhenASpaceshipThrowsReversalCardOnSpeedUpEffectAndOtherSpaceshipRevertsTheEffectThenSpaceshipsAffected [

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
CellEffectTest >> test29WheASpaceshipThrowsReversalCardAffectingWormHoleEffectAndOtherSpaceshipThrowsCancellationCardThenSpaceshipsAffected [

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
CellEffectTest >> test30WheASpaceshipThrowsReversalCardAffectingSpeedUpEffectAndOtherSpaceshipThrowsCancellationCardThenSpaceshipsAffected [

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
CellEffectTest >> test31WheASpaceshipThrowsReversalCardAffectingHyperJumpEffectAndOtherSpaceshipThrowsCancellationCardThenSpaceshipsAffected [

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
CellEffectTest >> test32WheASpaceshipThrowsReversalCardAffectingMoonWalkEffectAndOtherSpaceshipThrowsCancellationCardThenSpaceshipsAffected [

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
CellEffectTest >> test33WheASpaceshipThrowsReversalCardAffectingAtomicBombEffectAndOtherSpaceshipThrowsCancellationCardThenSpaceshipsAffected [

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
