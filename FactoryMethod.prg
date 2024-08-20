/*
 Factory Method es un patrón de diseño creacional que resuelve el problema de crear objetos
 sin especificar sus clases concretas.

 El truco está en crear una clase abstracta que declare un método FactoryMethod que devuelva
 no una clase concreta sino una interfaz; delegando así la implementación del código a las
 subclases interesadas.

*/
USING System

BEGIN NAMESPACE RefactoringGuru.DesignPatterns.FactoryMethod.Conceptual
	/*
	  	La clase Creator declara el método FactoryMethod() que se supone
		retornará un objeto de la clase Product. Las subclases o clases
		derivadas son las responsables de añadir el código de implementación.
	*/
	ABSTRACT CLASS Creator
		PUBLIC ABSTRACT METHOD FactoryMethod AS IProduct
		/*
		  Tenga en cuenta también que, a pesar de su nombre, la responsabilidad
		  principal de esta clase Creator, no es solamente crear productos, también
 		  puede contener lógica empresarial relacionada con ese objeto. Las subclases
		  pueden cambiar indirectamente esa logica y anular el código de fábrica.
		*/ 
		PUBLIC METHOD SomeOperation AS STRING
			VAR loProduct := FactoryMethod()
			VAR lcResult := "Creator: The same creator's code has just worked with " + loProduct:Operation()
			RETURN lcResult
		END METHOD
	END CLASS
	
	// Clase concreta o subclase de Creator	
	CLASS ConcreteCreator1 INHERIT Creator
		PUBLIC OVERRIDE METHOD FactoryMethod AS IProduct
			RETURN ConcreteProduct1{}
		END METHOD
	END CLASS     
	
	CLASS ConcreteCreator2 INHERIT Creator
		PUBLIC OVERRIDE METHOD FactoryMethod AS IProduct
			RETURN ConcreteProduct2{}
		END METHOD
	END CLASS
	
	PUBLIC INTERFACE IProduct
		METHOD Operation AS STRING
	END INTERFACE
	
	CLASS ConcreteProduct1 IMPLEMENTS IProduct
		PUBLIC METHOD Operation AS STRING
			RETURN "{Result of ConcreteProduct1}"
		END METHOD
	END CLASS
	
	CLASS ConcreteProduct2 IMPLEMENTS IProduct
		PUBLIC METHOD Operation AS STRING
			RETURN "{Result of ConcreteProduct2}"
		END METHOD
	END CLASS
	
	CLASS Client
		PUBLIC METHOD Main AS VOID
			Console.WriteLine("App: Lauched with the ConcreteCreator1.")
			ClientCode(ConcreteCreator1{})
			
			Console.WriteLine("")
			
			Console.WriteLine("App: Launched with the ConcreteCreator2.")
			ClientCode(ConcreteCreator2{})
		END METHOD
		
		PUBLIC METHOD ClientCode(toCreator AS Creator) AS VOID
			Console.WriteLine(ei"Client: I'm not aware of the creator's class, but it still works.\n"+toCreator:SomeOperation())
		END METHOD
	END CLASS
	
	
	
	CLASS Program
		STATIC METHOD Start AS VOID
			Client{}:Main()
		END METHOD
	END CLASS
END NAMESPACE
