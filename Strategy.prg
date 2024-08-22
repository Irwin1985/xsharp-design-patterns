/*
 Strategy es un patrón de diseño de comportamiento que convierte un grupo de comportamientos 
 en objetos y los hace intercambiables dentro del objeto de contexto original
*/

USING System
USING System.Collections.Generic

BEGIN NAMESPACE RefactoringGuru.DesignPatterns.Strategy.Conceptual
	CLASS Context
		PRIVATE _strategy AS IStrategy
		CONSTRUCTOR
			NOP
		END CONSTRUCTOR
		
		CONSTRUCTOR(toStrategy AS IStrategy)
			_strategy := toStrategy
		END CONSTRUCTOR
		
		METHOD SetStrategy(toStrategy AS IStrategy) AS VOID
			_strategy := toStrategy
		END METHOD
		
		METHOD DoSomeBusinessLogic AS VOID
			?"Context: Sorting data using the strategy (nor sure how it'll do it)"
			VAR loResult := _strategy:DoAlgorithm(List<STRING>{}{"a", "b", "c", "d", "e"})
			
			VAR resultStr := string.Empty
			FOREACH VAR lcElement IN (List<STRING>)loResult
				resultStr += lcElement + ","
			END FOR
			?resultStr
		END METHOD
	END CLASS
	
	INTERFACE IStrategy
		METHOD DoAlgorithm(toData AS OBJECT) AS OBJECT
	END INTERFACE
	
	CLASS ConcreteStrategyA IMPLEMENTS IStrategy
		METHOD DoAlgorithm(toData AS OBJECT) AS OBJECT
			VAR list := (List<STRING>)toData
			list:Sort()
			RETURN list
		END METHOD
	END CLASS
	
	CLASS ConcreteStrategyB IMPLEMENTS IStrategy
		METHOD DoAlgorithm(toData AS OBJECT) AS OBJECT
			VAR list := (List<STRING>)toData
			list:Sort()
			list:Reverse()

			RETURN list			
		END METHOD
	END CLASS
	
	CLASS Program
		STATIC METHOD Start AS VOID
			VAR loContext := Context{}
			?"Client: Strategy is set to normal sorting."
			loContext:SetStrategy(ConcreteStrategyA{})
			loContext:DoSomeBusinessLogic()
			
			Console.WriteLine()
			
			?"Client: Strategy is set to reverse sorting."
			loContext:SetStrategy(ConcreteStrategyB{})
			loContext:DoSomeBusinessLogic()
		END METHOD
	END CLASS
END NAMESPACE
