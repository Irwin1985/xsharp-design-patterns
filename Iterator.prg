/*
Iterator es un patrón de diseño de comportamiento que permite el recorrido secuencial
por una estructura de datos compleja sin exponer sus detalles internos.
*/

USING System
USING System.Collections
USING System.Collections.Generic

BEGIN NAMESPACE RefactoringGuru.DesignPatterns.Iterator.Conceptual
	ABSTRACT CLASS Iterator IMPLEMENTS IEnumerator
		PROPERTY IEnumerator.Current AS OBJECT GET Current()
		
		ABSTRACT METHOD Key AS INT
		
		ABSTRACT METHOD Current AS OBJECT
		
		ABSTRACT METHOD MoveNext AS LOGIC
	
		ABSTRACT METHOD Reset AS VOID
	END CLASS
	
	ABSTRACT CLASS IteratorAggregate IMPLEMENTS IEnumerable
		ABSTRACT METHOD GetEnumerator AS IEnumerator
	END CLASS
	
	CLASS AlphabeticalOrderIterator INHERIT Iterator
		PRIVATE _collection AS WordsCollection		
		PRIVATE _position := -1 AS INT		
		PRIVATE _reverse := FALSE AS LOGIC
		
		CONSTRUCTOR(toCollection AS WordsCollection, tbReverse := FALSE AS LOGIC)
			_collection := toCollection
			_reverse := tbReverse
			IF _reverse
				_position := _collection:getItems():Count
			ENDIF
		END CONSTRUCTOR 
		
		OVERRIDE METHOD Current AS OBJECT
			RETURN _collection:getItems()[_position]
		END METHOD
		
		OVERRIDE METHOD Key AS INT
			RETURN _position
		END METHOD
		
		OVERRIDE METHOD MoveNext AS LOGIC
			VAR updatedPosition := _position + iif(_reverse, -1, 1)
			IF updatedPosition >= 0 && updatedPosition < _collection:getItems():Count
				_position := updatedPosition
				RETURN TRUE
			ENDIF
			RETURN FALSE
		END METHOD 
		
		OVERRIDE METHOD Reset AS VOID
			_position := iif(_reverse, _collection:getItems():Count-1, 0)
		END METHOD
	END CLASS
	
	CLASS WordsCollection INHERIT IteratorAggregate
		PUBLIC _collection := List<STRING>{} AS List<STRING>
		PUBLIC _direction := FALSE AS LOGIC
		
		METHOD ReverseDirection AS VOID
			_direction := !_direction
		END METHOD
		
		METHOD getItems AS List<STRING>
			RETURN _collection
		END METHOD
		
		METHOD AddItem(tcItem AS STRING) AS VOID
			_collection:Add(tcItem)
		END METHOD
		
		OVERRIDE METHOD GetEnumerator AS IEnumerator
			RETURN AlphabeticalOrderIterator{SELF, _direction}
		END METHOD
	END CLASS
	
	CLASS Program		
		STATIC METHOD Start AS VOID
			VAR loCollection := WordsCollection{}
			loCollection:AddItem("First")
			loCollection:AddItem("Second")
			loCollection:AddItem("Third")
			
			?"Straight traversal:"
			
			FOREACH VAR loElement IN loCollection
				?loElement
			END FOR
			
			?e"\nReverse traversal:"
			
			loCollection:ReverseDirection()
			
			FOREACH VAR loElement IN loCollection
				?loElement
			END FOR
		END METHOD 
	END CLASS
END NAMESPACE
