/*
Bridge es un patrón de diseño estructural que divide la lógica
de negocio o una clase muy grande en jerarquías de clases
separadas que se pueden desarrollar independientemente.
*/

BEGIN NAMESPACE RegactoringGuru.DesignPatterns.Bridge.Conceptual
	CLASS Abstraction
		PROTECTED _implementation AS IImplementation
		
		CONSTRUCTOR(toImplementation AS IImplementation)
			_implementation := toImplementation
		END CONSTRUCTOR
		
		VIRTUAL METHOD Operation AS STRING
			RETURN e"Abstract: Base operation with:\n" + _implementation:OperationImplementation()
		END METHOD
	END CLASS
	
	CLASS ExtendedAbstraction INHERIT Abstraction
		CONSTRUCTOR(toImplementation AS IImplementation)
			SUPER(toImplementation)
		END CONSTRUCTOR
		
		OVERRIDE METHOD Operation AS STRING
			RETURN e"ExtendedAbstraction: Extended operation with:\n" + SUPER:_implementation:OperationImplementation()
		END METHOD
	END CLASS
	
	INTERFACE IImplementation
		METHOD OperationImplementation AS STRING
	END INTERFACE
	
	CLASS ConcreteImplementationA IMPLEMENTS IImplementation
		METHOD OperationImplementation AS STRING
			RETURN e"ConcreteImplementationA: The result in platform A.\n"
		END METHOD
	END CLASS
	
	CLASS ConcreteImplementationB IMPLEMENTS IImplementation
		METHOD OperationImplementation AS STRING
			RETURN e"ConcreteImplementationB: The result in platform B.\n"
		END METHOD
	END CLASS
	
	CLASS Client
		METHOD ClientCode(toAbstraction AS Abstraction) AS VOID
			?toAbstraction:Operation()
		END METHOD
	END CLASS
	
	CLASS Program
		STATIC METHOD Start AS VOID
			VAR loClient := Client{}
			LOCAL loAbstraction AS Abstraction
			
			loAbstraction := Abstraction{ ConcreteImplementationA{}}
			loClient:ClientCode(loAbstraction)
			
			Console.WriteLine()
			
			loAbstraction := Abstraction{ ConcreteImplementationB{}}
			loClient:ClientCode(loAbstraction)
		END METHOD
	END CLASS
END NAMESPACE
