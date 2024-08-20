/*
Adapter es un patrón de diseño estructural que permite
la colaboración de objetos incompatibles.
*/

USING System
BEGIN NAMESPACE RefactoringGuru.DesignPatterns.Adapter.Conceptual
	INTERFACE ITarget
		METHOD GetRequest AS STRING
	END INTERFACE
	
	CLASS Adaptee
		METHOD GetSpecificRequest AS STRING
			RETURN "Specific request."
		END METHOD
	END CLASS
	
	CLASS Adapter IMPLEMENTS ITarget
		PRIVATE _adaptee AS Adaptee
		
		CONSTRUCTOR (toAdaptee AS Adaptee)
			_adaptee := toAdaptee
		END CONSTRUCTOR
		
		METHOD GetRequest AS STRING
			RETURN "This is '" + _adaptee:GetSpecificRequest() + "'"
		END METHOD
	END CLASS
	
	CLASS Program
		STATIC METHOD Start AS VOID
			VAR loAdaptee := Adaptee{}			
			LOCAL loTarget := Adapter{loAdaptee} AS ITarget
			
			Console.WriteLine("Adaptee interface is incompatible with the client.")
			Console.WriteLine("But with adapter client can call it's method.")
			
			Console.WriteLine(loTarget:GetRequest())
		END METHOD
	END CLASS
END NAMESPACE
