/*
Mediator es un patrón de diseño de comportamiento que reduce
el acoplamiento entre los componentes de un programa haciendo que
se comuniquen indirectamente a través de un objeto mediador especial.
*/
USING System

BEGIN NAMESPACE RefactoringGuru.DesignPatterns.Mediator.Conceptual
	INTERFACE IMediator
		METHOD Notify(sender AS OBJECT, ev AS STRING) AS VOID
	END INTERFACE
	
	CLASS ConcreteMediator IMPLEMENTS IMediator
		PRIVATE _component1 AS Component1
		PRIVATE _component2 AS Component2
		
		CONSTRUCTOR(toComponent1 AS Component1, toComponent2 AS Component2)
			_component1 := toComponent1
			_component1:SetMediator(SELF)
			_component2 := toComponent2
			_component2:SetMediator(SELF)
		END CONSTRUCTOR
		
		METHOD Notify(sender AS OBJECT, ev AS STRING) AS VOID
			IF ev:Equals("A")
				?"Mediator reacts on A and triggers following operations:"
				_component2:DoC()
			ELSEIF ev:Equals("D")
				?"Mediator reacts on D and triggers following operations:"
				_component1:DoB()
				_component2:DoC()
			ENDIF
		END METHOD
	END CLASS
	
	CLASS BaseComponent
		PROTECTED _mediator AS IMediator
		CONSTRUCTOR(toMediator := NULL AS IMediator)
			_mediator := toMediator
		END CONSTRUCTOR
		
		METHOD SetMediator(toMediator AS IMediator) AS VOID
			_mediator := toMediator
		END METHOD
	END CLASS
	
	CLASS Component1 INHERIT BaseComponent
		METHOD DoA AS VOID
			?"Component1 does A."
			_mediator:Notify(SELF, "A")
		END METHOD
		
		METHOD DoB AS VOID
			?"Component1 does B."
			_mediator:Notify(SELF, "B")
		END METHOD				
	END CLASS
	
	CLASS Component2 INHERIT BaseComponent
		METHOD DoC AS VOID
			? "Component2 does C."
			_mediator:Notify(SELF, "C")
		END METHOD
		
		METHOD DoD AS VOID
			? "Component2 does D."
			_mediator:Notify(SELF, "D")
		END METHOD
	END CLASS
	
	CLASS Program
		STATIC METHOD Start AS VOID
			VAR loComponent1 := Component1{}
			VAR loComponent2 := Component2{}
			ConcreteMediator{loComponent1, loComponent2}
			? "Client triggers operation A."
			loComponent1:DoA()
			
			Console.WriteLine()
			
			? "Client triggers operation D."
			loComponent2:DoD()
		END METHOD
	END CLASS
END NAMESPACE
