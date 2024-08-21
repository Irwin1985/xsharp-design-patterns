/*
Chain Of Responsability es un patrón de diseño de comportamiento que permite pasar solicitudes
a lo largo de la cadena de manejadores potenciales hasta que uno de ellos gestiona la solicitud.
*/

USING System
USING System.Collections.Generic

BEGIN NAMESPACE RefactoringGuru.DesignPatterns.ChainOfResponsability.Conceptual
	INTERFACE IHandler
		METHOD SetNext(toHandler AS IHandler) AS IHandler
		METHOD Handle(toRequest AS OBJECT) AS OBJECT
	END INTERFACE
	
	ABSTRACT CLASS AbstractHandler IMPLEMENTS IHandler
		PRIVATE _nextHandler AS IHandler
		
		METHOD SetNext(toHandler AS IHandler) AS IHandler
			_nextHandler := toHandler
			RETURN toHandler
		END METHOD
		
		VIRTUAL METHOD Handle(toRequest AS OBJECT) AS OBJECT
			IF _nextHandler != NULL
				RETURN _nextHandler:Handle(toRequest)
			ENDIF
			RETURN NULL
		END METHOD
	END CLASS 
	
	CLASS MonkeyHandler INHERIT AbstractHandler
		OVERRIDE METHOD Handle(toRequest AS OBJECT) AS OBJECT
			IF toRequest:ToString():Equals("Banana")
				RETURN "Monkey: I'll eat the " + toRequest:ToString()
			ENDIF
			RETURN SUPER:Handle(toRequest)
		END METHOD
	END CLASS

	CLASS SquirrelHandler INHERIT AbstractHandler
		OVERRIDE METHOD Handle(toRequest AS OBJECT) AS OBJECT
			IF toRequest:ToString():Equals("Nut")
				RETURN "Squirrel: I'll eat the " + toRequest:ToString()
			ENDIF
			RETURN SUPER:Handle(toRequest)
		END METHOD
	END CLASS

	CLASS DogHandler INHERIT AbstractHandler
		OVERRIDE METHOD Handle(toRequest AS OBJECT) AS OBJECT
			IF toRequest:ToString():Equals("MeatBall")
				RETURN "Squirrel: I'll eat the " + toRequest:ToString()
			ENDIF
			RETURN SUPER:Handle(toRequest)
		END METHOD
	END CLASS
	
	CLASS Client
		STATIC METHOD ClientCode(toHandler AS AbstractHandler) AS VOID
			FOREACH lcFood AS STRING IN List<STRING>{}{"Nut", "Banana", "Cup of coffee"}
				Console.WriteLine(i"Client: Who wants a {lcFood}?")
				VAR lcResult := toHandler:Handle(lcFood)
				IF lcResult != NULL
					Console.WriteLine(lcResult)
				ELSE 
					Console.WriteLine(i"{lcFood} was left untouched.")
				ENDIF
			END FOR
		END METHOD
	END CLASS
	
		
	CLASS Program
		STATIC METHOD Start AS VOID
			VAR loMonkey := MonkeyHandler{}
			VAR loSquirrel := SquirrelHandler{}
			VAR loDog := DogHandler{}
			
			loMonkey:SetNext(loSquirrel):SetNext(loDog);
			
			Console.WriteLine("Chain: Monkey->Squirrel->Dog")
			Client.ClientCode(loMonkey)
			Console.WriteLine()
			
			Console.WriteLine(e"Subchain: Squirrel > Dog\n")
			Client.ClientCode(loSquirrel)
		END METHOD
	END CLASS
END NAMESPACE
