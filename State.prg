/*
 State es un patrón de diseño de comportamiento que permite a un objeto
 cambiar de comportamiento cuando cambia su estado interno.
*/
USING System

BEGIN NAMESPACE RefactoringGuru.DesignPatterns.State.Conceptual
	CLASS Context
		PRIVATE _state := NULL AS State
		CONSTRUCTOR(toState AS State)
			TransitionTo(toState)
		END CONSTRUCTOR
		
		METHOD TransitionTo(toState AS State) AS VOID
			?"Context: Transition to " + toState:GetType():Name
			_state := toState
			_state:SetContext(SELF)
		END METHOD
		
		METHOD Request1 AS VOID
			_state:Handle1()
		END METHOD
		
		METHOD Request2 AS VOID
			_state:Handle2()
		END METHOD
	END CLASS
	
	ABSTRACT CLASS State
		PROTECTED _context AS Context
		METHOD SetContext(toContext AS Context) AS VOID
			_context := toContext
		END METHOD
		
		ABSTRACT METHOD Handle1 AS VOID
		ABSTRACT METHOD Handle2 AS VOID
	END CLASS
	
	CLASS ConcreteStateA INHERIT State
		OVERRIDE METHOD Handle1 AS VOID
			?"ConcreteStateA handles request1."
			?"ConcreteStateA wants to change the state of the context"
			_context:TransitionTo(ConcreteStateB{})
		END METHOD
		
		OVERRIDE METHOD Handle2 AS VOID
			?"ConcreteStateA handles request2"
		END METHOD
	END CLASS
	
	CLASS ConcreteStateB INHERIT State
		OVERRIDE METHOD Handle1 AS VOID
			?"ConcreteStateB handles request1"
		END METHOD
		
		OVERRIDE METHOD Handle2 AS VOID
			? "ConcreteStateB handles request2"
			? "ConcreteStateB wants to change the state of the context."
			_context:TransitionTo(ConcreteStateA{})
		END METHOD
	END CLASS 
	
	CLASS Program 
		STATIC METHOD Start AS VOID
			VAR loContext := Context{ConcreteStateA{}}
			loContext:Request1()
			loContext:Request2()
		END METHOD
	END CLASS
END NAMESPACE
