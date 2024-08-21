/*  
 Memento es un patrón de diseño de comportamiento que permite tomer instantáneas del estado
 de un objeto y restaurarlo en el futuro.
*/
USING System
USING System.Collections.Generic
USING System.Linq
USING System.Threading

BEGIN NAMESPACE RefactoringGuru.DesignPatterns.Memento.Conceptual
	CLASS Originator
		PRIVATE _state AS STRING
		CONSTRUCTOR (tcState AS STRING)
			_state := tcState
		END CONSTRUCTOR
		
		METHOD DoSomething AS VOID
			? "Originator: I'm doing something important"
			_state := GenerateRandomString(30)
			? i"Originator: and my state has changed to: {_state}"
		END METHOD
		
		PRIVATE METHOD GenerateRandomString(tnLength := 10 AS INT) AS STRING
			VAR lcAllowedSymbols := "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
			VAR lcResult := string.Empty
			
			WHILE tnLength > 0
				lcResult += lcAllowedSymbols[Random{}:Next(0, lcAllowedSymbols:Length)]:ToString()
				Thread.Sleep(12)
				tnLength--
			END WHILE
			RETURN lcResult
		END METHOD
		
		METHOD Save AS IMemento
			RETURN ConcreteMemento{_state}
		END METHOD
		
		METHOD Restore(toMemento AS IMemento) AS VOID
			IF !(toMemento IS ConcreteMemento)
				THROW Exception{"Unknown memento class " + toMemento:ToString()}
			ENDIF
			_state := toMemento:GetState()
			? i"Originator: My state has changed to: {_state}"
		END METHOD
	END CLASS
	
	INTERFACE IMemento
		METHOD GetName AS STRING
		METHOD GetState AS STRING
		METHOD GetDate AS DateTime
	END INTERFACE
	
	CLASS ConcreteMemento IMPLEMENTS IMemento
		PRIVATE _state AS STRING
		PRIVATE _date AS DateTime
		
		CONSTRUCTOR(tcState AS STRING)
			_state := tcState
			_date := DateTime.Now
		END CONSTRUCTOR
		
		METHOD GetName AS STRING  
			RETURN _date:ToString() +  "/ (" + _state:SubString(0, 9) + ")..."
		END METHOD
		
		METHOD GetState AS STRING
			RETURN _state
		END METHOD
		
		METHOD GetDate AS DateTime
			RETURN _date
		END METHOD
	END CLASS 
	
	CLASS CareTaker
		PRIVATE _mementos := List<IMemento>{} AS List<IMemento>
		PRIVATE _originator := NULL AS Originator
		
		CONSTRUCTOR(toOriginator AS Originator)
			_originator := toOriginator
		END CONSTRUCTOR
		
		METHOD Backup AS VOID
			?e"\nCaretaker: Saving Originator's state..."
			_mementos:Add(_originator:Save())
		END METHOD
		
		METHOD Undo AS VOID
			IF _mementos:Count == 0
				RETURN
			ENDIF
			VAR loMemento := _mementos:Last()
			_mementos:Remove(loMemento)
			
			? "Caretaker: Restoring state to: " + loMemento:GetName()
			
			TRY
				_originator:Restore(loMemento)
			CATCH
				Undo()
			END TRY
		END METHOD
		
		METHOD ShowHistory AS VOID
			? "Caretaker: Here's the list of mementos"
			
			FOREACH VAR loMemento IN _mementos
				?loMemento:GetName()
			END FOR
		END METHOD
	END CLASS
	
	CLASS Program
		STATIC METHOD Start AS VOID
			VAR loOriginator := Originator{"Super-duper-super-puper-super."}
			VAR loCaretaker := CareTaker{loOriginator}
			
			loCaretaker:Backup()
			loOriginator:DoSomething()
			
			loCaretaker:Backup()
			loOriginator:DoSomething()
			
			loCaretaker:Backup()
			loOriginator:DoSomething()
			
			Console.WriteLine()
			loCaretaker:ShowHistory()
			
			?e"\nClient: Now, let's rollback!\n"
			loCaretaker:Undo()
			
			?e"\n\nClient: Once more!\n"
			loCaretaker:Undo()
			
			Console.WriteLine()
		END METHOD
	END CLASS
END NAMESPACE
