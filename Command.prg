/*
 Command es un patrón de diseño de comportamiento que convierte solicitudes
 u operaciones simples en objetos.
*/
USING System

BEGIN NAMESPACE RefactoringGuru.DesignPatterns.Command.Conceptual
	
	INTERFACE ICommand
		METHOD Execute AS VOID
	END INTERFACE
	
	CLASS SimpleCommand IMPLEMENTS ICommand
		PRIVATE _payload := String.Empty AS STRING
		
		CONSTRUCTOR(tcPayload AS STRING)
			_payload := tcPayload
		END CONSTRUCTOR
		
		METHOD Execute AS VOID
			? i"SimpleCommand: See, I can do simple things like printing ({_payload})"
		END METHOD
	END CLASS
	
	CLASS ComplexCommand IMPLEMENTS ICommand
		PRIVATE _receiver AS Receiver
		PRIVATE _a AS STRING
		PRIVATE _b AS STRING
		
		
		CONSTRUCTOR(toReceiver AS Receiver, tcA AS STRING, tcB AS STRING)
			_receiver := toReceiver
			_a := tcA
			_b := tcB
		END CONSTRUCTOR
		
		METHOD Execute AS VOID
			? i"ComplexCommand: Complex stuff should be done by a receiver object."
			_receiver:DoSomething(_a)
			_receiver:DoSomething(_b)
		END METHOD
	END CLASS 
	
	CLASS Receiver
		METHOD DoSomething(tcA AS STRING) AS VOID
			? i"Receiver: Also working on ({tcA})."
		END METHOD
		
		METHOD DoSomethingElse(tcB AS STRING) AS VOID
			?i"Receiver: Also working on ({tcB})"
		END METHOD
	END CLASS
	
	CLASS Invoker
		PRIVATE _onStart AS ICommand
		PRIVATE _onFinish AS ICommand
		
		METHOD SetOnStart(toCommand AS ICommand) AS VOID
			_onStart := toCommand
		END METHOD
		
		METHOD SetOnFinish(toCommand AS ICommand) AS VOID
			_onFinish := toCommand
		END METHOD
		
		METHOD DoSomethingImportant AS VOID
			?"Invoker: Does anybody want something done before I begin?"
			IF _onStart IS ICommand
				_onStart:Execute()
			ENDIF
			?"Invoker: ...doing something really important..."
			IF _onFinish IS ICommand
				_onFinish:Execute()
			ENDIF 
		END METHOD
	END CLASS
	
	
	
	CLASS Program
		STATIC METHOD Start AS VOID
			VAR loInvoker := Invoker{}
			loInvoker:SetOnStart(SimpleCommand{"Say Hi!"})
			
			VAR loReceiver := Receiver{}
			loInvoker:SetOnFinish(ComplexCommand{loReceiver, "Send email", "Save report"})
			loInvoker:DoSomethingImportant()
		END METHOD
	END CLASS
		
END NAMESPACE
