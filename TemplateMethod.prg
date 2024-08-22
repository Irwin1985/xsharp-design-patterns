/*
 Template Method es un patrón de diseño de comportamiento que te permite definir
 el esqueleto de un algoritmo en una clase base y permite a las subclases sobrescribir
 los pasos sin cambiar la estructura general del algoritmo.
*/

USING System

BEGIN NAMESPACE RefactoringGuru.DesignPatterns.TemplateMethod.Conceptual
	ABSTRACT CLASS AbstractClass
		METHOD TemplateMethod AS VOID
			BaseOperation1()
			RequiredOperations1()
			BaseOperation2()
			Hook1()
			RequiredOperations2()
			BaseOperation3()
			Hook2()
		END METHOD
		
		PROTECTED METHOD BaseOperation1 AS VOID
			?"AbstractClass says: I am doing the bulk of the work"
		END METHOD
		PROTECTED METHOD BaseOperation2 AS VOID
			?"AbstractClass says: But I let subclasses override some operations"
		END METHOD
		PROTECTED METHOD BaseOperation3 AS VOID
			?"AbstractClass says: But I am doing the bulk of the work anyway"
		END METHOD
		
		PROTECTED ABSTRACT METHOD RequiredOperations1 AS VOID
		PROTECTED ABSTRACT METHOD RequiredOperations2 AS VOID
		
		PROTECTED VIRTUAL METHOD Hook1 AS VOID
		PROTECTED VIRTUAL METHOD Hook2 AS VOID		
	END CLASS
	
	CLASS ConcreteClass1 INHERIT AbstractClass
		PROTECTED OVERRIDE METHOD RequiredOperations1 AS VOID
			?"ConcreteClass1 says: Implemented Operation1"
		END METHOD 
		
		PROTECTED OVERRIDE METHOD RequiredOperations2 AS VOID
			?"ConcreteClass1 says: Implemented Operation2"
		END METHOD				
	END CLASS

	CLASS ConcreteClass2 INHERIT AbstractClass
		PROTECTED OVERRIDE METHOD RequiredOperations1 AS VOID
			?"ConcreteClass2 says: Implemented Operation1"
		END METHOD 
		
		PROTECTED OVERRIDE METHOD RequiredOperations2 AS VOID
			?"ConcreteClass2 says: Implemented Operation2"
		END METHOD
		
		PROTECTED OVERRIDE METHOD Hook1 AS VOID
			?"ConcreteClass2 says: Overriden Hook1"
		END METHOD				
	END CLASS
	
	CLASS Client
		STATIC METHOD ClientCode(toAbstractClass AS AbstractClass) AS VOID
			toAbstractClass:TemplateMethod()
		END METHOD
	END CLASS
	
	CLASS Program 
		STATIC METHOD Start AS VOID
			? "Same client code can work with different subclasses:"
			Client.ClientCode(ConcreteClass1{})
			Console.WriteLine(e"\n")
			
			? "Same client code can work with different subclasses:"
			Client.ClientCode(ConcreteClass2{})
			
		END METHOD
	END CLASS
END NAMESPACE
