Class {
	#name : #WormHoleEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
WormHoleEffect >> implementOn: aBoardGame [

	aBoardGame applyMovingEffect: -4.
]

{ #category : #reverse }
WormHoleEffect >> reverseEffectOn: aCell [ 
	aCell reverseEffect: SpeedUpEffect new.
]
