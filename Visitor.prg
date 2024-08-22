/*
 Visitor es un patrón de diseño de comportamiento que permite añadir nuevos
 comportamientos a una jerarquía de clases existente sin alterar el código.
*/
USING System
USING System.Collections.Generic

BEGIN NAMESPACE RefactoringGuru.DesignPatterns.Visitor.Conceptual
	INTERFACE IComponent
		METHOD Accept(toVisitor AS IVisitor) AS VOID
	END INTERFACE
	
	CLASS ConcreteComponentA IMPLEMENTS IComponent
		METHOD Accept(toVisitor AS IVisitor) AS VOID
			toVisitor:VisitConcreteComponentA(SELF)
		END METHOD
		
		METHOD ExclusiveMethodOfConcreteComponentA AS STRING
			RETURN "A"
		END METHOD
	END CLASS
	
	CLASS ConcreteComponentB IMPLEMENTS IComponent
		METHOD Accept(toVisitor AS IVisitor) AS VOID
			toVisitor:VisitConcreteComponentB(SELF)
		END METHOD
		
		METHOD SpecialMethodOfConcreteComponentB AS STRING
			RETURN "B"
		END METHOD
	END CLASS
	
	INTERFACE IVisitor
		METHOD VisitConcreteComponentA(toElement AS ConcreteComponentA) AS VOID
		METHOD VisitConcreteComponentB(toElement AS ConcreteComponentB) AS VOID
	END INTERFACE
	
	CLASS ConcreteVisitor1 IMPLEMENTS IVisitor
		METHOD VisitConcreteComponentA(toElement AS ConcreteComponentA) AS VOID
			?toElement:ExclusiveMethodOfConcreteComponentA() + "ConcreteVisitor1"
		END METHOD
		METHOD VisitConcreteComponentB(toElement AS ConcreteComponentB) AS VOID
			?toElement:SpecialMethodOfConcreteComponentB() + "ConcreteVisitor1"
		END METHOD
	END CLASS
	
	CLASS ConcreteVisitor2 IMPLEMENTS IVisitor
		METHOD VisitConcreteComponentA(toElement AS ConcreteComponentA) AS VOID
			?toElement:ExclusiveMethodOfConcreteComponentA() + "ConcreteVisitor2"
		END METHOD
		METHOD VisitConcreteComponentB(toElement AS ConcreteComponentB) AS VOID
			?toElement:SpecialMethodOfConcreteComponentB() + "ConcreteVisitor2"
		END METHOD
	END CLASS
	
	CLASS Client
		STATIC METHOD ClientCode(toComponents AS List<IComponent>, toVisitor AS IVisitor) AS VOID
			FOREACH VAR loComponent IN toComponents
				loComponent:Accept(toVisitor)
			END FOR
		END METHOD
	END CLASS
	
	CLASS Program
		STATIC METHOD Start AS VOID
			VAR loComponents := List<IComponent>{}{ConcreteComponentA{}, ConcreteComponentB{}}
			?"The client code works with all visitors via the base Visitor interface:"
			VAR loVisitor := ConcreteVisitor1{}
			Client.ClientCode(loComponents, loVisitor)
			
			Console.WriteLine()
			
			? "It allows the same client code to work with different types of visitors:"
			VAR loVisitor2 := ConcreteVisitor2{}
			Client.ClientCode(loComponents, loVisitor2)
			 
		END METHOD
	END CLASS
END NAMESPACE
